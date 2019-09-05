<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>    
<%
    // delete_ok.jsp
    
    // DB연결
    String aa = "jdbc:mysql://localhost:3307/amudo?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);
	Statement stmt = conn.createStatement();
	
	// id, pwd 값을 읽어오기
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String Page = request.getParameter("page");
	
	// DB에 있는 비밀번호를 읽어오기
	String sql = "select * from board where id="+id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	
	// 비밀번호를 비교
	if(pwd.equals(rs.getString("pwd"))) { // 참 => 비밀번호 일치
	    // 삭제명령을 실행
		sql = "delete from board where id="+id;
		stmt.executeUpdate(sql);
		// 삭제 후에 list.jsp 이동
		response.sendRedirect("list.jsp?page="+Page);
	}
	else {
%>
<script>
alret("비밀번호가 틀립니다");
history.back();
</script>
<%
}
%>