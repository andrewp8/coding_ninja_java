package com.andrewpham.codingninjas.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewpham.codingninjas.models.Lecture;

@Repository
public interface LectureRepository extends CrudRepository<Lecture, Long> {
	List<Lecture> findAll();
	List<Lecture> findByTitleContaining(String keyword);
}
