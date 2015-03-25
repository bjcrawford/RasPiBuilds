<%-- 
    Document   : encryptPws
    Created on : Mar 25, 2015, 9:59:57 AM
    Author     : Brett Crawford <brett.crawford@temple.edu>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page language="java" import="java.sql.PreparedStatement" %>
<%@page language="java" import="java.sql.ResultSet" %>

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.web_user.EncryptDbPw" %>

<%
    DbConn dbc = new DbConn();
    String textOrErrorMsg = EncryptDbPw.EncryptPws(dbc);
    dbc.close();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Encryption</title>
    </head>
    <body>
        <h1>Encrypted Passwords</h1>
        <p><%=textOrErrorMsg%></p>
    </body>
</html>
