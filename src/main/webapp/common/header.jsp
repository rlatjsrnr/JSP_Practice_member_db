<%@page import="java.sql.*"%>
<%@page import="util.DBCPUtil"%>
<%@page import="java.util.Base64"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- header.jsp -->
 <jsp:useBean id="loginMember" class="vo.MemberVO" scope="session" />
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("rememberMe")){
				// 자동 로그인 용으로 등록한 cookie가 존재
				String value = c.getValue();
				
				// aWQwMDE=
				byte[] bytes = Base64.getDecoder().decode(value.getBytes());
				String id = new String(bytes);
				
				// cookie로 등록된 사용자 정보 확인 - id가 일치하는 사용자
				String sql = "SELECT * FROM test_member WHERE id=?";
				Connection conn = DBCPUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()){
					loginMember.setNum(rs.getInt("num"));
					loginMember.setId(rs.getString("id"));
					loginMember.setPass(rs.getString("pass"));
					loginMember.setName(rs.getString("name"));
					loginMember.setAddr(rs.getString("addr"));
					loginMember.setPhone(rs.getString("phone"));
					loginMember.setGender(rs.getString("gender"));
					loginMember.setAge(rs.getInt("age"));
				}		
				DBCPUtil.close(rs, pstmt, conn);
				break;
			}
		}
	}
%>
<ul>
 	<li><a href="index.jsp">home</a></li>
 	<%if(loginMember.getName() == null){ %>
	<li><a href="index.jsp?page=login">로그인</a></li>
 	<li><a href="index.jsp?page=join">회원가입</a></li> 	
 	<%
 		session.removeAttribute("loginMember");
 	}else{ 		
 	%>
 		<li><a href="index.jsp?page=info"><jsp:getProperty name="loginMember" property="name" /></a>님 방가방가 </li>
 		<%if(loginMember.getId().equals("admin")){ %>
 			<li><a href="index.jsp?page=memberList">회원관리</a></li>
 		<%} %>
 		<li><a href="logout.jsp">로그아웃</a></li>
 	<%}%>
 </ul>
 
 
 
 
 
 
 
 
 