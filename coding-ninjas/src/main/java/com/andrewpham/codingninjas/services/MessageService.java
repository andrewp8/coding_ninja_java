package com.andrewpham.codingninjas.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.Message;
import com.andrewpham.codingninjas.repositories.MessageRepository;

@Service
public class MessageService {
	
	
	@Autowired
	private MessageRepository messageRepository;
	
	public Message addMessage(Message message) {
		return messageRepository.save(message);
	}

}
