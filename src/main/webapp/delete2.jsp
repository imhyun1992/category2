<%@page import="java.util.ArrayList"%>
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
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="vo" class="com.tjoeun.vo.CategoryVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>

<%
//	CategoryVO original = service.selectByIdx(vo.getIdx());
/*
	CategoryService service = CategoryService.getInstance();
//	삭제한 카테고리 이름을 삭제완료 메시지에 표시하기 위해. 삭제하기 전에 해당 카테고리를 얻어온다.
	CategoryVO original = service.selectByIdx(vo.getIdx());
//	out.println(original);
	
//	1. 삭제버튼이 클릭되면 해당 카테고리를 테이블에서 완전이 삭제한다.
//	service.delete(vo.getIdx());

//	2. 삭제 버튼이 클릭되면 해당 카테고리 자체를 "삭제된 카테고리입니다."로 수정한다.
//	service.deletedCategory(vo.getIdx());

//	3. 삭제 버튼이 클릭되면 deleteCheck 필드의 값을 "YES"로 수정한다.
	service.deleteCheck(vo.getIdx());

//	삭제 메시지를 출력하고 카테고리 목록을 얻어는 페이지(list.jsp)를 호출한다.
	out.println("<script>");
//	out.println("alert('"+original.getIdx()+"번. ["+original.getCategory()+"] 카테고리 삭제완료!!')");
	out.println("location.href='list.jsp'");
	out.println("</script>");
	
//	4. 삭제할 버튼이 클릭되면 삭제한 카테고리와 삭제한 카테고리의 모든 서브 카테고리도 삭제한다.
//		삭제할 카테고리와 삭제할 카테고리의 모든 서브 카테고리 목록을 얻어와 ArrayList에 저장한다.
	ArrayList<CategoryVO> deleteList = service.deleteList(vo);
*/
int idx = Integer.parseInt(request.getParameter("idx"));

CategoryService.getInstance().deleteCheck(idx);
response.sendRedirect("list.jsp");
%>

</body>
</html>