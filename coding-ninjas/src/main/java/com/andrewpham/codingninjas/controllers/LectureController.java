package com.andrewpham.codingninjas.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.andrewpham.codingninjas.models.Lecture;
import com.andrewpham.codingninjas.services.CourseService;
import com.andrewpham.codingninjas.services.LectureService;

import jakarta.validation.Valid;

@Controller
public class LectureController {
	@Autowired
	private LectureService lectureService;
	@Autowired
	private CourseService courseService;

	@GetMapping("/courses/{courseId}/lectures")
	public String lectureDashboard(@PathVariable("courseId") Long courseId, Principal principal, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		System.out.println("courseid>>>>>" + courseId);
		model.addAttribute("oneCourse", courseService.findById(courseId));
		model.addAttribute("lectureList", lectureService.allLectures());
		return "viewOneCourse.jsp";
	}
	
	@GetMapping("/courses/{courseId}/lectures/new")
	public String newLecture(Model model, Principal principal) {
		if(principal==null) {
			return "redirect:/login";
		}
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		model.addAttribute("newLecture", new Lecture());
		model.addAttribute("today",today);
		return "newLecture.jsp";
	}
	
	@PostMapping("/courses/{courseId}/lectures/new")
	public String processNewLecture(@Valid @ModelAttribute("newLecture") Lecture newLecture, BindingResult result, @PathVariable("courseId") Long courseId,Principal principal, Model  model) {
		if(principal ==null) {
			return "redirect:/login";
		}
		model.addAttribute("courseId", courseId);
		if(result.hasErrors()) {
			return "newLecture.jsp";
		}
		lectureService.createLecture(newLecture);
		return "redirect:/courses/{courseId}/lectures";
		
		
	}
}
