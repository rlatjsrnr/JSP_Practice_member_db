<%@page import="java.util.Base64"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBCPUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session"/>
<jsp:setProperty name="loginMember" property="id" />
<jsp:setProperty name="loginMember" property="pass" />

<%
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String msg = "";
	String nextPage = "";
	
	String sql = "SELECT * FROM test_member WHERE id=? AND pass=?";
	
	try{		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,loginMember.getId());
		pstmt.setString(2,loginMember.getPass());
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			// 아이디와 페스워드가 일치하는 사용자 정보 존재
			loginMember.setNum(rs.getInt("num"));
			loginMember.setName(rs.getString("name"));
			loginMember.setAddr(rs.getString("addr"));
			loginMember.setPhone(rs.getString("phone"));
			loginMember.setGender(rs.getString("gender"));
			loginMember.setAge(rs.getInt("age"));
			
			msg = "로그인 성공";
			nextPage = "default";
			
			// 자동로그인 체크 - 로그인 상태 유지 요청 처리
			String login = request.getParameter("login");
			if(login != null){
				String id = loginMember.getId();
				byte[] bytes = id.getBytes();
				byte[] encodedID = Base64.getEncoder().encode(bytes);
				String encodeID = new String(encodedID);
				System.out.println("encodedID : " + encodeID);
				System.out.println("id : " + id);
				
				Cookie cookie = new Cookie("rememberMe", encodeID);
				cookie.setMaxAge(60*60*24);
				response.addCookie(cookie);
			}
			
		}else{
			// 일치하는 사용자 정보 없음
			msg = "로그인 실패";
			nextPage = "login";
			session.removeAttribute("loginMember");
		}		
	}catch(Exception e){
		msg = "로그인 실패";
		nextPage = "login";
		session.removeAttribute("loginMember");		
	}finally{
		DBCPUtil.close(rs, pstmt,conn);
		out.println("<script>");
		out.println("alert('"+msg+"');");
		out.println("location.href='index.jsp?page="+nextPage+"';");		
		out.println("</script>");
	}
	
%>