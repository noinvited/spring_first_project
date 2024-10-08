package com.sweater.controller;

import com.sweater.domain.Message;
import com.sweater.domain.User;
import com.sweater.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class MessageController {
    @Autowired
    private MessageService messageService;

    @GetMapping("/user-messages/{user}")
    public String userMessages(@AuthenticationPrincipal User currentUser,
                               @PathVariable User user,
                               Model model,
                               @RequestParam(required = false) Message message) {
        List<Message> messages = user.getMessages();

        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("message", message);

        return "userMessages";
    }

    @PostMapping("/user-messages/{user}")
    public String updateUserMessages(@AuthenticationPrincipal User currentUser,
                                     @PathVariable User user,
                                     @RequestParam("id") Message message,
                                     @RequestParam(required = false, defaultValue = "false", name = "isEditPage") boolean isEditPage,
                                     @RequestParam(required = false, defaultValue = "false", name = "isEditForm") boolean isEditForm,
                                     @RequestParam("text") String text,
                                     @RequestParam("tag") String tag,
                                     @RequestParam("file") MultipartFile file) throws IOException {
        messageService.updateMessage(currentUser, message, text, tag, file);
        if(isEditPage){
            if(isEditForm){
                return "redirect:/user-messages/" + user.getId();
            } else {
                return "redirect:/user-messages/" + user.getId() + "?message=" + message.getId() + "&isEditPage=true";
            }
        } else {
            return "redirect:/user-messages/" + user.getId();
        }
    }

    @GetMapping("/del-user-messages/{user}")
    public String deleteUserMessages(@AuthenticationPrincipal User currentUser,
                                     @PathVariable User user,
                                     @RequestParam(required = false, defaultValue = "false", name = "isEditPage") boolean isEditPage,
                                     @RequestParam("message") Long messageId) {
        messageService.deleteMessage(messageId);

        if(isEditPage){
            return "redirect:/user-messages/" + user.getId();
        } else {
            return "redirect:/main";
        }
    }
}
