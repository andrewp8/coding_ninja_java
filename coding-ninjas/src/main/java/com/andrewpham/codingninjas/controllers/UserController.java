package com.andrewpham.codingninjas.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.andrewpham.codingninjas.models.User;
import com.andrewpham.codingninjas.services.UserService;
import com.andrewpham.codingninjas.validators.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class UserController {
	private UserService userService;
    
    private UserValidator userValidator;
	
    public UserController(UserService userService, UserValidator userValidator) {
        this.userService = userService;
        this.userValidator = userValidator;
    }
    
    // ---- REGISTER ----
    @RequestMapping("/register")
    public String registerForm(@Valid @ModelAttribute("newUser") User newUser) {
        return "reglog.jsp";
    }
    
    @PostMapping("/register")
    public String registration(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model) {
        userValidator.validate(newUser, result);
        if (result.hasErrors()) {
            return "reglog.jsp";
        }
        if(userService.allUsers().size()==0) {
        	   userService.saveUserWithAdminRole(newUser);
        	  }else {
        	   userService.saveWithUserRole(newUser);
        	  }
        return "redirect:/dashboard";
    }
    
    // ---- LOGIN ----
//    @RequestMapping("/login")
//    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
//        if(error != null) {
//            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
//        }
//        if(logout != null) {
//            model.addAttribute("logoutMessage", "Logout Successful!");
//        }        
//        model.addAttribute("newLogin", new User());
//        return "reglog.jsp";
//    }
    
    @RequestMapping("/login")
	public String login(
			@ModelAttribute("newLogin") User newLogin,
			@RequestParam(value="error", required=false) String error, 
			@RequestParam(value="logout", required=false) String logout, 
			Model model) {
		
		if(error!=null) {
			model.addAttribute("errorMessage","Invalid Credentials, Please try again.");
		}
		if(logout!=null) {
			model.addAttribute("logoutMessage","Logout Successful!");
		}
		
		return "reglog.jsp";
	}
    
    // We will call this method to log in newly registered users
 	public void authWithHttpServletRequest(HttpServletRequest request, String email, String password) {
 	    try {
 	        request.login(email, password);
 	    } catch (ServletException e) {
 	    	System.out.println("Login error: " + e);
 	    }
 	}
    
    // ---- DASHBOARD ----
    @RequestMapping(value = {"/", "/dashboard"})
    public String home(Principal principal, Model model) {
        String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUserName(username));
        return "dashboard.jsp";
    }
}
