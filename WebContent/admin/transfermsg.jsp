<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    transfermsg.jsp
 * Description:  转移帖子

 */
--%>

<!DOCTYPE html>
<html>
<head>
<title>transfermsg</title>
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
			<li><a href="altermsg.jsp?boardID=<%=request.getParameter("boardID")%>&PID=0&msgID=0">返回</a></li>
		</ul>
	</div>
	</div>	
</nav>

	<%!
	
		public static final int PAGESIZE=5;
		int pageCount;
		int curPage=1;
	
	 %>
	 
<div class = "container" align = "center">
	<table class = "table table-hover">
	<tr>
		<td>当前板块号为：<%= request.getParameter("boardID") %></td>
	</tr>
	<tr>
		<td>转移的板块</td>
		<td></td>
	</tr>
	<%
	//out.print(session.getAttribute("userID"));
	bbs.Op_board show = new bbs.Op_board();
	java.util.ArrayList al= show.showBoard();
	
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
		bbs.BoardBean bb = (bbs.BoardBean)it.next();
		count++;
%>
<tr>
	<td><%=bb.getboardID() %></td>
	<td><%=bb.gettitle()%></td>
	<td><a href="transfersuccess.jsp?boardID=<%=bb.getboardID()%>
	&msgID=<%=request.getParameter("msgID")%>">转移</a></td>
</tr>
<%	
	}
	
%>
	
	</table>
	
	<table>
	<a href="transfermsg.jsp?curPage=1&msgID=<%=request.getParameter("msgID")%>
	&boardID=<%=request.getParameter("boardID")%>"><font size=2>首页&nbsp</font></a>
	<a href="transfermsg.jsp?curPage=<%=curPage-1 %>&msgID=<%=request.getParameter("msgID")%>
	&boardID=<%=request.getParameter("boardID")%>"><font size=2>上一页&nbsp</font></a>
	<a href="transfermsg.jsp?curPage=<%=curPage+1 %>&msgID=<%=request.getParameter("msgID")%>
	&boardID=<%=request.getParameter("boardID")%>"><font size=2>下一页&nbsp</font></a>
	<a href="transfermsg.jsp?curPage=<%=pageCount %>&msgID=<%=request.getParameter("msgID")%>
	&boardID=<%=request.getParameter("boardID")%>"><font size=2>尾页&nbsp</font></a>
	<font size=2>第<%=curPage %>页/共<%=pageCount %>页</font>
</table>
</div>

</center>
</body>

</html>
<jsp:include page="../include/footer.jsp" flush="true" />
<center><img src="../images/logo.jpg"></center>