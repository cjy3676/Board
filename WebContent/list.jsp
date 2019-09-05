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
	
	// 전체 레코드의 갯수를 가져오기
	request.setCharacterEncoding("utf-8");
    // 가져올 쿼리 작성 => select(보기)
    int start, Page; // 현재 페이지값이 들어갈 변수
    if(request.getParameter("page") == null) {
    	start = 0; // 1 page => 가장 처음 접근할때 : page 값을 넘기지 않았을때
    	Page = 1;		
    }
    else {
    	// 사용자가 원하는 page값이 request된다
        Page = Integer.parseInt(request.getParameter("page"));
        start = (Page-1)*10;
    }
    // 검색하고자 하는 필드와 검색단어를 가져오기
    String cla, s_word, sql;
    cla = request.getParameter("cla");
    s_word = request.getParameter("s_word");
    if(cla == null) {
    sql = "select * from board order by id desc limit "+start+",10";
    cla = "";
    s_word = ""; // 검색창에 null값을 표시하지 않기 위해 
    }
    else if(cla.equals("0"))
    	sql = "select * from board where title like '%"+s_word+"%' order by id desc limit "+start+",10";
    else if(cla.equals("1"))
    	sql = "select * from board where content like '%"+s_word+"%' order by id desc limit "+start+",10";
    else
    	sql = "select * from board where name like '%"+s_word+"%' order by id desc limit "+start+",10";
    // select한 결과값을 사용하려고 하면 ResultSet에 가져와야 된다
    out.println(sql);
    ResultSet rs = stmt.executeQuery(sql);
    // 레코드 출력
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script>
function search_sub() {
	<% 
	if(cla != "") {
	%>
	document.search.cla.selectedIndex=<%=cla%>;
	<%
	}
	%>
	document.getElementById("pp").selectedIndex=<%=Page-1%>;
}
function move_list(val) {
	location = "list.jsp?page="+val+"&cla=<%=cla%>&s_word=<%=s_word%>";
}
function select_init() {
	document.getElementById("pp").selectedIndex=<%=Page-1%>;
}
select_init();
</script>
<style>
a {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body onload=search_sub()>
	<table align="center" width="700" border="1" cellspacing="0">
		<caption>
		    <!-- 머리부분 -->
			<h2>게시판</h2>
			<!-- 검색부분 -->
			<form method="post" action="list.jsp" name="search">
			<select name="cla">
			<option value="0">제목</option>
			<option value="1">내용</option>
			<option value="2">작성자</option>
			</select>
			<input type="text" name="s_word" value="<%=s_word%>" size="8">
			<input type="submit" value="검색">
			</form>
		</caption>
		<!-- 리스트의 종류 -->
		<tr height="30" align="center">
			<td>이름</td>
			<td>제목</td>
			<td>조회수</td>
			<td>작성일</td>
		</tr>
		<!-- 리스트 내용 -->
		<%
			while (rs.next()) {
		%>
		<tr height="40">
			<td align="center"><%=rs.getString("name")%></td>
			<td align="center"><a href="add.jsp?id=<%=rs.getString("id")%>&page=<%=Page%>"><%=rs.getString("title")%></a></td>
			<td align="center"><%=rs.getString("rnum")%></td>
			<td align="center"><%=rs.getString("writeday")%></td>
		</tr>
		<%
		// 레코드 출력
		/* while(rs.next()) { // 레코드가 존제하면 true, 없으면 false
			// rs 객체를 만든후에 처음실행하면 첫번째 레코드로 이동
			out.print(rs.getString("name")+" ");
			out.print(rs.getString("title")+" ");
			out.print(rs.getString("rnum")+" ");
			out.print(rs.getString("writeday"));
			out.print("<br>");
		} */
			}
		%>
		<tr>
			<td colspan="4" align="right"><a href="write.jsp">글쓰기</a></td>
		</tr>
		<tr>
		<td colspan="4" align="center" style="word-spacing:10px">
		<%
		  // page 변수
		  int pstart, pend;
		
		  // 전체 레코드 갯수 알아오기
		  if(cla == null)
		      sql = "select count(id) as cnt from board";
		  else if(cla.equals("0"))
			  sql = "select count(id) as cnt from board where title like '%"+s_word+"%'";
		  else if(cla.equals("1"))
			  sql = "select count(id) as cnt from board where content like '%"+s_word+"%'";
		  else 
			  sql = "select count(id) as cnt from board where name like '%"+s_word+"%'";
		  rs = stmt.executeQuery(sql);
		  rs.next();
		  int total_record = rs.getInt("cnt");
		  
		  // 레코드수를 가지고 페이지 계산하기
		  int page_cnt = total_record/10;
		  if(total_record%10 != 0)
			  page_cnt = page_cnt+1;
		  
		  // 페이지 링크에 필요한 시작값 생성
		  pstart = (int)Page/10;
		  if(Page%10 == 0)
			  pstart = pstart - 1;
		  pstart = Integer.parseInt(pstart+"1");
		  // 마지막 구역에서는 pstart부터 마지막 페이지까지만 출력
		  pend = pstart + 9;
		  
		  // 출력될 페이지 값이 전체페이지 값보다 크다면 출력페이지의 끝값을 전체페이지값으로 변경
		  if(pend > page_cnt) 
			  pend = page_cnt;
		%>
		<!-- 첫번째 페이지로 이동 -->
		<a href="list.jsp?page=1&cla=<%=cla%>&s_word=<%=s_word%>">처음</a>
		
		<!-- 페이지 출력되는 첫구역 값은(pstart=1) 링크를 해제 -->
		<%
		if(pstart == 1) {
		%>
		◁◀
		<%
		}
		else {
		%>
		<a href="list.jsp?page=<%=pstart-1%>&cla=<%=cla%>&s_word=<%=s_word%>">◁◀</a>
		<%
		}
		%>
			
		<!-- 현재페이지에서 이전으로 이동, 1페이지이면 비활성화 -->
		<% 
		if(Page != 1) { // 1페이지가 아니면
		%>
		<a href="list.jsp?page=<%=Page-1%>&cla=<%=cla%>&s_word=<%=s_word%>">이전</a>
		<%
		}
		else {
		%>
		이전
		<%
		}
		// 현재 페이지의 숫자를 빨간색으로
		String color = "";
		for(int i=pstart; i<=pend; i++) {
			if(Page == i) // 현재페이지랑 출력되는 i값이 같을때
			color = "style='color:red'";
			else
				color = "";
		  // page 변수(1~10)에 존재
		%>
		<a href="list.jsp?page=<%=i%>&cla=<%=cla%>&s_word=<%=s_word%>" <%=color%>><%=i%></a>
		<%
		  }
		%>
		<!-- 현재페이지에서 다음페이지로 이동, 마지막페이지면 비활성화 -->
		<% 
		if(Page != page_cnt) {
	    %>
	    <a href="list.jsp?page=<%=Page+1%>&cla=<%=cla%>&s_word=<%=s_word%>">다음</a>
		<%
		}
		else {
		%>
		다음
		<%
		}
		%>
		<!-- 페이지 출력 마지막 구역(pend == page_cnt)일때는  링크 해제 -->
		<% 
		if(pend != page_cnt) {
		%>
		▶▷
		<%
		}
		else {
		%>
		<a href="list.jsp?page=<%=pend+1%>&cla=<%=cla%>&s_word=<%=s_word%>">▶▷</a>
		<%
		}
		%>
	    <!-- 끝페이지로 이동 -->
	    <a href="list.jsp?page=<%=page_cnt%>&cla=<%=cla%>&s_word=<%=s_word%>">마지막</a>
	    
	    <select id="pp" onchange="move_list(this.value)">
	    <%
	    for(int i=1; i<=page_cnt; i++) {
	    %>
	    <option value=<%=i%>><%=i%>page</option>
	    <%
	    }
	    %>
	    </select>
		</td>
		</tr>
	</table>
</body>
</html>
<%
  rs.close();
  stmt.close();
  conn.close();
%>