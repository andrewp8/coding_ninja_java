package com.andrewpham.codingninjas.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.andrewpham.codingninjas.models.Role;

public interface RoleRepository extends CrudRepository<Role, Long> {
    List<Role> findAll();
    
    List<Role> findByName(String name);
}
