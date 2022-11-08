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
%>

<%
p

	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="O" class="com.tjoeun.vo.CategoryVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>
<%-- 	${vo}
 --%>	
	<%
 		CategoryService service = CategoryService.getInstance();
		CategoryVO original = service.selectByIdx(vo.getIdx());
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	service.update(vo);
	
	CategoryService.getInstance().restore(idx);
	response.sendRedirect("list.jsp");
/* 		CategoryService service = CategoryService.getInstance();
 		CategoryService service = CategoryService.getInstance();
	// 수정한 카테고리 이름을 수정완료 메세지에 표시하기 위해서 수정하기 전에 수정할 카테고리를 얻어온다.
		CategoryVO original = service.selectByIdx(vo.getIdx());
	
	//	수정 버튼이 클릭되면 해당 카테고리를 수정한다.
	service.update(vo);
	//	수정 메시지를 출력하고 카테고리 목록을 얻어오는 페이지를 호출한다.
	out.println("<script>");
	out.println("alert('"+original.getCategory()+"카테고리를"+vo.getCategory()+" 카테고리로 수정 완료!!!"+"')");
	out.println("location.href='list.jsp'");
	out.println("</script>"); */
	%>

</body>
</html>