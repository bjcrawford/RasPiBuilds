<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   membersOnly.jsp
 Date:   Mar 23, 2015
 Desc:
-->

<%@page import="model.web_user.StringData" %>   

<%
    String msg = "";

    StringData signInWebUser = (StringData) session.getAttribute("webUser");
    if (signInWebUser == null) {
        try {
            response.sendRedirect("deny.jsp?denyMsg="+
                    "You must be signed to view the Members Only page.");
        } 
        catch (Exception e) {
            msg += " Exception was thrown: " + e.getMessage();
        }
    }
%>

<jsp:include page="pre-content.jsp"></jsp:include> 
            <div class="content">
                <div id="page" class="members" display="none"></div>
                <div class="content-text">
                    <br/>
                    <h3>Members Only - Access Granted</h3>
                    <p>This page is only viewable by signed in members.</p>
                    <br/>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
            