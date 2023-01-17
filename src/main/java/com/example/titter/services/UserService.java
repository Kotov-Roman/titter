package com.example.titter.services;

import com.example.titter.domain.Role;
import com.example.titter.domain.User;
import com.example.titter.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    MailSender mailSender;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepo.findByUsername(username);
    }

    public boolean addUser(User user) {
        User userFromDb = userRepo.findByUsername(user.getUsername());
        if (userFromDb != null) {
            return false;
        }

//        user.setActive(true);
        String password = user.getPassword();
//        user.setPassword(encoder.encode(password));
        user.setPassword(password);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        userRepo.save(user);

        mailSender.sendActivationCode(user);
        return true;
    }


    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        user.setActive(true);
        userRepo.save(user);
        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }


    public void save(User user, String username, Map<String, String> form) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
    }

    public void update(User user, String password, String email) {
        String currentEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(currentEmail)) ||
                (currentEmail != null && !currentEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);
            user.setActive(false);

            if (StringUtils.hasText(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if (StringUtils.hasText(password)) {
            user.setPassword(password);
        }
        userRepo.save(user);

        if (isEmailChanged) {
            mailSender.sendActivationCode(user);
        }
    }
}
