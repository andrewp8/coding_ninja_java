package com.andrewpham.codingninjas.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.andrewpham.codingninjas.models.Course;
import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.services.CourseService;
import com.andrewpham.codingninjas.services.UserService;

import jakarta.validation.Valid;

@Controller
public class CourseController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CourseService courseService;
	
	@GetMapping("/courses/new")
	public String newCourse(@ModelAttribute("newCourse") Course newCourse, Principal principal, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("userId", user.getId());
		
		return "newCourse.jsp";
	}
	
	@PostMapping("/courses/new")
	public String addNewCourse(
			@Valid @ModelAttribute("newCourse") Course newCourse,
			BindingResult result, 
			Principal principal
			) {
		if(result.hasErrors()) {
			return "newCourse.jsp";
		} else {
			courseService.addCourse(newCourse);
			String email = principal.getName();
			User user = userService.findByEmail(email);
			user.getCourses().add(newCourse);
			userService.updateUser(user);
			return "redirect:/";
		}
		
	}
	

}
