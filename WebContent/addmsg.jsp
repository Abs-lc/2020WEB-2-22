
<%@page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>

<%--
/**
 * Title:    addmsg.jsp
 * Description:  发表文章
 */
--%>

<html>
<head>
	<title>addmsg</title>
	
	<script src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
	<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"  rel="stylesheet">
	<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	
</head>

<body>
<center>
<nav class = "navbar navbar-default" role = navigation>
	<div class = "container-fluid">
	<div class = "navbar-header">
		<a class="navbar-brand" href="#">小型BBS</a>
	</div>
	<div>
		<%if(session.getAttribute("userName")==null){ %>
		<ul class = "nav navbar-nav">
			<li><a href="login.jsp">登陆</a></li>
			<li><a href="reg.jsp">注册</a></li>
		</ul>
		<%}
		else{
		%>
		<ul class = "nav navbar-nav">
			<li><a href="#">欢迎<% out.print(session.getAttribute("userName")); %></a></li>
			<li><a href="logout.jsp" onClick="{if(confirm('确定要注销吗')){return ture;}return false;}">注销</a></li>
			<%} %>
			<li><a href="showmsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">返回</a></li>
		</ul>
	</div>
	</div>
</nav>

<%	


if(request.getParameter("submit")!=null&&!"".equals(request.getParameter("submit"))){
	
	bbs.Op_msg add = new bbs.Op_msg();
	String msg = add.addmsg(request,session);
	if("ok".equalsIgnoreCase(msg)){
		//response.sendRedirect("showaticle.jsp");
		out.println(request.getParameter("boardID"));
		out.println(request.getParameter("PID"));
		if(request.getParameter("submit").equalsIgnoreCase("reply")){
			response.sendRedirect("showaticle.jsp?boardID="+request.getParameter("boardID")+"&msgID="+
			request.getParameter("PID"));
		}
		else{
			response.sendRedirect("showmsg.jsp?boardID="+request.getParameter("boardID")+"&msgID="+
			request.getParameter("PID"));
		}
	}
	else{
		out.print(msg);
	}
}


%>

<p>&nbsp;</p>

<form name="formBlog" action="addmsg.jsp" method="post">


<input type="hidden" name="boardID" value="<%=request.getParameter("boardID")%>">
<input type="hidden" name="PID" 	value="<%=request.getParameter("msgID")%>">

<div class = "container" align = "center">
	<table class = "table table-hover">
		<tr>
			<td><td>文章主题:<input type="text" name="title" size="50" value="无主题" maxlength="100">
			<%
			//java.util.Date date = new java.util.Date();
			out.print(new java.util.Date());
			%></td>
		</tr>
		<tr>
			<td>文章内容：</td>
		</tr>
		<tr>
			<td><td align="top"><textarea name="content" cols="80" rows="15"></textarea></td>
		</tr>
		<tr>
			<td><td align="center"><input type="submit" name="submit" value="submit"></td>
		</tr>
	</table>
</div>

</form>

<jsp:include page="./include/footer.jsp" flush="true" />

</center>
</body>

</html>

<center><img src="./images/logo.jpg"></center>



