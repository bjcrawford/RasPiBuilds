<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   assoc.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.BuildView" %>

<jsp:include page="pre-content.jsp"></jsp:include>
            <div class="content">
                <div id="page" class="builds" display="none"></div>
                <div class="content-text">
                    <br/>
                    <p>
                        This table contains a list of all of the builds in the database.
                    </p>
                    <br/>
                    <div class="table-responsive">
                        <%
                            DbConn dbc = new DbConn();
                            String dbErrorOrData = dbc.getErr();
                            if (dbErrorOrData.length() == 0) {
                                String classes = "build-table table table-striped table-bordered table-responsive";
                                dbErrorOrData = BuildView.listAllBuilds(classes, dbc);
                                dbc.close();
                            }
                            out.print(dbErrorOrData);
                        %>
                    </div>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
            