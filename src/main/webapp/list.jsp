<%@page import="com.tjoeun.service.CategoryService"%>
<%@page import="com.tjoeun.vo.CategoryList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서브 카테고리 작업단</title>
</head>
<body>

<%
CategoryList categoryList = CategoryService.getInstance().selectList();
request.setAttribute("categoryList",categoryList);
pageContext.forward("categoryView2.jsp");
%>
</body>
</html>