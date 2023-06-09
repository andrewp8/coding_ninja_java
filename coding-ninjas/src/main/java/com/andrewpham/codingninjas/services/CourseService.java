package com.andrewpham.codingninjas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.Course;
import com.andrewpham.codingninjas.models.Lecture;
import com.andrewpham.codingninjas.models.Message;
import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.repositories.CourseRepository;

@Service
public class CourseService {
	@Autowired
	private final CourseRepository courseRepo;
	@Autowired
	private MessageService messageService;
	@Autowired
	private LectureService lectureService;
	@Autowired
	private UserService userService;
	
	public CourseService(CourseRepository courseRepo) {
		this.courseRepo = courseRepo;
	}
	
	public List<Course> allCourses(){
		return courseRepo.findAll();
	}
	
	public Course updateCourse(Course course) {
		return courseRepo.save(course);
	}
	
	public List<Course> getAssignedCourses(User user){
		return courseRepo.findAllByUsers(user);
	}
	
	public List<Course> getUnassignedCourses(User user){
		return courseRepo.findByUsersNotContains(user);
	}
	
	public Course addCourse(Course course) {
		return courseRepo.save(course);
	}
	
	public void deleteCourse(Course course) {
		courseRepo.delete(course);
	}
	
	public Course findById(Long id) {
		Optional<Course> optionalCourse = courseRepo.findById(id);
		if(optionalCourse.isPresent()) {
			return optionalCourse.get();
		}else {
			return null;
		}
	}

}