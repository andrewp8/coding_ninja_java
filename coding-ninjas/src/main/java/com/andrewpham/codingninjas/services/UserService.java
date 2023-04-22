package com.andrewpham.codingninjas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.repositories.RoleRepository;
import com.andrewpham.codingninjas.repositories.UserRepository;

@Service
public class UserService {
	private UserRepository userRepository;
	private RoleRepository roleRepository;
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	public UserService(UserRepository userRepository, RoleRepository roleRepository,
			BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}

	// 1
	public void saveWithUserRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepository.findByName("ROLE_USER"));
		userRepository.save(user);
	}

	// 2
	public void saveUserWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
		userRepository.save(user);
	}

	// 3
	public User findByUserName(String username) {
		return userRepository.findByUserName(username);
	}
	
	public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

	
	// ---- UPGRADE USER ----
	public User upgradeUser(User user) {
		user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
		return userRepository.save(user);
	}

	// ---- FIND ALL ----
	public List<User> allUsers() {
		return userRepository.findAll();
	}

	// ---- FIND ONE ----
	public User findById(Long id) {
		Optional<User> optionalUser = userRepository.findById(id);
		if (optionalUser.isPresent()) {
			return optionalUser.get();
		}
		return null;
	}

	// ---- CREATE ----
	public User createUser(User newUser) {
		return userRepository.save(newUser);
	}

	// ---- UPDATE ----
	public User updateUser(User updateUserInfo) {
		return userRepository.save(updateUserInfo);
	}

	// ---- DELETE ----
	public void deleteUser(Long id) {
		userRepository.deleteById(id);
	}
}