package com.andrewpham.codingninjas.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.andrewpham.codingninjas.models.User;

@Component
public class UserValidator implements Validator {
    
    //    1
    @Override
    public boolean supports(Class<?> c) {
        return User.class.equals(c);
    }
    
    // 2
    @Override
    public void validate(Object object, Errors errors) {
        User user = (User) object;
        
        if (!user.getConfirm().equals(user.getPassword())) {
            // 3
            errors.rejectValue("passwordConfirmation", "Match");
        }         
    }
}