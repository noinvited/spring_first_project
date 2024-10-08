package com.sweater.controller;

import com.sweater.domain.User;
import com.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", userService.findAllRole());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ){
        userService.userSave(user, username, form);
        return "redirect:/user";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/delete")
    public String userDeleteAdmin(
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ){
        userService.userDeleteAdmin(user);
        return "redirect:/user";
    }

    @GetMapping("profile")
    String profile(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(
        @AuthenticationPrincipal User user,
        @RequestParam String oldPassword,
        @RequestParam String newPassword,
        @RequestParam String email,
        Model model
    ){
        int isEmailUpdate = userService.updateEmail(user, email);
        int isPasswordUpdate = userService.updatePassword(user, oldPassword, newPassword);

        if(isPasswordUpdate == 1){
            model.addAttribute("messageType1", "danger");
            model.addAttribute("message1", "Wrong password!");
        } else {
            if(isPasswordUpdate == 2){
                model.addAttribute("messageType1", "success");
                model.addAttribute("message1", "Password successfully update!");
            }
        }

        if(isEmailUpdate == 1){
            model.addAttribute("messageType2", "danger");
            model.addAttribute("message2", "Email is not valid!");
        } else {
            if(isEmailUpdate == 2){
                model.addAttribute("messageType2", "success");
                model.addAttribute("message2", "Email successfully update!");
            }
        }

        if(isEmailUpdate == 0 && isPasswordUpdate == 0){
            model.addAttribute("messageType1", "secondary");
            model.addAttribute("message1", "There are no changes!");
        }
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }
}
