package com.marcopolo.admin.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.marcopolo.admin.models.Course;
import com.marcopolo.admin.models.User;
import com.marcopolo.admin.repositories.CourseRepository;

@Service
public class CourseService {
	
	private final CourseRepository courseRepo;
	
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
