package com.example.titter.controllers;

import com.example.titter.domain.Role;
import com.example.titter.domain.User;
import com.example.titter.services.UserService;
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
    public String userEditForm(@PathVariable User user,
                               Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping()
    public String userSave(@RequestParam Map<String, String> form,
                           @RequestParam String username,
                           @RequestParam("userId") User user) {

        userService.save(user, username, form);
        return "redirect:/user";
    }

    @GetMapping("/profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@AuthenticationPrincipal User user,
                                @RequestParam String password,
                                @RequestParam String email) {
        userService.update(user, password, email);
        return "redirect:/user/profile";
    }

    @GetMapping("/subscribe/{user}")
    public String subscribe(@PathVariable User user,
                            @AuthenticationPrincipal User currentUser) {
        userService.subscribe(currentUser, user);

        return "redirect:/user-messages/" + user.getId();
    }

    @GetMapping("/unsubscribe/{user}")
    public String unsubscribe(@PathVariable User user,
                              @AuthenticationPrincipal User currentUser) {
        userService.unsubscribe(currentUser, user);

        return "redirect:/user-messages/" + user.getId();
    }

    @GetMapping("/{type}/{user}/list")
    public String userList(@PathVariable User user,
                           @PathVariable String type,
                           Model model) {
        if ("subscriptions".equals(type)) {
            model.addAttribute("users", user.getSubscriptions());
        } else {
            model.addAttribute("users", user.getSubscribers());
        }

        // spring is smart enough and allows to use at view following attributes, if they were mentioned
        // as @PathVariable or if @PathVariable (name ="anotherName") then anotherName will be used as key
//        model.addAttribute("user", user);
//        model.addAttribute("type", type);

        return "subscriptions";
    }
}
