package com.sweater.domain;

import jakarta.persistence.*;
import org.springframework.security.core.GrantedAuthority;

import java.util.List;

@Entity
public class Role implements GrantedAuthority {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String role;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name ="usr_role", joinColumns = @JoinColumn(name="id_role"), inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<User> users;


    @Override
    public String getAuthority(){
        return role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}