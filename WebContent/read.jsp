<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%  // read.jsp
    // jsp문서에서 jsp코드에 있는 내용은 서버에서 실행된 후 클라이언트에는 실행된 결과의 문서만 간다
    // jsp코드내에서 발생된 값을 사용자에게 보여주려면 => html코드내에 출력을 시킨다
    String test = "안녕하세요";
    // 사용자에게는 실제 가는 내용은 html, css, javascript
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
     <%=test%>
</body>
</html>