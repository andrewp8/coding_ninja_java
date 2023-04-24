package com.andrewpham.codingninjas.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewpham.codingninjas.models.Course;
import com.andrewpham.codingninjas.models.User;

@Repository
public interface CourseRepository extends CrudRepository<Course, Long>{

	List<Course> findAll();
	Course findByIdIs(Long id);
	Course findByTitle(String title);
	List<Course> findAllByUsers(User user);
	List<Course> findByUsersNotContains(User user);
}