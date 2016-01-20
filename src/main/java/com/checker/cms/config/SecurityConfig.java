package com.checker.cms.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        log.debug("configure Auth.");
        auth.inMemoryAuthentication().withUser("user").password("123").roles("USER");
        auth.inMemoryAuthentication().withUser("admin").password("123").roles("ADMIN");
    }
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        log.debug("configure HttpSecurity.");
        http.csrf().disable();
        http.authorizeRequests().anyRequest().authenticated().and()
        .formLogin().loginPage("/login").defaultSuccessUrl("/home", true).failureUrl("/login?failed").and()
        .logout().logoutUrl("/logout").logoutSuccessUrl("/login").permitAll().and().httpBasic();
        
        // http.authorizeRequests().anyRequest().authenticated().and()
        // // form
        // .formLogin()
        // // login
        // .loginPage("/login").defaultSuccessUrl("/home", true).failureUrl("/login?failed").and()
        // // logout
        // .logout().logoutUrl("/logout").logoutSuccessUrl("/logout")
        // // permit
        // .permitAll();
        
        // http.authorizeUrls()
        // .antMatchers("/*").permitAll()
        // .antMatchers("/admin/**").hasRole("ADMIN").anyRequest().authenticated()
        // .and().logout()
        // .logoutUrl("/logout")
        // .logoutSuccessUrl("/login.html?logout")
        // .and()
        // .formLogin()
        // .loginUrl("/login.html")
        // .defaultSuccessUrl("/admin/admin.html", true)
        // .failureUrl("/login.html?failed")
        // .permitAll();
    }
    
    @Override
    public void configure(WebSecurity web) throws Exception {
        log.debug("configure WebSecurity.");
        web.ignoring().antMatchers("/resources/**");
    }
}
