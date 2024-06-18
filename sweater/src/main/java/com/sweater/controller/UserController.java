package com.sweater.controller;

import com.sweater.domain.User;
import com.sweater.repos.RoleRepo;
import com.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private RoleRepo roleRepo;

    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userRepo.findAll());
        return "userList";
    }

    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", roleRepo.findAll());
        return "userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ){
        user.setUsername(username);

        List<String> roles = roleRepo.findAll().stream()
                .map(role -> role.getRole()).toList();

        user.getRoles().clear();

        for (String key : form.keySet()){
            if(roles.contains(key)){
                user.getRoles().add(roleRepo.findByRole(key).get());
            }
        }

        userRepo.save(user);
        return "redirect:/user";
    }
}
