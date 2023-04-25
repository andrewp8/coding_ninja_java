package com.andrewpham.codingninjas.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewpham.codingninjas.models.Image;

@Repository
public interface ImageRepository extends CrudRepository<Image, Long> {
	List<Image> findAll();
}
