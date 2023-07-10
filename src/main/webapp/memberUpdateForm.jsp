<%@page import="vo.MemberVO"%>
<%@page import="util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkAdmin.jsp" %>

<!-- memberUpdateForm.jsp -->
<%
	String sql="SELECT * FROM test_member WHERE num=?";
	String num = request.getParameter("num");
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	MemberVO vo = null;
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(num));
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			// 일치하는 회원정보 찾음
			vo = new MemberVO();
			vo.setNum(rs.getInt(1));
			vo.setId(rs.getString(2));
			vo.setPass(rs.getString(3));
			vo.setName(rs.getString(4));
			vo.setAddr(rs.getString(5));
			vo.setPhone(rs.getString(6));
			vo.setGender(rs.getString(7));
			vo.setAge(rs.getInt(8));
			
		}else{
			throw new NullPointerException("회원정보 없음");
		}
	}catch(Exception e){
		out.println("<script>");
		out.println("alert('입력하신 회원정보가 존재하지 않습니다.');");
		out.println("history.go(-1);");
		out.println("</script>");
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
%>
<script type="text/javascript" src="js/inputCheck.js"></script>

<form action="memberUpdate.jsp" method="POST">
	<input type="hidden" name="num" value="<%=vo.getNum()%>" />
	<table>
		<tr>
			<td colspan="2"><h1>회원수정</h1></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="id" value="<%=vo.getId()%>" data-msg="아이디" />
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pass" value="<%=vo.getPass()%>" data-msg="비밀번호" />
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" value="<%=vo.getName()%>" data-msg="이름" />
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>
				<input type="text" name="addr" value="<%=vo.getAddr()%>" data-msg="주소" />
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="phone" value="<%=vo.getPhone()%>" data-msg="전화번호" />
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<label>
				<input type="radio" name="gender" value="남성" <%=vo.getGender().equals("남성") ? "checked" : ""%> />
				남성
				</label>
				<label>
				<input type="radio" name="gender" value="여성" <%=vo.getGender().equals("여성") ? "checked" : ""%> />
				여성
				</label>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input type="number" name="age" value="<%=vo.getAge()%>" data-msg="나이"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button>회원수정</button>
			</td>
		</tr>
	</table>
</form>










