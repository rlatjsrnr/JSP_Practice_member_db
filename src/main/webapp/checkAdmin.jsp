<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- checkAdmin.jsp -->
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session" />
<%
	if(loginMember.getId() == null || !loginMember.getId().equals("admin")){
		out.println("<script>");
		out.println("alert('올바른 접근이 아닙니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
%>

    