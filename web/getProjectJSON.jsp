<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.project.StringData" %>
<%@page language="java" import="model.project.ProjectMods" %>

<%
            String projectId = request.getParameter("projectId");
            StringData projectStringData = new StringData();
            
            DbConn dbc = new DbConn();
            String dbError = dbc.getErr();
            
            if (dbError.length() != 0) {
                projectStringData.setRecordStatus("Database connection error in " +
                        "getUserJSON.jsp: " + dbError); 
            } 
            else {
                projectStringData = ProjectMods.find(dbc, projectId);
                if (projectStringData.errorMsg.length() != 0) {
                    projectStringData.setRecordStatus("getUserJSON.jsp. Problem finding " +
                            "record with id " + projectId + ": " + projectStringData.errorMsg);
                } 
                else {
                    projectStringData.setRecordStatus ("Project found in database.");
                }
            }
            out.print(projectStringData.toJSON());
            dbc.close();
%>
