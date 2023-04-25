package com.andrewpham.codingninjas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.Image;
import com.andrewpham.codingninjas.repositories.ImageRepository;

@Service
public class ImageService {
	@Autowired
	private ImageRepository imageRepo;
	
	// ---- FIND ALL ----
	public List<Image> allImages() {
		return imageRepo.findAll();
	}

	// ---- FIND ONE ----
	public Image oneImage(Long id) {
		Optional<Image> optionalImage = imageRepo.findById(id);
		if (optionalImage.isPresent()) {
			return optionalImage.get();
		}
		return null;
	}

	// ---- CREATE ----
	public Image createImage(Image newImage) {
		return imageRepo.save(newImage);
	}

	// ---- UPDATE ----
	public Image updateImage(Image updateImageInfo) {
		return imageRepo.save(updateImageInfo);
	}

	// ---- DELETE ----
	public void removeImage(Long id) {
		imageRepo.deleteById(id);
	}
}
