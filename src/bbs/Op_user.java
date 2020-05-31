package bbs;

import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import bbs.*;

public class Op_user implements java.io.Serializable{
	
	String sqlStr = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	public String adduser(javax.servlet.http.HttpServletRequest request) throws 
		java.lang.Exception,java.sql.SQLException {
		
		if(request.getParameter("userName")==null){
			return "�������û���";
		}
		DataBase db = new DataBase();
		sqlStr = "select * from userinfo where userName = ? and password = ?";
		conn = db.getconn();
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1,request.getParameter("userName"));
		pstmt.setString(2,request.getParameter("password"));
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
			return "���û����Ѵ���";
		}
		sqlStr = "insert into userinfo (userName,password,sex,email,phone,regTime,regIP) values("+
		"?,?,?,?,?,DATE_ADD(now(),Interval 1 year),?)";

		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1,request.getParameter("userName"));
		pstmt.setString(2,request.getParameter("password"));
		pstmt.setString(3,request.getParameter("sex"));
		pstmt.setString(4,request.getParameter("email"));
		pstmt.setString(5,request.getParameter("phone"));
		pstmt.setString(6,request.getRemoteAddr());

		
		pstmt.executeUpdate();
		db.free();
		return "ok";

		
	}
	
	public int finduser(javax.servlet.http.HttpServletRequest request) throws 
		java.lang.Exception,java.sql.SQLException {		//�û���½
	
		String sqlStr = "";
		sqlStr = "select * from userinfo where userName= ? and password= ?";		
		DataBase db = new DataBase();
		conn = db.getconn();
		if(conn==null){
			System.out.println ("conn is null------------");
		}
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1,request.getParameter("userName"));
		pstmt.setString(2,request.getParameter("password"));
		ResultSet rs = pstmt.executeQuery();
		int userID =0;
		if(rs.next()){
			userID = rs.getInt("userID");
		    db.free();			
			return userID;
		}
		else{
		    db.free();	
			return 0;
		}

	}
	
	//���Ȩ��
	public int getproperty(javax.servlet.http.HttpServletRequest request) throws 
	java.lang.Exception,java.sql.SQLException {		//�û���½

		String sqlStr = "";
		sqlStr = "select property from userinfo where userName= ? and password= ?";		
		DataBase db = new DataBase();
		conn = db.getconn();
		if(conn==null){
			System.out.println ("conn is null------------");
		}
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1,request.getParameter("userName"));
		pstmt.setString(2,request.getParameter("password"));
		ResultSet rs = pstmt.executeQuery();
		int property =0;
		if(rs.next()){
			property = rs.getInt("property");
		    db.free();			
			return property;
		}
		else{
		    db.free();	
			return 0;
		}

	}
	
	//����û�ID
	public int getuserID(javax.servlet.http.HttpServletRequest request) throws 
	java.lang.Exception,java.sql.SQLException {		//�û���½
		
		int userID = 0;
		String sqlStr = "";
		sqlStr = "select userID from userinfo where userName= ? and password= ?";		
		DataBase db = new DataBase();
		conn = db.getconn();
		if(conn==null){
			System.out.println ("conn is null------------");
		}
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1,request.getParameter("userName"));
		pstmt.setString(2,request.getParameter("password"));
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			userID = rs.getInt("userID");
		    db.free();			
			return userID;
		}
		else{
		    db.free();	
			return 0;
		}

	}
	
	public boolean checkAdmin(javax.servlet.http.HttpServletRequest request,javax.servlet.http.HttpSession session)
		throws java.sql.SQLException,Exception {
			String sqlStr = "select userID from userInfo where property >5 and userID = ?";
			bbs.DataBase db = new bbs.DataBase();
			java.sql.Connection conn = db.getconn();
			java.sql.PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1,Integer.parseInt((String)session.getAttribute("userID")));
			java.sql.ResultSet rs = pstmt.executeQuery();
			if(!rs.next()){
				db.free();
				return false;

			}
			else{
				db.free();
				return true;
			}			
	}
	
	//��ʾ�����û�
	public java.util.ArrayList showuser(javax.servlet.http.HttpServletRequest request) throws SQLException{
		//throws Exception{
		//if(request.getParameter("userName")==null){
		//		return null;
		//}
		sqlStr = "select * from userinfo";
		System.out.println("***************modify*****************");
		java.util.ArrayList al = new java.util.ArrayList();
		DataBase db = new DataBase();
		conn = db.getconn();
		pstmt = conn.prepareStatement(sqlStr);
		//pstmt.setInt(1,Integer.parseInt(request.getParameter("userName")));
		java.sql.ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			UserBean ub = new UserBean();
			ub.fillAll(rs);
			al.add(ub);
		}
		db.free();
		return al;
	}
	
	//ɾ����¼
	public boolean deleteuser(javax.servlet.http.HttpServletRequest request)
		throws Exception{
		sqlStr = "delete from userinfo where userID = ?";
		DataBase db = new DataBase();	
		conn = db.getconn();
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,Integer.parseInt(request.getParameter("userID")));
		pstmt.executeUpdate();
		db.free();
	  	return true;
	}
	
	//Ȩ������
	public boolean alterauthority(javax.servlet.http.HttpServletRequest request)
		throws Exception{
		DataBase db = new DataBase();	
		conn = db.getconn();
		if(Integer.parseInt(request.getParameter("property"))==1){
			//ȡ��Ȩ��
			sqlStr = "update userinfo set property = 0 where userID = ?";
		}
		else{
			//����Ȩ��
			sqlStr = "update userinfo set property = 1 where userID = ?";
		}
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,Integer.parseInt(request.getParameter("userID")));
		pstmt.executeUpdate();
		db.free();
	  	return true;
	}
}
