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
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <h3>Event Name</h3>
                    </div>
                    <div class="row">
                        <h5>Edit Event</h5>
                    </div>
                    <div class="row">
                        <div class="col">
                        	<form:form action="/events/${event.id}/edit" method="POST" modelAttribute="event">
	                            <div class="row my-2">
	                                <div class="col-3">Name</div>
	                                <form:input path="name" class="col-8" type="text" value="${event.name}"/>
	                            </div>
	                            <div class="row my-2">
	                                <div class="col-3">Date</div>
	                                <form:input path="date" class="col-8" type="datetime-local" value="${date}"/>
	                            </div>
	                            <div class="row my-2">
	                                <div class="col-3">Location</div>
	                                <form:input path="location" class="col-6" type="text" value="${event.location}"/>
	                                <form:select path="state" class="col-2" name="" id="">
	                                   <c:forEach items="${states}" var="state">
			                               <option value="${state}" <c:if test="${event.state.equals(state)}">selected</c:if>><c:out value="${state}"/></option>
		                               </c:forEach>
	                                </form:select>
	                            </div>
	                            <div class="row my-2 justify-content-end">
	                                <button class="btn btn-primary" type="submit">Edit</button>
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