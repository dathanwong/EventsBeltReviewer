package com.dathanwong.eventsbeltreviewer.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.dathanwong.eventsbeltreviewer.models.User;
import com.dathanwong.eventsbeltreviewer.services.UserService;

@Component
public class UserValidator implements Validator{

	private final UserService userService;
	
	public UserValidator(UserService userService) {
		this.userService = userService;
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		
		if(!user.getPasswordConfirmation().equals(user.getPassword())) {
			errors.rejectValue("passwordConfirmation", "Match");
		}
		User foundUser = userService.findByEmail(user.getEmail());
		if(foundUser != null) {
			errors.rejectValue("email", "Match");
		}
	}

	
}
