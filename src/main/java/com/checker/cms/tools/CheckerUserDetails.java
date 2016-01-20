package com.checker.cms.tools;

import java.util.Collection;

import lombok.Getter;
import lombok.Setter;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

@Getter
@Setter
public class CheckerUserDetails extends User {
    
    private static final long serialVersionUID = -7426931697922560021L;
    
    private Integer           idCompany;
    
    public CheckerUserDetails(String username, String password, Collection<? extends GrantedAuthority> authorities, Integer idCompany) {
        super(username, password, authorities);
        this.idCompany = idCompany;
    }
    
    @Override
    public String toString() {
        return new StringBuilder().append("User [").append("idCompany=").append(idCompany).append(", ").append("user=").append(getUsername()).append("]").toString();
    }
}
