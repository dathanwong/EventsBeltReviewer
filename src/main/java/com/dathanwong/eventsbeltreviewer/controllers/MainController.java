package com.dathanwong.eventsbeltreviewer.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dathanwong.eventsbeltreviewer.models.Event;
import com.dathanwong.eventsbeltreviewer.models.Message;
import com.dathanwong.eventsbeltreviewer.models.State;
import com.dathanwong.eventsbeltreviewer.models.User;
import com.dathanwong.eventsbeltreviewer.services.EventService;
import com.dathanwong.eventsbeltreviewer.services.MessageService;
import com.dathanwong.eventsbeltreviewer.services.UserService;
import com.dathanwong.eventsbeltreviewer.validator.UserValidator;

@Controller
public class MainController {

	private final UserValidator userValidator;
	private final UserService userService;
	private final EventService eventService;
	private final MessageService messageService;
	
	public MainController(MessageService messageService, EventService eventService, UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.eventService = eventService;
		this.messageService = messageService;
	}
	
	//Show login and registration page if user is not logged in
	@RequestMapping("/")
	public String loginPage(@ModelAttribute("user") User user, Model model, HttpSession session) {
		if(this.isLoggedIn(session)) {
			return "redirect:/events";
		}else {
			//Pass states into model
			model.addAttribute("states", State.states);
			return "loginRegistrationPage.jsp";
		}
	}
	
	@PostMapping("/user")
	public String createUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			return "loginRegistrationPage.jsp";
		}else {
			User u = userService.registerUser(user);
			session.setAttribute("userId", u.getId());
			return "redirect:/events";
		}
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session, RedirectAttributes redirectAttributes) {
		if(userService.authenticateUser(email, password)) {
			User user = userService.findByEmail(email);
			session.setAttribute("userId", user.getId());
			return "redirect:/events";
		}else {
			redirectAttributes.addFlashAttribute("errors", "Email or password is incorrect");
			return "redirect:/";
		}
	}
	
	@RequestMapping("/events")
	public String showEventsPage(@ModelAttribute("event") Event event, Model model, HttpSession session) {
		if(this.isLoggedIn(session)) {
			User user = userService.findById((Long) session.getAttribute("userId"));
			model.addAttribute("user", user);
			model.addAttribute("eventsInState", eventService.findByState(user.getState()));
			model.addAttribute("eventsNotInState", eventService.findByStateNot(user.getState()));
			model.addAttribute("states", State.states);
			return "allEventsPage.jsp";
		}else {
			return "redirect:/";
		}
		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@PostMapping("/events")
	public String createEvent(HttpSession session, Model model, @Valid @ModelAttribute("event") Event event, BindingResult result) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userService.findById(userId);
		if(result.hasErrors()) {
			model.addAttribute("user", user);
			model.addAttribute("eventsInState", eventService.findByState(user.getState()));
			model.addAttribute("eventsNotInState", eventService.findByStateNot(user.getState()));
			model.addAttribute("states", State.states);
			return "allEventsPage.jsp";
		}else {
			event.setHost(user);
			eventService.create(event);
			return "redirect:/events";
		}
	}
	
	@RequestMapping("/events/{id}/join")
	public String joinEvent(@PathVariable("id") Long id, HttpSession session) {
		if(this.isLoggedIn(session)) {
			User user = userService.findById((Long) session.getAttribute("userId"));
			Event event = eventService.findById(id);
			event.addAttendee(user);
			eventService.update(event);
			return "redirect:/events";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping("/events/{id}/cancel")
	public String cancelFromEvent(@PathVariable("id") Long id, HttpSession session) {
		if(this.isLoggedIn(session)) {
			User user = userService.findById((Long) session.getAttribute("userId"));
			Event event = eventService.findById(id);
			event.removeAttendee(user);
			eventService.update(event);
			return "redirect:/events";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping("/events/{id}")
	public String eventPage(@PathVariable("id") Long eventId,@ModelAttribute("newMessage") Message message, HttpSession session, Model model) {
		if(this.isLoggedIn(session)) {
			User user = userService.findById((Long) session.getAttribute("userId"));
			Event event = eventService.findById(eventId);
			model.addAttribute("event", event);
			return "eventPage.jsp";
		}else {
			return "redirect:/";
		}
	}
	
	@PostMapping("/events/{id}/message")
	public String addMessage(@PathVariable("id") Long eventId, @RequestParam("newMessage") String message, HttpSession session, Model model) {
		if(this.isLoggedIn(session)) {
			User user = userService.findById((Long) session.getAttribute("userId"));
			Event event = eventService.findById(eventId);
			//create new message
			Message newMessage = new Message();
			newMessage.setMessage(message);
			newMessage.setEvent(event);
			newMessage.setUser(user);
			messageService.create(newMessage);
			return "redirect:/events/"+event.getId();
		}else {
			return "redirect:/";
		}
	}
	
	//Check if user is logged in
	private boolean isLoggedIn(HttpSession session) {
		Long id = (Long) session.getAttribute("userId");
		if(id != null) {
			return true;
		}else {
			return false;
		}
	}
	
}
