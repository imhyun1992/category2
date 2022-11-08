<%@page import="com.tjoeun.vo.CategoryList"%>
<%@page import="com.tjoeun.service.CategoryService"%>
<%@page import="com.tjoeun.vo.CategoryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
p

	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="O" class="com.tjoeun.vo.CategoryVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	CategoryService.getInstance().report(idx);
	response.sendRedirect("list.jsp");
%>

</body>
</html>