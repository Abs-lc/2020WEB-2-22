<%@page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    showmsg.jsp
 * Description:  显示文章

 */
--%>

<!DOCTYPE html>
<html>

<head>

<title>showmsg</title>

	<script src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
	<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"  rel="stylesheet">
	<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>


</head>

</html>


<style>
a:link{
text-decoration:none;
}
a:hover{
text-decoration=underline;
}
</style>

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
			<li><a href="showboard.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">返回</a></li>
		</ul>
		<%}
		else{
		%>
		<ul class = "nav navbar-nav">
			<li><a href="#">欢迎<% out.print(session.getAttribute("userName")); %></a></li>
			<li><a href="logout.jsp" onClick="{if(confirm('确定要注销吗')){return ture;}return false;}">注销</a></li>
			<li><a href="addmsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">发表文章</a></li>
			<li><a href="/miniBBS/admin/altermsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">编辑文章</a></li>
			<li><a href="showboard.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">返回</a></li>
		</ul>
		<%} %>
	</div>
	</div>
</nav>

<center><img src="./images/logo.jpg"></center>

<%!
	
		public static final int PAGESIZE=5;
		int pageCount;
		int curPage=1;
	
%>

<center>

<div class = "container" align="center">
	<table class = "table table-hover">
		<thead>
			<tr>
				<td>主题</td>
				<td>发表时间</td>
				<td>作者</td>
				<td align="center">点击数</td>
				<td align="center">回复数</td>
			</tr>			
		</thead>
		
<%
	bbs.Op_msg 		show	= new bbs.Op_msg();
	java.util.ArrayList al 		= show.showmsg(request);
	if(al==null){
%>
<jsp:forward page="error.jsp">
	<jsp:param name="msg" value="未知板块" />
</jsp:forward>

<%	
	}
	
	//得到共有几行记录
	int size = al.size();
	pageCount=(size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);
	String temp=request.getParameter("curPage");
	if(temp==null){
		temp="1";
	}
	curPage=Integer.parseInt(temp);
	int count=0;
	java.util.Iterator it =al.iterator();
	//把迭代器调到需要当前页面的第一条需要显示的位置
	for(int i=0;i<((curPage-1)*PAGESIZE);i++){
		it.next();
	}
	
	while(it.hasNext()){
		if(count>=PAGESIZE)break;
		bbs.ForumBean 	fb 	= (bbs.ForumBean)it.next();
		count++;
%>
	<tbody>
	<tr>
	<td>
	<%if(fb.getflag()==1){ %>
	<font color="red">[top]</font>
	<%} %>
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
	</tbody>
		
	</table>
</div>

</center>

<!-- ---------------------------------------------- -->

<center>
<table>
	<%if(pageCount!=1) {%>
	<a href="showmsg.jsp?curPage=1&boardID=<%=request.getParameter("boardID")%>"><font size=2>首页&nbsp</font></a>
	<a href="showmsg.jsp?curPage=<%=curPage-1 %>&boardID=<%=request.getParameter("boardID")%>"><font size=2>上一页&nbsp</font></a>
	<a href="showmsg.jsp?curPage=<%=curPage+1 %>&boardID=<%=request.getParameter("boardID")%>"><font size=2>下一页&nbsp</font></a>
	<a href="showmsg.jsp?curPage=<%=pageCount %>&boardID=<%=request.getParameter("boardID")%>"><font size=2>尾页&nbsp</font></a>
	<font size=2>第<%=curPage %>页/共<%=pageCount %>页</font>
	<%} %>
</table>
</center>



</center>
<!-- ---------------------------------------------- -->
<jsp:include page="./include/footer.jsp" flush="true" />