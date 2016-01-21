package com.checker.cms.tools;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.checker.core.dao.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CheckerUserDetailsService implements UserDetailsService {
    
    @Resource
    private UserService userService;
    
    @Override
    public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
        log.debug("loadUserByUsername(" + name + ")");
        Set<GrantedAuthority> roles = new HashSet<>();
        String pwd = null;
        
        if ("admin".equals(name)) {
            pwd = "7110eda4d09e062aa5e4a390b0a572ac0d2c0220";
            roles.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
            // roles.add(new SimpleGrantedAuthority("MODERATOR"));
            // roles.add(new SimpleGrantedAuthority("OWNER"));
            // roles.add(new SimpleGrantedAuthority("CHECKER"));
        } else if ("user".equals(name)) {
            pwd = "7110eda4d09e062aa5e4a390b0a572ac0d2c0220";
            // roles.add(new SimpleGrantedAuthority("ADMIN"));
            roles.add(new SimpleGrantedAuthority("ROLE_MODERATOR"));
            // roles.add(new SimpleGrantedAuthority("OWNER"));
            // roles.add(new SimpleGrantedAuthority("CHECKER"));
        } else {
            throw new UsernameNotFoundException("User not found");
        }
        
        return new CheckerUserDetails(name, pwd, roles, 1232);
    }
    
}
