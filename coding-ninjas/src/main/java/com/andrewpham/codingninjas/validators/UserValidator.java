package com.andrewpham.codingninjas.validators;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.repositories.UserRepository;

@Component
public class UserValidator implements Validator{
	@Autowired
	private UserRepository userRepository;
	
	@Override
    public boolean supports(Class<?> c) {
        return User.class.equals(c);
    }
	
	@Override
    public void validate(Object object, Errors errors) {
        User user = (User) object;

        User exitedUser = userRepository.findByEmail(user.getEmail());
        if (!user.getConfirm().equals(user.getPassword())) {
            errors.rejectValue("confirm", "Match");
        }
       
        if(exitedUser != null) {
        	errors.rejectValue("email", "Duplicate");
        }
        
        
    }
	

}