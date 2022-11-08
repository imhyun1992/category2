<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 프로젝트</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="./js/formCheck.js" defer="defer"></script>
</head>
<body class="p-3">
	<h1 class="m-3">Category Project</h1>
	<form class="row m-3" action="insert.jsp" method="post" onsubmit="return mainFormCheck(this)">
		<div class="col-md-3">
			<input class="form-control" type="text" name="category"/>
		</div>
		<div class="col-md-2">
			<input class="btn btn-outline-primary btn-sm" type="submit" value="메인 카테고리 만들기" style="font-size:18px;"/>
		</div>
	</form>
	<!-- bootstrap과 속성이 겹쳐서 속성입력이 안되면 style=""을 이용해서 스타일 넣는다. -->
	<hr style="color:red;"/>
	
	<!-- 카테고리 개수만큼 반복하며 카테고리 목록을 출력하고 서브 카테고리를 입력받는다. -->
	<c:forEach var="vo" items="${categoryList.list}">
		<form class="row m-3" action="reply.jsp" method="post" onsubmit="return subFormCheck(this)">
			<!-- idx, gup, lev, seq를 표시하는 텍스트 상자는 텍스트가 완료되면 모두 hidden으로 처리한다. -->
			<div class="col-md-2">
				<input type="text" name="idx" value="${vo.idx}" size="1"/>
				<input type="text" name="gup" value="${vo.gup}" size="1"/>
				<input type="text" name="lev" value="${vo.lev}" size="1"/>
				<input type="text" name="seq" value="${vo.seq}" size="1"/>
				${vo.category}
			</div>
			
			<div class="col-md-3">
				<input class="form-control" type="text" name="category"/>
			</div>
			<div class="col-md-2">
				<input class="btn btn-outline-warning btn-sm" type="submit" value="서브 카테고리 만들기" style="font-size:18px;"/>
			</div>
		</form>
	</c:forEach>
	
</body>
</html>