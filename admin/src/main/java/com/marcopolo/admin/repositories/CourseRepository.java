package com.marcopolo.admin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.marcopolo.admin.models.Course;
import com.marcopolo.admin.models.User;

@Repository
public interface CourseRepository extends CrudRepository<Course, Long>{

	List<Course> findAll();
	Course findByIdIs(Long id);
	List<Course> findAllByUsers(User user);
	List<Course> findByUsersNotContains(User user);
}
