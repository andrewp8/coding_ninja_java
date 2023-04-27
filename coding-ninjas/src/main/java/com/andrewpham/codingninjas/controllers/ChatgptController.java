package com.andrewpham.codingninjas.controllers;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.andrewpham.codingninjas.models.Course;
import com.andrewpham.codingninjas.models.Lecture;
import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.services.ChatgptService;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/api/v1")
public class ChatgptController {

	private ChatgptService chatgptService;

	public ChatgptController(ChatgptService chatgptService) {
		this.chatgptService = chatgptService;
	}

	@GetMapping("/searchChatGPT")
	public String renderChatGPTForm() {
		return "chatGPTForm.jsp";
	}
<<<<<<< HEAD
=======
	
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
	@PostMapping("/home/searchChatGPT")
	public String searchHomeChatGPT(
			@RequestParam("prompt") String query,
			Model model
			) {
		String response = chatgptService.processSearch(query);
		System.out.println("console.log:" + response +"?????");
//		System.out.println(searchRequest);
//		System.out.println("searchChatGPT starter query" + searchRequest.getQuery());
		model.addAttribute("response", response);
		
		
		return "home.jsp";
	}
>>>>>>> 167304c3ba286991c7f61e30102bfbe0da735fa1
}

//	@PostMapping("/searchChatGPT")
//	public String searchChatGPT(
//			@RequestParam("prompt") String query,
//			Model model
//			) {
//		String response = chatgptService.processSearch(query);
//		System.out.println("console.log:" + response +"?????");
////		System.out.println(searchRequest);
////		System.out.println("searchChatGPT starter query" + searchRequest.getQuery());
//		model.addAttribute("response", response);
//		
//		
//		return "chatGPTForm.jsp";
//	}

//	@PostMapping("/searchChatGPT")
//	public String searchChatGPT(
//			@RequestParam("prompt") String query,
//			Model model, Principal principal, @Valid @ModelAttribute("newCourse") Course newCourse, BindingResult result,
//			) {
//	if (principal == null) {
//		return "redirect:/login";
//	}
//	String email = principal.getName();
//	User user = userService.findByEmail(email);
//	if (result.hasErrors()) {
//		model.addAttribute("currentUser", user);
//		model.addAttribute("unassignedCourses", courseService.getUnassignedCourses(user));
//		model.addAttribute("assignedCourses", courseService.getAssignedCourses(user));
//
//		// Update last login
//		user.setLastLogin(new Date());
//		userService.updateUser(user);
//		// If the user is an ADMIN they will be redirected to the admin page
//		if (user.getRoles().get(0).getName().contains("ROLE_ADMIN")) {
//			model.addAttribute("currentUser", userService.findByEmail(email));
//			model.addAttribute("users", userService.allUsers());
//			model.addAttribute("allCourses", courseService.allCourses());
//			model.addAttribute("unassignedCourses", courseService.getUnassignedCourses(user));
//			model.addAttribute("assignedCourses", courseService.getAssignedCourses(user));
//			String response = chatgptService.processSearch(query);
//			model.addAttribute("response", response);
//			return "adminPage.jsp";
//		}
//		// All other users are redirected to the home page
//
//	}
//
//	List<Lecture> lectures = lectureService.findAllOrderByDueDateDesc();
//	List<Lecture> urgentReadings = lectures.subList(0, Math.min(lectures.size(), 3));
//	model.addAttribute("urgentReadings", lectures);
//	courseService.addCourse(newCourse);
//	user.getCourses().add(newCourse);
//	userService.updateUser(user);
//	return "redirect:/";
//}
