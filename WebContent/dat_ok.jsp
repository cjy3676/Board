<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>    
<% 
    // dat_ok.jsp
    // DB연결 => Connection(연결), Statement(쿼리실행)
    String aa = "jdbc:mysql://localhost:3307/amudo?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);
	Statement stmt = conn.createStatement();
	
    // request되는 값의 한글코드처리
    request.setCharacterEncoding("utf-8");
    // 사용자가 입력하지 않은 값이지만 테이블에 저정할 데이터
    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    // 표현할 날짜 형식의 객체를 생성
    String writeday = sdf.format(today);
    // request로 값읽어오기
    String name = request.getParameter("name");
    String content = request.getParameter("content");
    String pwd = request.getParameter("pwd");
    String b_id = request.getParameter("b_id");
    
    // 쿼리작성
    String sql = "insert into dat(name,content,pwd,writeday,b_id)";
    sql = sql +" values('"+name+"','"+content+"','"+pwd+"','"+writeday+"',"+b_id+")";
    
    // 쿼리 실행
    stmt.executeUpdate(sql);
    
    // content.jsp로 이동 => id값
    response.sendRedirect("content.jsp?id="+b_id);
    
    // 객체 닫기
    stmt.close();
    conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>