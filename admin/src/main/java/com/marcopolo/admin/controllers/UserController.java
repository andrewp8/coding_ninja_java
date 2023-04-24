package com.marcopolo.admin.controllers;

import java.security.Principal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.marcopolo.admin.models.User;
import com.marcopolo.admin.services.CourseService;
import com.marcopolo.admin.services.UserService;
import com.marcopolo.admin.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private UserValidator userValidator;
	
	@Autowired 
	private CourseService courseService;
	
	@RequestMapping("/register")
    public String registerForm(@Valid @ModelAttribute("user") User user) {
        return "loginPage.jsp";
    }
	
	@PostMapping("/register")
    public String registration(
    		@Valid @ModelAttribute("user") User user, 
    		BindingResult result, 
    		Model model, 
    		HttpSession session,
			HttpServletRequest request) {
    	
    	userValidator.validate(user, result);
    	
    	// Store the password before it is encrypted
		String password = user.getPassword();
		if(result.hasErrors()) {
			return "loginPage.jsp";
		}
		// Make first user ADMIN
		if(userService.allUsers().size()==0) {
			userService.saveUserWithAdminRole(user);
		}else {
			userService.saveWithUserRole(user);
		}
		
		// Log in new user with the password we stored before encrypting it
		authWithHttpServletRequest(request, user.getEmail(), password);
		
 		return "redirect:/";
    }
	
	// We will call this method to log in newly registered users
	 	public void authWithHttpServletRequest(HttpServletRequest request, String email, String password) {
	 	    try {
	 	        request.login(email, password);
	 	    } catch (ServletException e) {
	 	    	System.out.println("Login error: " + e);
	 	    }
	 	}
	 	@RequestMapping("/admin")
		public String adminPage(Principal principal, Model model) {
			String email = principal.getName();
			model.addAttribute("currentUser", userService.findByEmail(email));
			model.addAttribute("users", userService.allUsers());
			return "adminPage.jsp";
		}
	    
	 	@RequestMapping("/admin/{id}")
		public String makeAdmin(@PathVariable("id") Long id, Model model) {
			
			User user = userService.findById(id);
			userService.upgradeUser(user);
			
			model.addAttribute("users", userService.allUsers());
			 
			return "redirect:/admin";
		}
	 	
	 	@RequestMapping("/login")
		public String login(
				@ModelAttribute("user") User user,
				@RequestParam(value="error", required=false) String error, 
				@RequestParam(value="logout", required=false) String logout, 
				Model model) {
			
			if(error!=null) {
				model.addAttribute("errorMessage","Invalid Credentials, Please try again.");
			}
			if(logout!=null) {
				model.addAttribute("logoutMessage","Logout Successful!");
			}
			
			return "loginPage.jsp";
		}
	 	
	 	@RequestMapping(value={"/", "/home"})
		public String home(Principal principal, Model model) {
			if(principal==null) {
				return "redirect:/login";
			}
			String email = principal.getName();
			User user = userService.findByEmail(email);
			model.addAttribute("currentUser", user);
			model.addAttribute("unassignedCourses", courseService.getUnassignedCourses(user));
			model.addAttribute("assignedCourses", courseService.getAssignedCourses(user));
			
			if(user!=null) {
				// Update last login
				user.setLastLogin(new Date());
				userService.updateUser(user);
				// If the user is an ADMIN they will be redirected to the admin page
				if(user.getRoles().get(0).getName().contains("ROLE_ADMIN")) {
					model.addAttribute("currentUser", userService.findByEmail(email));
					model.addAttribute("users", userService.allUsers());
					model.addAttribute("allCourses", courseService.allCourses());
					model.addAttribute("unassignedCourses", courseService.getUnassignedCourses(user));
					model.addAttribute("assignedCourses", courseService.getAssignedCourses(user));

					return "adminPage.jsp";
				}
				// All other users are redirected to the home page
			}
			
			return "home.jsp";
		}
	 	
	 	@RequestMapping("/delete/{id}")
		public String deleteUser(@PathVariable("id") Long id, HttpSession session, Model model) {	
			User user = userService.findById(id);
			userService.deleteUser(user);
			
			model.addAttribute("users", userService.allUsers());
			 
			return "redirect:/admin";
		}
}
