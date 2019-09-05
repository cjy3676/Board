<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
  // DB연결
  String aa = "jdbc:mysql://localhost:3307/amudo?useSSL=false";
  String bb = "root";
  String cc = "1234";
  Connection conn = DriverManager.getConnection(aa, bb, cc);
  Statement stmt = conn.createStatement();
  
  // 수정할 값을 request => id, name, content, pwd(그외 page, 검색)
  request.setCharacterEncoding("utf-8"); 		  
  String id = request.getParameter("id");
  String Page = request.getParameter("page");
  String name = request.getParameter("name");
  String content = request.getParameter("content");
  String pwd = request.getParameter("pwd");
  
  // DB에 있는 비밀번호를 가져오기
  String sql = "select * from dat where id="+id;
  ResultSet rs = stmt.executeQuery(sql);
  rs.next();
  String temp = rs.getString("b_id");
  // 비밀번호를 비교
  if(pwd.equals(rs.getString("pwd"))) {
	  // 쿼리 작성
	  sql = "update dat set name='"+name+"',content='"+content+"' where id="+id;
	  // 쿼리 실행 
	  stmt.executeUpdate(sql);
	  // content.jsp으로 이동 (id, page값, 검색값)
	  response.sendRedirect("content.jsp?id="+temp+"&page="+Page);
  }
  else {
%>
  <script>
     alert("비밀번호가 틀립니다");
     history.back;
  </script>
<%	  
  }
  stmt.close();
  conn.close();
%> 