<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>    
<%
    // content.jsp는 하나의 레코드의 내용을 전부 보여준다
    // DB연결
    String aa = "jdbc:mysql://localhost:3307/amudo?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);
	Statement stmt = conn.createStatement();
	
	// 읽어오고자 하는 레코드의 id, page값을 받기
	String id = request.getParameter("id");
	String Page = request.getParameter("page");
	
	// 사용자가 게시판에서 특정글을 읽었다면 것을 판단할수 있는 기준
    String sql = "update board set rnum=rnum+1 where id="+id;
    stmt.executeUpdate(sql);
    
	// 쿼리작성 => 하나의 레코드만 읽어오는 쿼리
	sql = "select * from board where id="+id;
	  
	// select한 결과값을 사용하려고 하면 ResultSet에 가져와야 된다.
	ResultSet rs = stmt.executeQuery(sql);
	
	// 하나의 레코드만 읽어온다..
	rs.next();
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 이름, 제목, 내용, 조회수, 작성일, 나이, 성별 -->
	<table width="600" border="1" cellspacing="0">
		<tr>
			<td>제목</td>
			<td colspan="3"><%=rs.getString("title")%></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=rs.getString("name")%></td>
			<td>조회수</td>
			<td><%=rs.getString("rnum")%></td>
		</tr>
		<tr height="200">
			<td>내용</td>
			<td colspan="3"><%=rs.getString("content")%></td>
		</tr>
		<%
			String age = "";
			switch (rs.getInt("age")) { // 10대 ~50대 => 0,1,2,3,4
			case 0: age = "10대"; break;
			case 1: age = "20대"; break;
			case 2: age = "30대"; break;
			case 3:	age = "40대"; break;
			case 4:	age = "50대"; break;
			}

			String sung;
			if (rs.getInt("sung") == 0) // 0이면 남자, 1이면 여자
				sung = "남자";
			else
				sung = "여자";
		%>
		<tr>
			<td>나이</td>
			<td><%=age%></td>
			<td>성별</td>
			<td><%=sung%></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td colspan="3"><%=rs.getString("writeday")%></td>
		</tr>
		<tr>
			<td colspan="4" align="center">
			<a href="update.jsp?id=<%=id%>">수정</a> 
			<a href="javascript:del()">삭제</a> 
			<a href="list.jsp?page=<%=Page%>">목록</a></td>
		</tr>
	</table>
	
	<div id="delete" style="display: none">
		<form method="post" action="delete_ok.jsp">
		    <!-- id, page 값 전달 -->
			<input type="hidden" name="id" value="<%=id%>">
			<input type="hidden" name="page" value="<%=Page%>"> 
			비밀번호 <input type="password" name="pwd"> 
			<input type="submit" value="삭제하기">
			<input type="button" onclick="hide()" value="취소"> 
		</form>
	</div>
	
	<!-- 비밀번호 입력폼을 숨겼다가 위의 삭제를 클릭하면 보이기 -->
	<script>
		function del() { // 비밀번호 입력폼을 보이게 하기
			document.getElementById("delete").style.display = "block";
		}
		function hide() {
			document.getElementById("delete").style.display = "none";
		}
	</script>
</body>
</html>