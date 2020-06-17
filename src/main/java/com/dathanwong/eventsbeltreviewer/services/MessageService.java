package com.dathanwong.eventsbeltreviewer.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dathanwong.eventsbeltreviewer.models.Message;
import com.dathanwong.eventsbeltreviewer.repositories.MessageRepository;

@Service
public class MessageService {

	private final MessageRepository messageRepo;
	
	public MessageService(MessageRepository messageRepo) {
		this.messageRepo = messageRepo;
	}
	
	public List<Message> findAll(){
		return messageRepo.findAll();
	}
	
	public Message create(Message message) {
		return messageRepo.save(message);
	}
}
