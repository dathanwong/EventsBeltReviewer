package com.dathanwong.eventsbeltreviewer.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.dathanwong.eventsbeltreviewer.models.Event;
import com.dathanwong.eventsbeltreviewer.models.User;
import com.dathanwong.eventsbeltreviewer.repositories.EventRepository;

@Service
public class EventService {

	private final EventRepository eventRepo;
	
	public EventService(EventRepository eventRepo) {
		this.eventRepo = eventRepo;
	}
	
	public List<Event> findAll(){
		return eventRepo.findAll();
	}
	
	public Event create(Event event) {
		return eventRepo.save(event);
	}
	
	public Event findById(Long id) {
		Optional<Event> event = eventRepo.findById(id);
		if(event.isPresent()) {
			return event.get();
		}else {
			return null;
		}
	}
	
	public List<Event> findByState(String state){
		return eventRepo.findByState(state);
	}
	
	public List<Event> findByStateNot(String state){
		return eventRepo.findByStateNot(state);
	}
	
	public void update(Event event) {
		eventRepo.save(event);
	}
}
