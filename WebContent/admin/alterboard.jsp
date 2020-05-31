<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    alterboard.jsp
 * Description:  修改板块信息
 */
--%>
<%
	bbs.Op_board alter = new bbs.Op_board();
	System.out.print(request.getParameter("boardID"));
	bbs.BoardBean bb = alter.showOneBoard(request);
	System.out.print(bb.getauthor());
	if(request.getParameter("submit")!=null&&!"".equals(request.getParameter("submit")))
	{
		
		System.out.println("in if here");
		if(alter.alterBoard(request)){
			response.sendRedirect("../showboard.jsp");
			
		}
		else{
			out.print("插入数据失败");
		}
	}


%>
<html>
<head>

<title>alterboard</title>
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

<form name="formBlog" action="alterboard.jsp" method="post">

<div class = "container" align = "center">
	<table class = "table table-hover">
	<tr><td>板块名称:<input type="text" name="title" size="50" value="<%=bb.gettitle()%>" maxlength="100">
	
	</td></tr>
	<tr><td align="top">板块介绍:</td></tr>
	<tr><td align="center"><textarea name="content" cols="80" rows="15"><%=bb.getcontent()%></textarea></td></tr>
	<tr><td align="top"><input type="hidden" name="boardID" value="<%=request.getParameter("boardID")%>"></td></tr>
	<tr><td align="center"><input type="submit" name="submit" value="submit"></td>
	</table>
</div>

</form>

</center>


	

<jsp:include page="../include/footer.jsp" flush="true" />

</body>
</html>