<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    addboard.jsp
 * Description:  添加板块
 */
--%>
<%
if(request.getParameter("submit")!=null&&!"".equals(request.getParameter("submit"))){
	
	bbs.Op_board add = new bbs.Op_board();
	if(add.addBoard(request,session)){
		response.sendRedirect("../showboard.jsp");
	}
	else{
		out.print("插入数据失败");
	}
}




%>
<!DOCTYPE html>
<html>
<head>

<title>myBlog</title>
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
			<li><a href="../logout.jsp" onClick="{if(confirm('确定要注销吗')){return ture;}return false;}">注销</a></li>
			<%} %>
			<li><a href="../showboard.jsp">返回</a></li>
		</ul>
	</div>
	</div>	
</nav>
<center><img src="../images/logo.jpg"></center>
<form name="formBlog" action="addboard.jsp" method="post">

<div class = "container" align = "center">
<table class = "table table-hover">
<tr><td>新板块名称:<input type="text" name="title" size="50" value="无标题" maxlength="100">

<%
	//java.util.Date date = new java.util.Date();
	out.print(new java.util.Date());
%>
	
</td></tr>
<tr><td align="top">新板块介绍：</td></tr>
<tr><td align="top"><textarea name="content" cols="80" rows="15"></textarea></td></tr>
<tr><td align="center"><input type="submit" name="submit" value="submit"></td>

</table>
</div>
</form>
	
</center>

<jsp:include page="../include/footer.jsp" flush="true" />

</body>
</html>