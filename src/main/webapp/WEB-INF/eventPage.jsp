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
                <h1><c:out value="${event.name}"/></h1>
            </header>
            <div class="row justify-content-between">
                <div class="col-6">
                    <div class="row my-1">
                        <div class="col-3">Host:</div>
                        <div class="col-8"><c:out value="${event.host.firstName} ${event.host.lastName}"/></div>
                    </div>
                    <div class="row my-1">
                        <div class="col-3">Date:</div>
                        <div class="col-8"><c:out value="${event.date}"/></div>
                    </div>
                    <div class="row my-1">
                        <div class="col-3">Location:</div>
                        <div class="col-8"><c:out value="${event.location}"/></div>
                    </div>
                    <div class="row my-1">
                        <div class="col-3"># Attendees:</div>
                        <div class="col-8"><c:out value="${event.attendees.size()}"/></div>
                    </div>
                    <div class="row my-4">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <th>Name</th>
                                <th>Location</th>
                            </thead>
                            <tbody>
                            	<c:forEach items="${event.attendees}" var="attendee">
	                                <tr>
	                                    <td><c:out value="${attendee.firstName} ${attendee.lastName}"/></td>
	                                    <td><c:out value="${attendee.location}"/></td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-5">
                    <h3>Message Wall</h3>
                    <div class="row my-2">
                        <div style="overflow-y: scroll; height: 300px;" class="container border border-dark">
                            <c:forEach items="${event.messages}" var="message">
	                            <p><c:out value="${message.user.firstName} ${message.user.lastName}"/> says: <c:out value="${message.message}"/></p>
	                            <p>-----------------------------------</p>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="row my-2">
                        Add Comment:
                    </div>
                    <form action="/events/${event.id}/message" method="POST"> 
	                    <div class="row my-2">
	                        <input name="newMessage" class="col-12 border border-dark" type="text"/>
	                    </div>
	                    <div class="row">
	                        <div class="col text-right">
	                            <button class="btn btn-primary">Submit</button>
	                        </div>
	                    </div>
                    </form>
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