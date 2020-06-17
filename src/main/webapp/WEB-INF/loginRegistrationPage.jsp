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
                <h1>Welcome</h1>
            </header>
            <div class="row justify-content-between">
                <div class="col-6 border border-dark">
                    <h1>Register</h1>
                    <form:form action="/user" method="POST" modelAttribute="user">
                    	<div class="row my-2 text-danger">
                    		<form:errors path="*"/>
                    	</div>
	                    <div class="row my-2">
	                        <div class="col-4">First Name</div>
	                        <form:input path="firstName" class="col-7" type="text"/>
	                    </div>
	                    <div class="row my-2">
	                        <div class="col-4">Last Name</div>
	                        <form:input path="lastName" class="col-7" type="text"/>
	                    </div>
	                    <div class="row my-2">
	                        <div class="col-4">Email</div>
	                        <form:input path="email" class="col-7" type="text"/>
	                    </div>
	                    <div class="row my-2">
	                        <div class="col-4">Location</div>
	                        <form:input path="location" class="col-5" type="text"/>
	                        <form:select path="state" class="col-2" name="state" id="">
	                        	<c:forEach items="${states}" var="state">
	                            	<option value="${state}"><c:out value="${state}"></c:out></option>
	                            </c:forEach>
	                        </form:select>
	                    </div>
	                    <div class="row my-2">
	                        <div class="col-4">Password</div>
	                        <form:input path="password" class="col-7" type="password"/>
	                    </div>
	                    <div class="row my-2">
	                        <div class="col-4">PW Conf:</div>
	                        <form:input path="passwordConfirmation" class="col-7" type="password"/>
	                    </div>
	                    <div class="row my-2">
	                    	<div class="col text-right">
	                    		<button type="submit" class="btn btn-primary">Register</button>
	                    	</div>
	                    </div>
                    </form:form>
                </div>
                <div class="col-5 border-dark border">
                    <h1>Login</h1>
                    <form action="/login" method="POST">
                    	<div class="row my-2 text-danger">
                    		<c:out value="${errors}"/>
                    	</div>
	                    <div class="row my-2">
	                        <div class="col-4">Email</div>
	                        <input class="col-7" name="email" type="text">
	                    </div>
	                    <div class="row my-2">
	                        <div class="col-4">Password</div>
	                        <input class="col-7" name="password" type="password">
	                    </div>
	                    <div class="row my-2">
	                    	<div class="col text-right">
	                    		<button type="submit" class="btn btn-primary">Login</button>
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