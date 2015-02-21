<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   assoc.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.BuildView" %>
<%
    DbConn dbc = new DbConn();
    String buildTableOrError = dbc.getErr();
    if (buildTableOrError.length() == 0) {
        String classes = "build-table table table-striped table-bordered table-responsive";
        buildTableOrError = BuildView.makeTableFromAllBuilds(classes, dbc);
    }
    dbc.close();
%>

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
                        <%=buildTableOrError%>
                    </div>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
            