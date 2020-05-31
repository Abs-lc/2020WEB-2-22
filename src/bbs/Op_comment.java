package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;

import bbs.*;

public class Op_comment  implements java.io.Serializable{

	String sqlStr="";
	Connection conn = null;
	PreparedStatement pstmt = null;

	//��������
	public String addcomment(javax.servlet.http.HttpServletRequest request,javax.servlet.http.HttpSession session)
		throws Exception {

		/*
		if(request.getParameter("PID")==null){
			return "ȱ������������Ϣ";	
		}
		if(request.getParameter("boardID")==null){
			return "ȱ�����������Ϣ";
		}
		*/
		if(session.getAttribute("userID")==null){
			return "�û�IDΪ��,���½";
		}
		
		if(session.getAttribute("userName")==null){
			return "�û���Ϊ��,���½";
		}
		DataBase db = new DataBase();
		conn = db.getconn();
		
		/*
		if(Integer.parseInt(request.getParameter("PID"))!=0){
			sqlStr = "select replies from foruminfo where msgID = ?";
			pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1,Integer.parseInt(request.getParameter("PID")));
			java.sql.ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				int replies = rs.getInt("replies");
				rs.close();
				sqlStr = "update foruminfo set replies = ? where msgID = ?";
				pstmt = conn.prepareStatement(sqlStr);
				pstmt.setInt(1,replies+1);
				pstmt.setInt(2,Integer.parseInt(request.getParameter("PID")));
				pstmt.executeUpdate();
			}
			
		}
		*/
		
		sqlStr = "insert into commentinfo (title,content,userName,userID,time) values("
		+"?,?,?,?,now())";
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1,request.getParameter("title"));
		pstmt.setString(2,request.getParameter("content"));
		pstmt.setString(3,(String)session.getAttribute("userName"));
		pstmt.setInt(4,Integer.parseInt((String)session.getAttribute("userID")));
	
    	pstmt.executeUpdate();
    	db.free();
    	return "ok";

	}
	
	//�г���������
	public java.util.ArrayList showcomment(javax.servlet.http.HttpServletRequest request)
		throws Exception{
		//if(request.getParameter("boardID")==null){
		//		return null;
		//}
		sqlStr = "select * from commentinfo";
		java.util.ArrayList al = new java.util.ArrayList();
		DataBase db = new DataBase();
		conn = db.getconn();
		pstmt = conn.prepareStatement(sqlStr);
		//pstmt.setInt(1,Integer.parseInt(request.getParameter("boardID")));
		java.sql.ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			CommentBean cb = new CommentBean();
			cb.fillAll(rs);
			al.add(cb);
		}
		db.free();
		return al;
	}
	
	//�г����������е�����
	public java.util.ArrayList showAticle(javax.servlet.http.HttpServletRequest request)
		throws Exception {
		if(request.getParameter("msgID")==null){
			return null;
		}
		

		sqlStr = "select clicks from foruminfo where msgID=?";
		java.util.ArrayList al = new java.util.ArrayList();		
		DataBase db = new DataBase();
		conn = db.getconn();
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,Integer.parseInt(request.getParameter("msgID")));
		java.sql.ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			int clicks = rs.getInt("clicks");
			sqlStr = "update foruminfo set clicks= ? where msgID= ? ";
			pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1,clicks+1);
			pstmt.setInt(2,Integer.parseInt(request.getParameter("msgID")));
			
			pstmt.executeUpdate();
		}
		sqlStr = "select * from foruminfo where msgID= ? or PID = ?";
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,Integer.parseInt(request.getParameter("msgID")));
		pstmt.setInt(2,Integer.parseInt(request.getParameter("msgID")));
		
		rs = pstmt.executeQuery();
		while(rs.next()){
			ForumBean fb = new ForumBean();
			fb.fillAll(rs);
			al.add(fb);
		}
				
		db.free();
		return al;
	}
	
	//�ö���ȡ���ö�
	public boolean altertop(javax.servlet.http.HttpServletRequest request)
		throws Exception{
		DataBase db = new DataBase();	
		conn = db.getconn();
		if(Integer.parseInt(request.getParameter("flag"))==1){
			//ȡ���ö�
			sqlStr = "update foruminfo set flag = 0 where msgID = ?";
		}
		else{
			//�ö�
			sqlStr = "update foruminfo set flag = 1 where msgID = ?";
		}
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,Integer.parseInt(request.getParameter("msgID")));
		pstmt.executeUpdate();
		db.free();
	  	return true;
	}
	
	//ɾ����¼
	public boolean deletecomment(javax.servlet.http.HttpServletRequest request)
		throws Exception{
		sqlStr = "delete from commentinfo where commentID = ?";
		DataBase db = new DataBase();	
		conn = db.getconn();
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,Integer.parseInt(request.getParameter("commentID")));
		pstmt.executeUpdate();
		db.free();
	  	return true;
	}
		
}
