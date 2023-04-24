package com.marcopolo.admin.validator;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.marcopolo.admin.models.User;
import com.marcopolo.admin.repositories.UserRepository;



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

        
        if (!user.getConfirm().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirmation", "Match");
        }
       
        
    }
	

}
