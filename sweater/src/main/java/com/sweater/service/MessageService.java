package com.sweater.service;

import com.sweater.domain.Message;
import com.sweater.domain.User;
import com.sweater.repos.MessageRepo;
import io.micrometer.common.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class MessageService {
    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    public Iterable<Message> findAll() {
        return messageRepo.findAll();
    }

    public Iterable<Message> filterMessages(String filter) {
        Iterable<Message> messages = messageRepo.findAll();

        if(filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else {
            messages = messageRepo.findAll();
        }

        return messages;
    }

    public void updateMessage(User currentUser,
                                 Message message,
                                 String text,
                                 String tag,
                                 MultipartFile file) throws IOException {
        if(message.getAuthor().equals(currentUser)){
            if(!StringUtils.isEmpty(text)){
                message.setText(text);
            }

            if(!StringUtils.isEmpty(tag)){
                message.setTag(tag);
            }

            saveFile(message, file);

            messageRepo.save(message);
        }
    }

    public void saveMessage(Message message, MultipartFile file) throws IOException {
        saveFile(message, file);

        messageRepo.save(message);
    }

    public void deleteMessage(Long messageId){

        messageRepo.deleteById(messageId);
    }

    private void saveFile(Message message, MultipartFile file) throws IOException {
        if(file != null && !file.getOriginalFilename().isEmpty()){
            File uploadDir = new File(uploadPath);

            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFileName));

            message.setFilename(resultFileName);
        }
    }
}
