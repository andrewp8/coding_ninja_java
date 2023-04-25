package com.andrewpham.codingninjas.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewpham.codingninjas.models.Message;

@Repository
public interface MessageRepository extends CrudRepository <Message, Long>{

	List<Message> findAll();
}
