package com.andrewpham.codingninjas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.Lecture;
import com.andrewpham.codingninjas.repositories.LectureRepository;

@Service
public class LectureService {
	@Autowired
	private LectureRepository lectureRepo;

// ---- FIND BY TITLE ----
	public List<Lecture> findByTileContaining(String keyword) {
		return lectureRepo.findByTitleContaining(keyword);
	}

// ---- FIND BY COURSEID ----
	public List<Lecture> findByCourseId(Long courseId){
		return lectureRepo.findByCourseId(courseId);
	}
	
// ---- FIND ALL ORDER BY DATE ASC ----
	public List<Lecture> findAllOrderByDueDateDesc(){
		return lectureRepo.findAllOrderByDueDateDesc();
	}

// ---- FIND ALL ----
	public List<Lecture> allLectures() {
		return lectureRepo.findAll();
	}

// ---- FIND ONE ----
	public Lecture oneLecture(Long id) {
		Optional<Lecture> optionalLecture = lectureRepo.findById(id);
		if (optionalLecture.isPresent()) {
			return optionalLecture.get();
		}
		return null;
	}

// ---- CREATE ----
	public Lecture createLecture(Lecture newLecture) {
		return lectureRepo.save(newLecture);
	}

// ---- UPDATE ----
	public Lecture updateLecture(Lecture updateLectureInfo) {
		return lectureRepo.save(updateLectureInfo);
	}

// ---- DELETE ----
	public void removeLecture(Long id) {
		lectureRepo.deleteById(id);
	}
}
