package com.andrewpham.codingninjas.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.andrewpham.codingninjas.models.ChatgptResponse;
import com.andrewpham.codingninjas.services.ChatgptService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/api/v1")
public class ChatgptController {

	private ChatgptService chatgptService;
	
	public ChatgptController(ChatgptService chatgptService) {
		this.chatgptService= chatgptService;
	}
	
	@GetMapping("/searchChatGPT")
	public String renderChatGPTForm() {
		return "chatGPTForm.jsp";
	}
	
	@PostMapping("/searchChatGPT")
	public String searchChatGPT(
			@RequestParam("prompt") String query,
			Model model
			) {
		String response = chatgptService.processSearch(query);
		System.out.println("console.log:" + response +"?????");
//		System.out.println(searchRequest);
//		System.out.println("searchChatGPT starter query" + searchRequest.getQuery());
		model.addAttribute("response", response);
		
		
		return "chatGPTForm.jsp";
	}
}
