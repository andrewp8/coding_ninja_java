package com.andrewpham.codingninjas.controllers;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.andrewpham.codingninjas.Utils.FileUploadUtil;
import com.andrewpham.codingninjas.models.Course;
import com.andrewpham.codingninjas.models.Image;
import com.andrewpham.codingninjas.models.Lecture;
import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.services.CourseService;
import com.andrewpham.codingninjas.services.ImageService;
import com.andrewpham.codingninjas.services.LectureService;
import com.andrewpham.codingninjas.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class LectureController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private LectureService lectureService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private ImageService imageService;

	private FileUploadUtil fileUploadUtil;
	
	@GetMapping("/courses/{courseId}/lectures/new")
	public String newLecture(@PathVariable("courseId") Long courseId,
			Model model,
			Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		model.addAttribute("newLecture", new Lecture());
		model.addAttribute("today", today);
		model.addAttribute("courseId", courseId);
		return "newLecture.jsp";
	}

	@PostMapping("/courses/{courseId}/lectures/new")
	public String processNewLecture(@Valid @ModelAttribute("newLecture") Lecture newLecture, BindingResult result,
			@PathVariable("courseId") Long courseId, Principal principal, Model model, HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}
		Image newImage = new Image();
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		model.addAttribute("today", today);
		model.addAttribute("courseId", courseId);
		model.addAttribute("newImage", newImage);
		if (result.hasErrors()) {
			return "newLecture.jsp";
		}
		Lecture justCreatedLecture = lectureService.createLecture(newLecture);
		Long newLectureId = justCreatedLecture.getId();
		session.setAttribute("newLectureId", newLectureId);
//		return "redirect:/courses/{courseId}/lectures";
		return "redirect:/courses/{courseId}/lectures/new";
	}

	// ---- DETAIL PAGE ----
	@GetMapping("/courses/{courseId}/lectures/{id}")
	public String detailLecture(@PathVariable("courseId") Long courseId,
			@PathVariable("id") Long id,
			Principal principal,
			Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		String email = principal.getName();
		User user = userService.findByEmail(email);
		
		
		Course course = courseService.findById(courseId);
		
		//gets all the messages saves in this course
		if(!course.getUsers().contains(user)) {
			return "redirect:/";
		}
		List<Lecture> lectureList = course.getLectures();
		model.addAttribute("oneCourse", course);
		model.addAttribute("oneLecture", lectureService.oneLecture(id));
		model.addAttribute("lecturesList", lectureList );
		return "lectureDetail.jsp";
	}
	
	// ---- SEARCH ----
	@PostMapping("/lectures/search")
	public String searchLectures(
			@RequestParam("keyword") String keyword,
			Principal principal,
			Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		List<Lecture> searchResults = lectureService.findByTileContaining(keyword);
		model.addAttribute("resultList", searchResults);
		model.addAttribute("keyword", keyword);
		return "searchTable.jsp";
	}
	
	// ---- UPLOAD IMAGE ----
	@PostMapping("/lectures/photos/new")
	  public String saveImage(
	            @RequestParam("image") MultipartFile multipartFile,
	            HttpSession session) throws IOException {
	         
			Long newLectureId = (Long)session.getAttribute("newLectureId");
	        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
	        Lecture justCreatedLecture = lectureService.oneLecture(newLectureId);
	        justCreatedLecture.setPhotos(fileName);
	        lectureService.updateLecture(justCreatedLecture);
	        
	        String folderName = "lecture-photos/" + newLectureId; // Name of the folder to create
	        String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/" + folderName;

	 
	        FileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
	        Lecture thisLecture = lectureService.oneLecture(newLectureId);
	        Long courseId = thisLecture.getCourse().getId();
	        return "redirect:/courses/"+courseId+"/lectures";
	}
	
	// ---- EDIT ----
	@GetMapping("courses/{courseId}/lectures/{id}/edit")
	public String editLecture(@PathVariable("courseId") Long courseId, @PathVariable("id") Long id, Model model,
			Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		model.addAttribute("today", today);
		model.addAttribute("oneLecture", lectureService.oneLecture(id));
		model.addAttribute("courseId", courseId);
		return "editLecture.jsp";
	}
	
	@PostMapping("/courses/{courseId}/lectures/{id}/edit")
	public String processEditLecture(@Valid @ModelAttribute("oneLecture") Lecture oneLecture,
			BindingResult result,
			@PathVariable("courseId") Long courseId,
			@PathVariable("id") Long id,
			Principal principal,
			Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		model.addAttribute("today", today);
		model.addAttribute("courseId", courseId);
		if (result.hasErrors()) {
			return "newLecture.jsp";
		}
		lectureService.updateLecture(oneLecture);
		return "redirect:/courses/{courseId}/lectures";
	}
	
	// ---- DELETE ----
	@DeleteMapping("/courses/{courseId}/lectures/{id}/delete")
	public String deleteLecture(
			@PathVariable("courseId") Long courseId,
			@PathVariable("id") Long id,
			Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		lectureService.removeLecture(id);
		return "redirect:/courses/{courseId}/lectures";
	}
}
