<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    showcomment.jsp
 * Description:  显示留言板

 */
--%>

<!DOCTYPE html>
<html>
<head>
<title>showcomment</title>
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
			<li><a href="../showboard.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">返回</a></li>
		</ul>
	</div>
	</div>	
</nav>
<center><img src="../images/logo.jpg"></center>
	<%!
	
		public static final int PAGESIZE=5;
		int pageCount;
		int curPage=1;
	
	 %>
	 
</center>
<div class = "container" align = "center">
<table class = "table table-hover">
	<tr>
		<td>留言主题</td>
		<td>留言内容</td>
		<td>留言用户名</td>
		<td>留言用户ID</td>
		<td>留言时间</td>
	</tr>
	<%
	bbs.Op_comment 		show	= new bbs.Op_comment();
	java.util.ArrayList al 		= show.showcomment(request);

	
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
		bbs.CommentBean 	cb 	= (bbs.CommentBean)it.next();
		count++;
%>
<tr>
	<td><%=cb.gettitle()%></td>
	<td width="35%"><%=cb.getcontent()%></td>
	<td width="15%"><%=cb.getuserName()%></td>
	<td width="15%"><%=cb.getuserID()%></td>
	<td width="15%"><%=cb.gettime()%></td>
	<td width="5%"><a href="deletecomment.jsp?commentID=<%=cb.getcommentID()%>" 
	onclick="javascript:  return  confirm('是否确认删除本条记录?')">删除</a></td>
</tr>
<%	
	}
	
%>

<tr></tr>
</table>

</div>

<center>
<table>
	<%if(pageCount!=1) {%>
	<a href="showcomment.jsp?curPage=1"><font size=2>首页&nbsp</font></a>
	<a href="showcomment.jsp?curPage=<%=curPage-1 %>"><font size=2>上一页&nbsp</font></a>
	<a href="showcomment.jsp?curPage=<%=curPage+1 %>"><font size=2>下一页&nbsp</font></a>
	<a href="showcomment.jsp?curPage=<%=pageCount %>"><font size=2>尾页&nbsp</font></a>
	<font size=2>第<%=curPage %>页/共<%=pageCount %>页</font>
	<%} %>
</table>
</center>
</body>
<jsp:include page="../include/footer.jsp" flush="true" />
</html>
