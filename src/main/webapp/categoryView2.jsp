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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="./js/formCheck.js" type="text/javascript" defer="defer"></script>
</head>
<body class="p-3">
	<h1 class="m-3">Category Project</h1>
	<!-- javascript로 메인 카테고리 입력 폼 체크 -->
	<form id="form" class="row m-3" action="insert.jsp" method="post">
		<div class="col-md-3">
			<input id="category" class="form-control" type="text" name="category"/>
		</div>
		<div class="col-md-2">
			<input class="btn btn-outline-primary btn-sm" type="submit" value="메인 카테고리 만들기" style="font-size:18px;"/>
		</div>
	</form>
	<!-- bootstrap과 속성이 겹쳐서 속성입력이 안되면 style=""을 이용해서 스타일 넣는다. -->
	<hr style="color:red;"/>
	
	<!-- 서브 카테고리 개수만큼 반복하며 카테고리 목록을 출력하고 서브 카테고리를 입력받는다. -->
	<c:forEach var="vo" items="${categoryList.list}">
		<!-- 서브 카테고리를 입력하는 모든 폼에 다른 name 속성이 지정되야 식별이 가능하므로 폼 이름을 만든다. -->
		<c:set var="formName" value="form${vo.idx}"></c:set>
		<!-- jQuery로 서브 카테고리 입력 폼 체크 -->
		<form class="sub_form row m-1" action="reply.jsp" method="post" name="${formName}">
			<!-- idx, gup, lev, seq를 표시하는 텍스트 상자는 텍스트가 완료되면 모두 hidden으로 처리한다. -->
				<c:if test="${vo.deleteCheck!='YES'}">
					<%-- <c:if test="${fn:trim(vo.deleteCheck)eq'NO'}"> --%>
					<div class="col-md-4">
					<div style="display:none">
						<input type="text" name="idx" value="${vo.idx}" size="1"/>
						<input type="text" name="gup" value="${vo.gup}" size="1"/>
						<input type="text" name="lev" value="${vo.lev}" size="1"/>
						<input type="text" name="seq" value="${vo.seq}" size="1"/>
					</div>
						<!-- 카테고리 레벨(lev)에 따른 들여쓰기를 한다. -->
						<c:if test="${vo.lev>0}">
							<c:forEach var="i" begin="1" end="${vo.lev}" step="1">
							&nbsp;&nbsp;&nbsp;&nbsp;
							</c:forEach>
							<img alt="화살표" src="./images/enter.png" width="15"/>
						</c:if>
						<%-- <span>${vo.category}</span> --%>
						<span>${vo.category}</span>
					</div>
					<div class="col-md-3">
						<input class="sub_category form-control" type="text" name="category" placeholder="내용을 입력하세요."/>
					</div>
				</c:if>
				
 				<%-- <c:if test="${fn:trim(vo.deleteCheck)eq'YES'}"> --%>
				<c:if test="${vo.deleteCheck=='YES'}">
					<div class="col-md-7">
					<span>삭제된 카테고리입니다.</span>
					</div>
				</c:if>
			
			<div class="col-md-5">
				
				<c:if test="${vo.deleteCheck=='YES'}">
					<input disabled="disabled" class="btn btn-outline-dark" type="submit" value="서브 카테고리 만들기" style="font-size:18px;"/>
					<!-- 수정버튼 -->
					<input class="btn btn-outline-success" 
					type="submit"
					type="button" value="수정" 
					disabled="disabled"
					style="font-size:18px;" 
					/>
					<!-- 복구버튼 -->
<%-- 					<input class="btn btn-outline-warning" 
					type="button" value="복구" 
					style="font-size:18px;" 
					onclick="location.href='restore.jsp?idx=${vo.idx}'"/> --%>
					<input class="btn btn-outline-warning" 
					type="button" value="복구" 
					style="font-size:18px;" 
					onclick="location.href='restore.jsp?idx=${vo.idx}'"/>
					<!-- 신고버튼 -->
					<input class="btn btn-warning" 
					type="button" value="!" 
					style="font-size:18px;" 
					disabled="disabled"
					onclick="mySubmitRestore(${formName})"/>
				</c:if>
				<c:if test="${vo.deleteCheck!='YES'}">
					<input class="btn btn-outline-dark" type="submit" value="서브 카테고리 만들기" style="font-size:18px;"/>
					
					<!-- 수정버튼 -->
					<input class="btn btn-outline-success"
					type="button" value="수정" 
					style="font-size:18px;" 
					onclick="mySubmitUpdate(${formName})"/>
					
					<!-- 삭제버튼 -->
<%-- 					<input class="btn btn-outline-danger" 
					type="button" value="삭제" 
					style="font-size:18px;" 
					onclick="location.href='delete.jsp?idx=${vo.idx}'"/> --%>
					<input class="btn btn-outline-danger" 
					type="button" value="삭제" 
					style="font-size:18px;" 
					onclick="mySubmitDelete(${formName})"/>
					
					<!-- 신고버튼 -->
<%-- 					<input class="btn btn-danger" 
					type="button" value="신고" 
					style="font-size:18px;" 
					onclick="location.href='report.jsp?idx=${vo.idx}'"/> --%>
					<input class="btn btn-warning" 
					type="button" value="!" 
					style="font-size:18px;" 
					onclick="mySubmitReport(${formName})"/>
				</c:if>
				<span>신고횟수:${vo.report}</span>
			</div>
		</form>
	</c:forEach>
	
</body>
</html>