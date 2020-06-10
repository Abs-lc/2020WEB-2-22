<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>划水摸鱼交流论坛</title>
    
	<script src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
	<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"  rel="stylesheet">
	<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>



  </head>
  
  <body>
  	<jsp:include page="./include/header.jsp" flush="true" />
  	<p>
  		<div align = "center">
  		<button type="button" class = "btn btn-default bth-lg"><a href = "login.jsp">login</a> </button>
  		<button type="button" class = "btn btn-default bth-lg"><a href = "reg.jsp">register</a> </button>
  		<button type="button" class = "btn btn-default bth-lg"><a href = "showboard.jsp">visiting as no login</a> </button>
  		</div>
  	</p>
  	
  	<jsp:include page="./include/footer.jsp" flush="true" />
  </body>
  
  <!--  <body >
  <jsp:include page="./include/header.jsp" flush="true" />
	<table>
		<FONT face=Verdana,Arial,Helvetica color=#003366 size=10>
		<tr> 
		<td width="50%" height="0" align="center" valign="center">
			<td width="50%" height="0" align="center" valign="center" ><a href="login.jsp" >
			<FONT face=Verdana,Arial,Helvetica color=#003366 size=2>login
			</FONT></a></td>
			
		</tr>
		<tr height="10%"></tr>
		<tr> 
		<td width="50%" height="0" align="center" valign="center">
			<td width="50%" height="0" align="center" valign="center"><a href="reg.jsp">
			<FONT face=Verdana,Arial,Helvetica color=#003366 size=2>register
			</FONT></a></td>
			
		</tr>
		<tr height="10%"></tr>
		<tr> 
		<td width="50%" height="0" align="centre" valign="center">
			<td width="50%" height="0" align="center" valign="center"><a href="showboard.jsp">
			<FONT face=Verdana,Arial,Helvetica color=#003366 size=2>visiting as no login
			</FONT></a></td>
			
		</tr>
	
		</FONT>
	</table>
	<jsp:include page="./include/footer.jsp" flush="true" />
	
		
	</body> -->
	
	
	</html>