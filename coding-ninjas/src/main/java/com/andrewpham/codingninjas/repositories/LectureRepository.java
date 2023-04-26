package com.andrewpham.codingninjas.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewpham.codingninjas.models.Lecture;

@Repository
public interface LectureRepository extends CrudRepository<Lecture, Long> {
	List<Lecture> findAll();

	List<Lecture> findByTitleContaining(String keyword);

	List<Lecture> findByCourseId(Long courseId);

	@Query(value = "SELECT * FROM coding_ninjas_schema.lectures ORDER BY due_date", nativeQuery = true)
	List<Lecture> findAllOrderByDueDateDesc();
}
