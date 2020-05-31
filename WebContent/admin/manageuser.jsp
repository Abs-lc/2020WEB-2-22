<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="bbs.*" %>
<%--
/**
 * Title:    manageruser.jsp
 * Description:  管理用户

 */
--%>

<!DOCTYPE html>
<html>
<head>
<title>manageruser</title>
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

<%!
	
		public static final int PAGESIZE=5;
		int pageCount;
		int curPage=1;
	
%>

<div class = "container" align = "center">
<table class = "table table-hover">
	<tr>
	<td>ID</td>
	<td>用户名</td>
	<td>性别</td>
	<td>手机号</td>
	<td>E-mail</td>
	<td>注册时间</td>
	<td>注册IP</td>
	<td>权限</td>
	<td></td>
	</tr>
	<%
	bbs.Op_user 		show	= new bbs.Op_user();
	java.util.ArrayList al 		= show.showuser(request);
	if(al==null){
		out.println("user的al数组里为空");
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
		bbs.UserBean 	ub 	= (bbs.UserBean)it.next();
		count++;
%>

<tr>
	<td><%=ub.getuserID()%></td>
	<td><%=ub.getuserName()%></td>
	<td><%=ub.getsex()%></td>
	<td><%=ub.getphone()%></td>
	<td><%=ub.getemail()%></td>
	<td align="center"><%=ub.getregTime()%></td>
	<td align="center"><%=ub.getregIP()%></td>
	<td><%if(ub.getproperty()==1){out.print("管理员");}else{out.print("百姓");}%></td>
	<td><a href="deleteuser.jsp?userID=<%=ub.getuserID()%>" 
		onclick="javascript:  return  confirm('是否确认删除本条记录?')">删除</a></td>
	<td><a href="alterauthority.jsp?userID=<%=ub.getuserID()%>&property=<%=ub.getproperty() %>">
		<%if(ub.getproperty()==1){out.print("降职");}else{out.print("升职");}%></a></td>
</tr>
<%	
	}
	
%>

<tr></tr>
	
</table>

<table>
	<%if(pageCount!=1) {%>
	<a href="manageuser.jsp?curPage=1"><font size=2>首页&nbsp</font></a>
	<a href="manageuser.jsp?curPage=<%=curPage-1 %>"><font size=2>上一页&nbsp</font></a>
	<a href="manageuser.jsp?curPage=<%=curPage+1 %>"><font size=2>下一页&nbsp</font></a>
	<a href="manageuser.jsp?curPage=<%=pageCount %>"><font size=2>尾页&nbsp</font></a>
	<font size=2>第<%=curPage %>页/共<%=pageCount %>页</font>
	<%} %>
</table>
</div>

</center>
</body>
</html>

<jsp:include page="../include/footer.jsp" flush="true" />