<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.*" %>   
<%  // read_db.jsp => DB에 있는 내용을 가져와서 html에 출력
    // DB => 입력, 출력, 수정, 삭제
    // 출력 => 쿼리중에 select 사용
    // DB에 연결하는 문서는 무조건 DB연결클래스가 필요
    // DB연결 Connection(연결) ,Statement(명령문)
    String aa="jdbc:mysql://localhost:3307/amudo?useSSL=false";
    String bb="root";
    String cc="1234";
    Connection conn = DriverManager.getConnection(aa,bb,cc); 
    Statement stmt=conn.createStatement();
    
    // 원하는 데이터 읽어오기 (select)
    String sql="select * from board"; // board라는 테이블에서 모든필드를 가져와라
    ResultSet rs=stmt.executeQuery(sql); // executeUpdate()=>나머지, executeQuery()=>select
    // rs객체에 테이블의 모든 내용을 가지고 온다
    rs.next(); // 1행으로 이동
    // 레코드를 가리키고 있다(레코드포인터)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
     <%=rs.getString("name")%>
</body>
</html>