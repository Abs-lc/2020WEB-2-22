<%@page import="bbs.*" %>
<%
bbs.OnlineUser ou = new bbs.OnlineUser();
int num = ou.getNum();

out.println("�����û��� : "+num);
java.util.ArrayList al = new java.util.ArrayList();
al = ou.getAl();
java.util.Iterator it = al.iterator();
while(it.hasNext()){
	out.println("�û��� : "+(String)it.next());
}


%>