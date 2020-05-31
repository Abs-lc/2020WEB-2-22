<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'failure.jsp' starting page</title>
    
    <script src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
	<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"  rel="stylesheet">
	<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

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
			<li><a href="showboard.jsp">返回</a></li>
		</ul>
	</div>
	</div>
</nav>
<center><img src="./images/logo.jpg"></center>
  <br/>
  		<%if(session.getAttribute("userName")==null){ %>
  		对不起游客，您没有权限，请先登录或注册
  		<%}
  		else{ %>
    	对不起<% out.print(session.getAttribute("userName")); %>，您没有访问权限<br/>
  		<%} %>
  <br/>
  </center>
  </body>
</html>

<jsp:include page="./include/footer.jsp" flush="true" />
