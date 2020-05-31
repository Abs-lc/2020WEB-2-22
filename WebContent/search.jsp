<%@page contentType="text/html;charset=UTF-8"
pageEncoding="utf-8" %>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    search.jsp
 * Description:  显示搜索的文章

 */
--%>
<!DOCTYPE html>
<<html>
<head>
<title>search</title>
	<script src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
	<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"  rel="stylesheet">
	<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>

</head>

<body>
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

<center>
<div class = "container" align = "center">
<table class = "table table-hover">
	<thead>
	<tr>
		<td>主题</td>
		<td>发布时间</td>
		<td>作者</td>
		<td>点击数</td>
		<td>回复数</td>
	</tr>
	</thead>
<%
	bbs.Op_msg 		show	= new bbs.Op_msg();
	java.util.ArrayList al 		= show.search(request);
	if(al==null){
%>
<jsp:forward page="error.jsp">
	<jsp:param name="msg" value="未知板块" />
</jsp:forward>

<%	
	}
	java.util.Iterator 	it 		= al.iterator();
	while(it.hasNext()){
		bbs.ForumBean 	fb 	= (bbs.ForumBean)it.next();
%>
<tr>
	<td>
	<a href="showaticle.jsp?msgID=<%=fb.getmsgID()%>&PID=<%=fb.getPID()%>&boardID=<%=fb.getboardID()%>">
	<%=fb.gettitle()%>
	</a></td>
	<td><%=fb.getfirstTime()%></td>
	<td><%=fb.getauthor()%></td>
	<td align="center"><%=fb.getclicks()%></td>
	<td align="center"><%=fb.getreplies()%></td>
</tr>
<%	
	}
	
%>
</table>
</div>
</center>
</body>

</html>

<jsp:include page="./include/footer.jsp" flush="true" />