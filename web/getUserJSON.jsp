<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.web_user.StringData" %>
<%@page language="java" import="model.web_user.WebUserMods" %>

<%
            String userId = request.getParameter("userId");
            StringData userStringData = new StringData();
            
            DbConn dbc = new DbConn();
            String dbError = dbc.getErr();
            
            if (dbError.length() != 0) {
                userStringData.setRecordStatus("Database connection error in " +
                        "getUserJSON.jsp: " + dbError); 
            } 
            else {
                userStringData = WebUserMods.find(dbc, userId);
                if (userStringData.errorMsg.length() != 0) {
                    userStringData.setRecordStatus("getUserJSON.jsp. Problem finding " +
                            "record with id " + userId + ": " + userStringData.errorMsg);
                } 
                else {
                    userStringData.setRecordStatus ("User found in database.");
                }
            }
            out.print(userStringData.toJSON());
            dbc.close();
%>
