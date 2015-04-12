<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.build.StringData" %>
<%@page language="java" import="model.build.BuildMods" %>

<%
            String buildId = request.getParameter("buildId");
            StringData bStringData = new StringData();
            
            DbConn dbc = new DbConn();
            
            if (dbc.getErr().length() != 0) {
                bStringData.setRecordStatus("Database connection error in " +
                        "getBuildJSON.jsp: " + dbc.getErr()); 
            } 
            else {
                bStringData = BuildMods.find(dbc, buildId);
                if (bStringData.getErrorMsg().length() != 0) {
                    bStringData.setRecordStatus("getBuildJSON.jsp. Problem finding " +
                            "record with id " + buildId + ": " + bStringData.getErrorMsg());
                } 
                else {
                    bStringData.setRecordStatus ("Build found in database.");
                }
            }
            out.print(bStringData.toJSON());
            dbc.close();
%>
