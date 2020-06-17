package com.dathanwong.eventsbeltreviewer.models;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="events")
public class Event {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@Size(min=1, message="Event must have a name")
	private String name;
	@NotNull(message="Event must have a date and time")
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private Date date;
	@Size(min=1, message="Event must have a location")
	private String location;
	@Size(min=2, max=2, message="State must be two character abbreviation")
	private String state;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="host_id")
	private User host;
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name="events_users",
		joinColumns=@JoinColumn(name="event_id"),
		inverseJoinColumns=@JoinColumn(name="user_id")
	)
	private List<User> attendees = new ArrayList<User>() ;
	@OneToMany(mappedBy="event", fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Message> messages = new ArrayList<Message>();
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    public Event() {
    	
    }
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
    public boolean userIsAttendee(User user) {
    	if(this.getAttendees().contains(user)) {
    		return true;
    	}else {
    		return false;
    	}
    }
    
    public boolean userIsHost(User user) {
    	if(this.host == user) {
    		return true;
    	}else {
    		return false;
    	}
    }
    
    public void addAttendee(User user) {
    	if(!this.userIsAttendee(user)) {
    		this.attendees.add(user);
    	}
    }
    
    public void removeAttendee(User user) {
    	if(this.userIsAttendee(user)) {
    		this.attendees.remove(user);
    	}
    }
    
    public String getDateString() {
    	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss");
    	return dateFormat.format(this.getDate());
    }

    public void addMessage(Message message) {
    	this.messages.add(message);
    }
    
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getHost() {
		return host;
	}

	public void setHost(User host) {
		this.host = host;
		this.attendees.add(host);
	}

	public List<User> getAttendees() {
		return attendees;
	}

	public void setAttendees(List<User> attendees) {
		this.attendees = attendees;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
}
