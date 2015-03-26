<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   deny.jsp
 Date:   Mar 23, 2015
 Desc:
-->

<%
    String msg = "";
    if (request.getParameter("denyMsg") != null) {
        msg = request.getParameter("denyMsg");
    }
%>
<jsp:include page="pre-content.jsp"></jsp:include> 
            <div class="content">
                <div id="page" class="members" display="none"></div>
                <div class="content-text">
                    <br/>
                    <h3>Access Denied</h3>
                    <p>Error: <%=msg%></p>
                    <br/>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
