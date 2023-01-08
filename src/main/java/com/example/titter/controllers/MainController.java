package com.example.titter.controllers;

import com.example.titter.domain.Message;
import com.example.titter.domain.User;
import com.example.titter.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {
    private final MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public MainController(MessageRepo messageRepo) {
        this.messageRepo = messageRepo;
    }

    @GetMapping()
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter,
                       Map<String, Object> model) {
        Iterable<Message> messages = messageRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else {
            messages = messageRepo.findAll();
        }

        model.put("messages", messages);
        model.put("filter", filter);

        return "main";
    }

    @PostMapping("/add")
    public String add(@AuthenticationPrincipal User user,
                      @RequestParam(name = "text") String text,
                      @RequestParam(name = "tag") String tag,
                      @RequestParam(name = "file") MultipartFile file,
                      Map<String, Object> model) {
        Message message = new Message(text, tag, user);
        if (file!=null && !file.getOriginalFilename().isEmpty()){
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuid = UUID.randomUUID().toString();
            String filename = uuid + "." + file.getOriginalFilename();

            try {
                file.transferTo(new File(uploadPath + File.separator + filename));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            message.setFilename(filename);
        }

        messageRepo.save(message);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);
        return "main";
    }

    @PostMapping("/filter")
    public String filter(@RequestParam(name = "tag") String tag,
                         Map<String, Object> model) {

        Iterable<Message> messages;
        if (tag != null && !tag.isEmpty()) {
            messages = messageRepo.findByTag(tag);
        } else {
            messages = messageRepo.findAll();
        }

        model.put("messages", messages);
        return "main";
    }

}
