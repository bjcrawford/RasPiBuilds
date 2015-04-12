<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.web_user.StringData" %>
<%@page language="java" import="model.web_user.WebUserMods" %>

<%
            String userId = request.getParameter("userId");
            StringData wuStringData = new StringData();
            
            DbConn dbc = new DbConn();
            
            if (dbc.getErr().length() != 0) {
                wuStringData.setRecordStatus("Database connection error in " +
                        "getUserJSON.jsp: " + dbc.getErr()); 
            } 
            else {
                wuStringData = WebUserMods.find(dbc, userId);
                if (wuStringData.getErrorMsg().length() != 0) {
                    wuStringData.setRecordStatus("getUserJSON.jsp. Problem finding " +
                            "record with id " + userId + ": " + wuStringData.getErrorMsg());
                } 
                else {
                    wuStringData.setRecordStatus ("User found in database.");
                }
            }
            out.print(wuStringData.toJSON());
            dbc.close();
%>
