package com.example.titter.services;

import com.example.titter.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class MailSender {

    @Autowired
    private JavaMailSender mailSender;
    @Value("${spring.mail.username}")
    private String from;

    @Value("${server.url}")
    private String serverUrl;

    private void send(String emailTo, String subject, String message) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();

        mailMessage.setFrom(from);
        mailMessage.setTo(emailTo);
        mailMessage.setSubject(subject);
        mailMessage.setText(message);

        mailSender.send(mailMessage);
    }

    public void sendActivationCode(User user) {
        if (StringUtils.hasText(user.getEmail())) {
            String message = String.format(
                    "Hello, %s! \n" + "Welcome to Titter. Please, visit link to activate account: \n" +
                            "http://%s/activate/%s",
                    user.getUsername(), serverUrl, user.getActivationCode());
            this.send(user.getEmail(), "Activation code", message);
            System.out.println(message);
        }
    }
}
