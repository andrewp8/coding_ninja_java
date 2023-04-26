package com.andrewpham.codingninjas.controllers;

import java.security.Principal;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.andrewpham.codingninjas.models.Course;
import com.andrewpham.codingninjas.models.Lecture;
import com.andrewpham.codingninjas.models.Message;
import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.services.CourseService;
import com.andrewpham.codingninjas.services.LectureService;
import com.andrewpham.codingninjas.services.MessageService;
import com.andrewpham.codingninjas.services.UserService;


import jakarta.validation.Valid;

@Controller
public class CourseController {
	@Autowired
	private LectureService lectureService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private MessageService messageService;
	
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
	@RequestMapping("/dashboard/join/{id}")
	public String joinCourse(@PathVariable("id") Long id, Principal principal, Model model) {
		
		if(principal==null) {
			return "redirect:/login";
		}
		String email = principal.getName();
		User user = userService.findByEmail(email);
		
		
		Course course = courseService.findById(id);
		user.getCourses().add(course);
		userService.updateUser(user);
		
		model.addAttribute("currentUser", user);
		model.addAttribute("unassignedProjects", courseService.getUnassignedCourses(user));
		model.addAttribute("assignedProjects", courseService.getAssignedCourses(user));
		
		return "redirect:/";
	}
	
	@RequestMapping("/dashboard/leave/{id}")
	public String leaveCourse(@PathVariable("id") Long id, Principal principal, Model model) {
		
		if(principal==null) {
			return "redirect:/login";
		}
		String email = principal.getName();
		User user = userService.findByEmail(email);
		
		
		Course course = courseService.findById(id);
		user.getCourses().remove(course);
		userService.updateUser(user);
		
		model.addAttribute("currentUser", user);
		model.addAttribute("unassignedProjects", courseService.getUnassignedCourses(user));
		model.addAttribute("assignedProjects", courseService.getAssignedCourses(user));
		
		return "redirect:/";
	}

	@GetMapping("/courses/{courseId}/lectures")
	public String viewOneCourse(
			@PathVariable("courseId") Long courseId, 
			@Valid @ModelAttribute("message") Message message,
			Principal principal, 
			Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		
		String email = principal.getName();
		User user = userService.findByEmail(email);
		Course course = courseService.findById(courseId);
		//gets all the messages saves in this course
		List<Message> messages = course.getMessages();
		Collections.reverse(messages);
		List<Lecture> courseLectures = lectureService.findByCourseId(courseId);
		model.addAttribute("currentUser", user);
		model.addAttribute("currentCourse", course);
		model.addAttribute("attendees", course.getUsers());
		model.addAttribute("theseMessages", messages);
		model.addAttribute("oneCourse", courseService.findById(courseId));
		model.addAttribute("lectureList", courseLectures);
		return "viewOneCourse.jsp";
	}

	
	@GetMapping("/courses/edit/{id}")
	public String renderEditCoursePage(
			@PathVariable("id") Long id, 
			Principal principal, 
			Model model
			) {
		if(principal==null) {
			return "redirect:/login";
		}
		
		Course course = courseService.findById(id);
		model.addAttribute("oneCourse", course);
		
		return "viewEditCourse.jsp";
		
	}
	
	@PostMapping("/courses/edit/{id}")
	public String processEditProject(
			@PathVariable("id") Long id,
			@Valid @ModelAttribute("oneCourse") Course oneCourse,
			BindingResult result,
			Principal principal
			) {
		if(principal==null) {
			return "redirect:/login";
		}
		
		String email = principal.getName();
		User user = userService.findByEmail(email);
		if(result.hasErrors()) {
			return "viewEditCourse.jsp";
		} else {
			Course thisCourse = courseService.findById(id);
			oneCourse.setUsers(thisCourse.getUsers());
			oneCourse.setTeacher(user);
			courseService.updateCourse(oneCourse);
			return "redirect:/";
		}
		
	}
	@DeleteMapping("/admin/courses/{id}")
	public String deleteCourse(
			@PathVariable("id") Long id,
			Principal principal
			) {
		if(principal==null) {
			return "redirect:/login";
		}
		Course oneCourse = courseService.findById(id);
		courseService.deleteCourse(oneCourse);
		return "redirect:/";
	}
	
	@PostMapping("/courses/{courseId}/addMessage")
	public String addMessage(
			@PathVariable("courseId") Long courseId, 
			@ModelAttribute("message") Message message, 
			Model model,
		
			Principal principal
			) {
		if(principal==null) {
			return "redirect:/login";
		}
		
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("user", user);
		messageService.addMessage(message);
		return "redirect:/courses/{courseId}/lectures";
		
	}
	
	
}
