<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h1>Hai ${user.getUserName()}</h1>
<c:forEach items= "${list }" var="i">
<h1><c:out value="${ i.getNoteBookName()}"/><br/>
<c:out value="${i.getId() }"></c:out>
</h1>
</c:forEach>
</body>
</html>