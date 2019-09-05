<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>    
<% 
    // write_ok.jsp => 폼의 입력값을 DB에 저장해주는 역할
    // DB연결 => Connection(연결), Statement(쿼리실행)
    String aa = "jdbc:mysql://localhost:3307/amudo?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);
	Statement stmt = conn.createStatement();
	
    // request되는 값의 한글코드처리
    request.setCharacterEncoding("utf-8");
    
    // 입력할 값을 write.jsp에서 가져오기 => request.getParameter()
    // 변수에 저장 => 계산을 하지 않는다면 String에 넣어도 된다.
    // 숫자계산이 있을경우는 숫자로 변형후에 사용해야된다
    String title = "안녕하심둥!!!";
    String content = "처음이올시다~ 앆!! 왂!!";
    String name = "캡틴 아메리카";

    String pwd = "123";
    
    // 사용자가 입력하지 않은 값이지만 테이블에 저정할 데이터
    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    // 표현할 날짜 형식의 객체를 생성
    String writeday = sdf.format(today);
    // 실행할 쿼리를 생성
    // String sql = "insert into board(title,content,name,age,sung,pwd,rnum,writeday) ";
    // sql = sql+"values('"+title+"','"+content+"','"+name+"',"+age+","+sung+",'"+pwd+"',0,'"+writeday+"')";
    for(int i=1; i<=800; i++) {
    // 정수형이 아니라서 곱하기 
    String age = (Math.random()*4)+""; 
    String sung = (Math.random()*1)+"";	
    String sql = "insert into board(title,content,name,age,sung,pwd,rnum,writeday)";
    sql = sql+" values(?,?,?,?,?,?,?,?)";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,title+i);
    pstmt.setString(2,content+i);
    pstmt.setString(3,name+i);
    pstmt.setString(4,age);
    pstmt.setString(5,sung);
    pstmt.setString(6,pwd);
    pstmt.setString(7,"0");
    pstmt.setString(8,writeday);
    
    // 쿼리를 실행
    pstmt.executeUpdate();
    }
    // Connection, Statement 객체의 해제
    // stmt.close();
    // conn.close();
    
    // list.jsp로 이동
    // response.sendRedirect("list.jsp");
%>
<!-- 
    웹에서 다름 문서로 이동하는 방법
    1. 자바스트립트 location => 사용자의 이벤트 후에 자바스크립트 함수에서 이동
    2. <a> 태그를 이용하여 => 현재 문서의 텍스트, 이미지등을 클릭에 의해 이동
    3. <form> 태그도 가능하다 => 전달할 값들을 가지고 있다
    4. <meta> 태그 사용 => 이동시간을 제어한다 (몇초뒤에 이동)
    5. jsp에서 response.sendRedirect()를 통해 => 서버쪽 코드에서 실행
 -->