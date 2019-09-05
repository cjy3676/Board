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

  // id, pwd 값을 읽어오기
  String id = request.getParameter("id");
  String pwd = request.getParameter("pwd");
  
  // DB에 있는 pwd를 가져오기
  String sql = "select * from dat where id="+id;
  ResultSet rs = stmt.executeQuery(sql);
  rs.next();
  String temp = rs.getString("b_id");
  
  // 비밀번호를 비교후 삭제하기
  if(pwd.equals(rs.getString("pwd"))) {
	  sql = "delete from dat where id="+id;
	  stmt.executeUpdate(sql);
	  // 삭제후에 content.jsp로 이동
	  response.sendRedirect("content.jsp?id="+temp);
	  // 페이지 page, id, 검색관련데이터
  }
  else {
%>
  <script>
  alert("비밀번호가 틀렸습니다");
  history.back();
  </script>
<%
  }
%>  
  