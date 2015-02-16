<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   users.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.WebUserView" %>

<jsp:include page="html-to-head.jsp"></jsp:include>
        <title>Users | RasPi Builds</title>
<jsp:include page="head-to-body.jsp"></jsp:include>  
            <div class="content">
                <div class="content-text">
                    </br>
                    <p>
                        This table contains a list of all of the users in the database.
                    </p>
                    </br>
                    <p>
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
                    </p>
                </div>
<jsp:include page="body-to-html.jsp"></jsp:include>
            