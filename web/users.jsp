<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   users.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.WebUserView" %>

<jsp:include page="pre-content.jsp"></jsp:include> 
            <div class="content">
                <div id="page" class="users" display="none"></div>
                <div class="content-text">
                    <br/>
                    <p>
                        This table contains a list of all of the users in the database.
                    </p>
                    <br/>
                    <div class="table-responsive">
                        <%
                            DbConn dbc = new DbConn();
                            String dbErrorOrData = dbc.getErr();
                            if (dbErrorOrData.length() == 0) { 
                                String classes = "user-table table table-striped table-bordered";
                                dbErrorOrData = WebUserView.listAllUsers(classes, dbc);
                                dbc.close();
                            }
                            out.print(dbErrorOrData);
                        %>
                    </div>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
            