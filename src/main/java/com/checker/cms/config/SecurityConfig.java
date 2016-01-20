package com.checker.cms.config;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.checker.cms.tools.CheckerUserDetailsService;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Resource
    private ShaPasswordEncoder shaPasswordEncoder;
    
    @Bean
    public UserDetailsService getCheckerUserDetailsService() {
        return new CheckerUserDetailsService();
    }
    
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        log.debug("configure Auth.");
        auth.userDetailsService(getCheckerUserDetailsService()).passwordEncoder(shaPasswordEncoder);
    }
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        log.debug("configure HttpSecurity.");
        
        // http.authorizeRequests().anyRequest().permitAll();
        
        // @formatter:off
        http.csrf().disable()
            .authorizeRequests()
            .antMatchers("/report/**").hasRole("MODERATOR").anyRequest().authenticated()
            .anyRequest()
            .authenticated()
            .and();
        
        http.formLogin()
            .loginPage("/login").defaultSuccessUrl("/home", true)
            .failureUrl("/login?failed")
            .permitAll().and();
        
        http.logout()
            .logoutUrl("/logout")
            .logoutSuccessUrl("/login")
            .invalidateHttpSession(true)
            .permitAll().and();
        
        http.rememberMe().and();
        http.httpBasic();
        // @formatter:on
    }
    
    @Override
    public void configure(WebSecurity web) throws Exception {
        log.debug("configure WebSecurity.");
        web.ignoring().antMatchers("/resources/**");
    }
}
