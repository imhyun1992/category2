<%@page import="java.util.ArrayList"%>
<%@page import="com.tjoeun.vo.CategoryVO"%>
<%@page import="com.tjoeun.service.CategoryService"%>
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
      <jsp:setProperty property="*"  name="vo"/>
   </jsp:useBean>

<%
   //삭제할 글 얻어옴
   CategoryService service = CategoryService.getInstance();
   
   CategoryVO original = service.selectByIdx(vo.getIdx());
   
   // 글 삭제
   //service.delete(vo.getIdx());
   
   
   //삭제된 카테고리를 삭제된 카테고리 입니다로 수정
   //service.deleteCategory(vo.getIdx());
   
   
   //삭제버튼이 눌리면 deleteCHeck 필드 값을 yes로 수정
   //service.deleteCheck(vo.getIdx());
   
   // 삭제시 삭제할 카테고리의 서브까지 같이 삭제
   // 카테고리+서브 목록을 얻어와 ArrayList에 저장
   ArrayList<CategoryVO> deleteList = service.deleteList(vo);
   for (int i=0;i<deleteList.size();i++){
//	   out.println(deleteList.get(i)+"<br/>");
   		service.delete(deleteList.get(i).getIdx());
   		//	브라우저 화며에 출력되는 마지막 카테고리는 다음 카테고리가 없기 떄문에 deletelist.get(i+1)를
   		//	실행하다가 IndexOutOfBoundsException이 발생되므로 예외 처리를 해줘야 한다.
   		try{
   			//	삭제할 카테고리의 seq에 1을 더한 값이 다음에 삭제하려는 카테고리의 seq와 같으면 다음에
   			//	삭제할 카테고리가 있다는 의미이므로 계속 반복해서 카테고리를 삭제하면 되지만 같지 않다면
   			//	부모 카테고리가 변경되서 다음에 삭제할 카테고리가 없다는 의밍므로 더 이상 삭제하면 
   			//	안되기 때문에 반복을 탈출한다.
		   		if(deleteList.get(i).getSeq() + 1 != deleteList.get(i+1).getSeq()){
		   				break;
		   		}
	   		}catch(IndexOutOfBoundsException e){
	   			
   			}
   }
   //	삭제작업이 실행된 카테고리 그룹의 seq를 0부터 1씩 증가하게 다시 부여하는 메소드를 실행한다.
   service.reSeq(original.getGup());
 //  out.println(original.getGup());
   
   //삭제 메시지 출력후 시작페이지로
   out.println("<script>");
//   out.println("alert('"+ original.getIdx() + "번 카테고리 부터 이하 카테고리 삭제')");   
   out.println("location.href='list.jsp'");
   out.println("</script>"); 
   

%>

</body>
</html>