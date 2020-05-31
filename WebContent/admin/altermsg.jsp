<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    altermsg.jsp
 * Description:  管理员编辑文章

 */
--%>

<%--
/**
<a href="addmsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">发表文章</a>
<a href="/admin/altermsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">编辑文章</a>
 */
--%>

<!DOCTYPE html>
<html>
<head>
	<title>altermsg</title>
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
			<li><a href="../logout.jsp" onClick="{if(confirm('确定要注销吗')){return ture;}return false;}">注销</a>
			<%} %>
			<li><a href="../showmsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">返回</a></li>
		</ul>
	</div>
	</div>
	
</nav>

<div class = "container" align = "center">
	<table class = "table table-hover">
	<tr>
		<td>状态</td>
		<td>标题</td>
		<td>发布时间</td>
		<td>作者</td>
		<td>点击数</td>
		<td>回复数</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<%
	bbs.Op_msg 		show	= new bbs.Op_msg();
	java.util.ArrayList al 		= show.showmsg(request);
	if(al==null){
%>
<jsp:forward page="../error.jsp">
	<jsp:param name="msg" value="未知板块" />
</jsp:forward>

<%	
	}
	java.util.Iterator 	it 		= al.iterator();
%>

	<%
		while(it.hasNext()){
			bbs.ForumBean 	fb 	= (bbs.ForumBean)it.next();
	%>
	
		<tr>
		<td><%if(fb.getflag()==1){%>top<%}%></td>
		<td align="center">
		<a href="../showaticle.jsp?msgID=<%=fb.getmsgID()%>&PID=<%=fb.getPID()%>&boardID=<%=fb.getboardID()%>">
		<%=fb.gettitle()%>
		</a></td>
		<td><%=fb.getfirstTime()%></td>
		<td><%=fb.getauthor()%></td>
		<td align="center"><%=fb.getclicks()%></td>
		<td align="center"><%=fb.getreplies()%></td>
		<td><a href="altertop.jsp?msgID=<%=fb.getmsgID()%>&boardID=<%=request.getParameter("boardID")%>
		&flag=<%=fb.getflag()%>">
		<%if(fb.getflag()==1){out.print("取消置顶");}else{out.print("置顶");}%></a></td>
		<td><a href="deletemsg.jsp?msgID=<%=fb.getmsgID()%>&boardID=<%=request.getParameter("boardID")%>" 
		onclick="javascript:  return  confirm('是否确认删除本条记录?')">删除</a></td>
		<td><a href="transfermsg.jsp?msgID=<%=fb.getmsgID()%>&boardID=<%=request.getParameter("boardID")%>" 
		>转移</a></td>
	</tr>
	<%	
		}
		
	%>
	</table>
</div>

</center>
</body>
</html>

<center><img src="../images/logo.jpg"></center>

