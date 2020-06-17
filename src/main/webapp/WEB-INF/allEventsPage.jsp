<!doctype html>
<html lang="en">
    <head>
        <title>Title</title>
        <!-- Required meta tags -->
        <meta charset="ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <header>
                <div class="row justify-content-between">
                    <h1>Welcome, <c:out value="${user.firstName} ${user.lastName}"/></h1>
                    <a href="/logout">Logout</a>
                </div>
            </header>
            <div class="row">
                <div class="col">
                    <div class="row">
                        <p>Here are some of the events in your state</p>
                    </div>
                    <div class="row">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <th>Name</th>
                                <th>Date</th>
                                <th>Location</th>
                                <th>Host</th>
                                <th>Action/Status</th>
                            </thead>
                            <tbody>
                            	<c:forEach items="${eventsInState}" var="event">
	                                <tr>
	                                    <td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
	                                    <td><c:out value="${event.date}"/></td>
	                                    <td><c:out value="${event.location}"/></td>
	                                    <td><c:out value="${event.host.firstName}"/></td>
	                                    <td>
	                                    	<c:if test="${event.userIsAttendee(user)}">
	                                    		<c:if test="${event.userIsHost(user)}">
	                                    			<a href="">Edit</a>
	                                    			<a href="">Delete</a>
	                                    		</c:if>
	                                    		<c:if test="${!event.userIsHost(user)}">
	                                    			Joining <a href="/events/${event.id}/cancel">Cancel</a>
	                                    		</c:if>
	                                    	</c:if>
	                                    	<c:if test="${!event.userIsAttendee(user)}">
	                                    		<a href="/events/${event.id}/join">Join</a>
	                                    	</c:if>
	                                    </td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <p>Here are some of the events in other states</p>
                    </div>
                    <div class="row">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <th>Name</th>
                                <th>Date</th>
                                <th>Location</th>
                                <th>Host</th>
                                <th>Action/Status</th>
                            </thead>
                            <tbody>
                                <c:forEach items="${eventsNotInState}" var="event">
	                                <tr>
	                                    <td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
	                                    <td><c:out value="${event.date}"/></td>
	                                    <td><c:out value="${event.location}"/></td>
	                                    <td><c:out value="${event.host.firstName}"/></td>
	                                    <td>
	                                    	<c:if test="${event.userIsAttendee(user)}">
	                                    		<c:if test="${event.userIsHost(user)}">
	                                    			<a href="">Edit</a>
	                                    			<a href="">Delete</a>
	                                    		</c:if>
	                                    		<c:if test="${!event.userIsHost(user)}">
	                                    			Joining <a href="/events/${event.id}/cancel">Cancel</a>
	                                    		</c:if>
	                                    	</c:if>
	                                    	<c:if test="${!event.userIsAttendee(user)}">
	                                    		<a href="/events/${event.id}/join">Join</a>
	                                    	</c:if>
	                                    </td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <h3>Create an Event</h3>
                    </div>
                    
                    <div class="row">
                    	<div class="col-6">
	                        <form:form action="/events" method="POST" modelAttribute="event">
	                        	<div class="row">
			                        <form:errors path="*" class="text-danger"/>
			                    </div>
	                            <div class="row my-2">
	                                <div class="col-3">Name</div>
	                                <form:input path="name" class="col-8" type="text"/>
	                            </div>
	                            <div class="row my-2">
	                                <div class="col-3">Date</div>
	                                <form:input path="date" class="col-8" type="datetime-local"/>
	                            </div>
	                            <div class="row my-2">
	                                <div class="col-3">Location</div>
	                                <form:input path="location" class="col-6" type="text"/>
	                                <form:select path="state" class="col-2" name="" id="">
	                                    <c:forEach items="${states}" var="state">
		                                    <option value="${state}"><c:out value="${state}"/></option>
	                                    </c:forEach>
	                                </form:select>
	                            </div>
	                            <div class="row my-2 justify-content-end">
	                                <button class="btn btn-primary" type="submit">Create</button>
	                            </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>