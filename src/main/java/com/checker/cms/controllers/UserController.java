package com.checker.cms.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.TaskService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.Task;
import com.checker.core.entity.User;
import com.checker.core.enums.UserAccess;
import com.checker.core.model.TupleHolder;
import com.checker.core.model.UserHolder;

@Slf4j
@Controller
@RequestMapping("users")
public class UserController {
    
    @Resource
    private UserService userService;
    @Resource
    private TaskService taskService;
    
    private Integer     idCompany = 1;
    
    @RequestMapping("list")
    public ModelAndView userList() {
        log.info("#UserList method(idCompany:" + idCompany + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        Map<Integer, TupleHolder<Long, Long>> infoMap = userService.findUserTasksInfoByIdCompanyAndAccess(idCompany);
        List<UserHolder> userInfoList = new ArrayList<>(userList.size());
        
        for (User user : userList) {
            UserHolder info = new UserHolder();
            info.setUser(user);
            TupleHolder<Long, Long> tuple = infoMap.get(user.getId());
            if (tuple != null) {
                info.setTasks(tuple.getValue1());
                info.setArticles(tuple.getValue2());
            }
            userInfoList.add(info);
        }
        
        ModelAndView m = new ModelAndView("users");
        m.addObject("pageName", "users");
        m.addObject("userInfoList", userInfoList);
        return m;
    }
    
    @RequestMapping("{id}/tasks/list")
    public ModelAndView userTasksList(@PathVariable("id") Integer idUser) {
        log.info("#UserTasksList method(idCompany:" + idCompany + ",idUser:" + idUser + ")#");
        List<Task> taskList = taskService.findTaskByIdUserAndIdCompany(idCompany, idUser);
        List<Task> taskListNobody = taskService.findTaskByIdCompanyWithoutUsers(idCompany);
        User user = userService.findUserByIdAndIdCompany(idCompany, idUser);
        ModelAndView m = new ModelAndView("usertask");
        m.addObject("pageName", "users");
        m.addObject("taskList", taskList);
        m.addObject("taskListNobody", taskListNobody);
        m.addObject("user", user);
        return m;
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String userUpdate(@RequestParam(value = "id", required = false) Integer idUser, @RequestParam("title") String title, @RequestParam("email") String email, @RequestParam("pwd") String pwd) {
        log.info("#UserUpdate method(idCompany:" + idCompany + ",idUser:" + idUser + ",title:" + title + ",email:" + email + ",pwd:" + pwd + ")#");
        if (StringUtils.isNotEmpty(title) && StringUtils.isNotEmpty(email) && StringUtils.isNotEmpty(pwd)) {
            if (idUser != null && idUser > 0) {
                userService.updateUser(idCompany, idUser, title, email, pwd);
            } else {
                User user = new User();
                user.setIdCompany(idCompany);
                user.setTitle(title);
                user.setEmail(email);
                user.setPwd(pwd);
                user.setDateAdded(DateTime.now());
                user.setAccessType(UserAccess.MOBILE.id());
                userService.saveUser(user);
            }
        }
        return "redirect:/users/list";
    }
    
    @RequestMapping(value = "tasks/assign", method = RequestMethod.POST)
    public String userTasksAssign(@RequestParam("id") Integer idUser, @RequestParam(value = "idtask[]", required = false) List<Long> idTaskList) throws IllegalStateException, IOException {
        log.info("#UserTasksAssign method(idCompany:" + idCompany + ",idUser:" + idUser + ",idTaskList:" + idTaskList + ")#");
        
        if (idUser != null && idUser > 0 && idTaskList != null) {
            for (Long idTask : idTaskList)
                taskService.assignTask(idCompany, idTask, idUser);
        }
        
        return "redirect:/users/" + idUser + "/tasks/list";
    }
    
}
