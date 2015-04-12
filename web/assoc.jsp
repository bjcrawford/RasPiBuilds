<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   assoc.jsp
 Date:   Jan 28, 2015
 Desc:
-->
<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="model.build.BuildMods"%>
<%@page language="java" import="model.build.StringData"%>
<%@page language="java" import="view.BuildView" %>
<%
    // The build table
    String buildTableOrError = "";
    
    // Objects for the delete functionality
    StringData bDeleteStringData = new StringData();
    
    // Message for confirmation of state of the delete
    String deleteMsg = "";
    
    // Class name for error/success on delete form
    String submitDeleteClass = "";
    
    // Class name for hiding the elements on the delete form
    // after a successful deletion
    String submitDeleteElementsHidden = "";
    
    // Don't automatically show build delete popup on first load
    boolean shouldOpenDeletePopup = false;
    
    DbConn dbc = new DbConn();
    if (dbc.getErr().length() == 0) {
        
        if (request.getParameter("deleteBuildId") != null) { // Delete postback
            
            try {
                int buildId = Integer.decode(request.getParameter("deleteBuildId"));
                bDeleteStringData.setBuildId(String.valueOf(buildId));
                bDeleteStringData.setBuildName(request.getParameter("deleteBuildName"));

                // Instantiate WebUserMods object and pass validated StringData to its delete method
                BuildMods buildMods = new BuildMods(dbc);
                deleteMsg = buildMods.delete(buildId);
                
                if (deleteMsg.length() == 0) { // empty string means record was sucessfully deleted
                    deleteMsg = "Record " + bDeleteStringData.getBuildName() + " deleted. ";
                    submitDeleteClass = "has-success";
                    submitDeleteElementsHidden = "hidden";
                }
                else {
                    submitDeleteClass = "has-error";
                    if (deleteMsg.contains("Not sure under what conditions this would apply")) {
                        deleteMsg = "Test for any failing cases";
                    }
                }
            }
            catch (NumberFormatException e) {
                submitDeleteClass = "has-error";
                deleteMsg = "Internal error, invalid build id format. Error: " +
                        e.getMessage();
            }
            
            // If on postback, we want to open the popup automatically so the 
            // user can see the sucess/error messages associated with the delete
            shouldOpenDeletePopup = true;
        }
        
        
        String classes = "build-table table table-striped table-bordered table-responsive";
        buildTableOrError = BuildView.makeTableFromAllBuilds(classes, dbc);
    }
    else {
        buildTableOrError = dbc.getErr();
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
                        
                <!-- Hidden user delete popup -->    
                <div id="builddelete-popup" class="well raspi-popup">
                    <h3>Delete Build - ID: <span id="deletebuild-id"><%= bDeleteStringData.getBuildId()%></span></h3>
                    <span id="builddelete-popup-confirm" class="<%=submitDeleteElementsHidden%>">
                        <p>Are you sure you wish to delete this build?</p>
                        <span><b>Build name:</b></span>
                        <span id="deletebuild-name"><%=bDeleteStringData.getBuildName()%></span>
                        </br></br>
                    </span>
                    <form name="deletebuildform" action="assoc.jsp" method="post">
                        <input class="hidden" type="text" id="inputDeleteBuildId" name="deleteBuildId" value="<%=bDeleteStringData.getBuildId()%>">
                        <input class="hidden" type="text" id="inputDeleteBuildName" name="deleteBuildName" value="<%=bDeleteStringData.getBuildName()%>">
                        <span id="builddelete-submitgroup" class="form-group <%=submitDeleteClass%>">
                            <div class="center-text"><span id="builddelete-submitmsg" class="control-label"><%=deleteMsg%></span></div>
                            <input type="submit" id="builddelete-submitbutton" class="btn btn-default btn-danger <%=submitDeleteElementsHidden%>" disabled="disabled" value="Delete">
                            <button type="button" id="builddelete-cancelbutton" class="builddelete-popup_close btn btn-default btn-default <%=submitDeleteElementsHidden%>">Cancel</button>
                        </span>
                    </form>
                    <button type="button" class="builddelete-popup_close btn btn-default btn-sm close-btn">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    </button>
                </div>
                <script type="text/javascript">openBuildDeletePopup(<%=shouldOpenDeletePopup%>);</script>
<jsp:include page="post-content.jsp"></jsp:include>
            