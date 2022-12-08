package com.example.titter.controllers;

import com.example.titter.domain.Role;
import com.example.titter.domain.User;
import com.example.titter.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {

    @Autowired
    UserRepo userRepo;

    @Autowired
    PasswordEncoder encoder;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }
    @PostMapping("/registration")
    public String addUser(User user, Map<String, Object> model) {

        User userFromDb = userRepo.findByUsername(user.getUsername());

        if(userFromDb !=null){
            model.put("message", "User exists!");
            return "registration";
        }

        user.setActive(true);
        String password = user.getPassword();
        user.setPassword(encoder.encode(password));
        user.setRoles(Collections.singleton(Role.USER));
        userRepo.save(user);

        return "redirect:/login";
    }
}
