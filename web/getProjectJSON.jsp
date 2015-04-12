<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.project.StringData" %>
<%@page language="java" import="model.project.ProjectMods" %>

<%
            String projectId = request.getParameter("projectId");
            StringData pStringData = new StringData();
            
            DbConn dbc = new DbConn();
            
            if (dbc.getErr().length() != 0) {
                pStringData.setRecordStatus("Database connection error in " +
                        "getProjectJSON.jsp: " + dbc.getErr()); 
            } 
            else {
                pStringData = ProjectMods.find(dbc, projectId);
                if (pStringData.errorMsg.length() != 0) {
                    pStringData.setRecordStatus("getProjectJSON.jsp. Problem finding " +
                            "record with id " + projectId + ": " + pStringData.errorMsg);
                } 
                else {
                    pStringData.setRecordStatus ("Project found in database.");
                }
            }
            out.print(pStringData.toJSON());
            dbc.close();
%>
