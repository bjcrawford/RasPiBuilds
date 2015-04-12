<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   other.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="view.ProjectView" %>
<%@page language="java" import="model.project.ProjectMods"%>
<%@page language="java" import="model.project.StringData"%>
<%@page language="java" import="model.project.Validate"%>
<%
    // The project table
    String projectTableOrError = "";
    
    // Objects for the update functionality
    StringData pUpdateStringData = new StringData();
    Validate pValidate = new Validate();
    
    // Objects for the delete functionality
    StringData pDeleteStringData = new StringData();
    
    // Message for confirmation of state of the update
    String updateMsg = "";
    
    // Message for confirmation of state of the delete
    String deleteMsg = "";
    
    // Class names for errors on update form
    String projectNameErrorClass = "";
    String projectDescErrorClass = "";
    String projectGuideErrorClass = "";
    String projectImgUrlErrorClass = "";
    String projectCostErrorClass = "";
    
    // Class name for error/success on update form
    String submitClass = "";
    
    // Class name for error/success on delete form
    String submitDeleteClass = "";
    
    // Class name for hiding the elements on the delete form
    // after a successful deletion
    String submitDeleteElementsHidden = "";
    
    // Don't automatically show user update popup on first load
    boolean shouldOpenPopup = false;
    
    // Don't automatically show user delete popup on first load
    boolean shouldOpenDeletePopup = false;
    
    DbConn dbc = new DbConn();
    if (dbc.getErr().length() == 0) {
        
        if (request.getParameter("projectName") != null) {

            // Populate StringData object with posted params
            pUpdateStringData.projectId = request.getParameter("projectId");
            pUpdateStringData.projectName = request.getParameter("projectName");
            pUpdateStringData.projectDesc = request.getParameter("projectDesc");
            pUpdateStringData.projectGuide = request.getParameter("projectGuide");
            pUpdateStringData.projectImgUrl = request.getParameter("projectImgUrl");
            pUpdateStringData.projectCost = request.getParameter("projectCost");

            pValidate = new Validate(pUpdateStringData); 
            if (pValidate.isValidated()) {

                // Instantiate Project Mod object and pass validated String Data to its update method
                ProjectMods projectMods = new ProjectMods(dbc);
                updateMsg = projectMods.update(pValidate);

                if (updateMsg.length() == 0) {
                    updateMsg = "Record " + pUpdateStringData.projectName + " updated.";
                }
            }

            // Check for error messages and set class error names accordingly
            // My pages use the Bootstrap framework for error reporting
            if (!pValidate.getProjectNameMsg().equals("")) {
                projectNameErrorClass = "has-error";
            }
            if (!pValidate.getProjectDescMsg().equals("")) {
                projectDescErrorClass = "has-error";
            }
            if (!pValidate.getProjectGuideMsg().equals("")) {
                projectGuideErrorClass = "has-error";
            }
            if (!pValidate.getProjectImgUrlMsg().equals("")) {
                projectImgUrlErrorClass = "has-error";
            }
            if (!pValidate.getProjectCostMsg().equals("")) {
                projectCostErrorClass = "has-error";
            }

            // Check for successful update, on success display green text, on error display red text
            if (updateMsg.equals("Record " + pUpdateStringData.projectName + " updated.")) {
                submitClass = "has-success";
            }
            else if (!updateMsg.equals("")){
                submitClass = "has-error";
                if (updateMsg.equals("Cannot insert: a record with that project name already exists.")) {
                    updateMsg = "";
                    projectNameErrorClass = "has-error";
                    pValidate.setProjectNameMsg("Project name already exists. Please choose another.");
                }
            }
            
            // If on postback, we want to open the popup automatically so the 
            // user can see the persisted data or error messages associated
            // with the update
            shouldOpenPopup = true;
        }
        else if (request.getParameter("deleteProjectId") != null) { // Delete postback
            
            try {
                int projectId = Integer.decode(request.getParameter("deleteProjectId"));
                pDeleteStringData.projectId = String.valueOf(projectId);
                pDeleteStringData.projectName = request.getParameter("deleteProjectName");

                // Instantiate WebUserMods object and pass validated StringData to its delete method
                ProjectMods projectMods = new ProjectMods(dbc);
                deleteMsg = projectMods.delete(projectId);
                
                if (deleteMsg.length() == 0) { // empty string means record was sucessfully deleted
                    deleteMsg = "Record " + pDeleteStringData.projectName + " deleted. ";
                    submitDeleteClass = "has-success";
                    submitDeleteElementsHidden = "hidden";
                }
                else {
                    submitDeleteClass = "has-error";
                    if (deleteMsg.equals("Something related to a foreign key")) {
                        deleteMsg = "Display a more appropriate message";
                    }
                }
            }
            catch (NumberFormatException e) {
                submitDeleteClass = "has-error";
                deleteMsg = "Internal error, invalid project id format. Error: " +
                        e.getMessage();
            }
            
            // If on postback, we want to open the popup automatically so the 
            // user can see the sucess/error messages associated with the delete
            shouldOpenDeletePopup = true;
        }
        
        // Create the table of projects
        String classes = "project-table table table-striped table-bordered";
        projectTableOrError = ProjectView.makeTableFromAllProjects(classes, dbc);
    }
    else {
        projectTableOrError = dbc.getErr();
    }
    
    dbc.close();
%>

<jsp:include page="pre-content.jsp"></jsp:include> 
            <div class="content">
                <div id="page" class="projects" display="none"></div>
                <div class="content-text">
                    <br/>
                    <h3><a href="insertOther.jsp">Submit a project</a></h3>
                    <p>This table contains a list of all of the projects in the database.</p>
                    <br/>
                    <div class="table-responsive">
                        <%=projectTableOrError%>
                    </div>
                </div>
                <!-- Hidden user update popup -->    
                <div id="projectupdate-popup" class="well raspi-popup">
                    <h3>Update Project - ID: <span id="updateproject-id"><%= pUpdateStringData.projectId%></span></h3>        
                    <form name="updateprojectform" method="post" action="other.jsp">
                        <input class="hidden" type="text" id="inputProjectId" name="projectId" value="<%=pUpdateStringData.projectId%>">
                        <table>
                            <tr>
                                <td>
                                    <div id="projectupdate-namegroup" class="form-group <%=projectNameErrorClass%>">
                                        <label class="control-label" for="projectName">Project Name:</label>
                                        <input class="form-control" type="text" id="inputProjectName" name="projectName" placeholder="Enter project name" value="<%=pUpdateStringData.projectName%>"/>
                                        <span id="projectupdate-namemsg" class="control-label"><%=pValidate.getProjectNameMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="projectupdate-imgurlgroup" class="form-group <%=projectImgUrlErrorClass%>">
                                        <label class="control-label" for="projectImgUrl">Project Image URL (optional):</label>
                                        <input class="form-control" type="text" id="inputProjectImgUrl" name="projectImgUrl" placeholder="Enter project image URL" value="<%=pUpdateStringData.projectImgUrl%>"/>
                                        <span id="projectupdate-imgurlmsg" class="control-label"><%=pValidate.getProjectImgUrlMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="projectupdate-descgroup" class="form-group <%=projectDescErrorClass%>">
                                        <label class="control-label" for="projectDesc">Project Description:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <input class="form-control" type="text" id="inputProjectDesc" name="projectDesc" placeholder="Enter project description" value="<%=pUpdateStringData.projectDesc%>"/>
                                        <span id="projectupdate-descmsg" class="control-label"><%=pValidate.getProjectDescMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="projectupdate-costgroup" class="form-group <%=projectCostErrorClass%>">
                                        <label class="control-label" for="projectCost">Project Cost (optional):</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">$</div>
                                            <input class="form-control" type="text" id="inputProjectCost" name="projectCost" placeholder="Enter project cost" value="<%=pUpdateStringData.projectCost%>"/>
                                            <div class="input-group-addon">.00</div>
                                        </div>
                                        <span id="projectupdate-costmsg" class="control-label"><%=pValidate.getProjectCostMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div id="projectupdate-guidegroup" class="form-group <%=projectGuideErrorClass%>">
                            <label class="control-label" for="projectGuide">Project Guidelines:</label>
                            <input class="form-control" type="textarea" rows="5" id="inputProjectGuide" name="projectGuide" value="<%=pUpdateStringData.projectGuide%>"/>
                            <span id="projectupdate-guidemsg" class="control-label"><%=pValidate.getProjectGuideMsg()%></span>
                        </div>
                        <div id="projectupdate-submitgroup" class="form-group <%=submitClass%>">
                            <input type="submit" class="btn btn-default" value="Submit">
                            <span id="projectupdate-submitmsg" class="control-label"><%=updateMsg%></span>
                        </div>
                        <button type="button" class="projectupdate-popup_close btn btn-default btn-sm close-btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
                <script type="text/javascript">openProjectUpdatePopup(<%=shouldOpenPopup%>);</script>   
                
                <!-- Hidden user delete popup -->    
                <div id="projectdelete-popup" class="well raspi-popup">
                    <h3>Delete Project - ID: <span id="deleteproject-id"><%= pDeleteStringData.projectId%></span></h3>
                    <span id="projectdelete-popup-confirm" class="<%=submitDeleteElementsHidden%>">
                        <p>Are you sure you wish to delete this project?</p>
                        <span><b>Project name:</b></span>
                        <span id="deleteproject-name"><%=pDeleteStringData.projectName%></span>
                        </br></br>
                    </span>
                    <form name="deleteprojectform" action="other.jsp" method="post">
                        <input class="hidden" type="text" id="inputDeleteProjectId" name="deleteProjectId" value="<%=pDeleteStringData.projectId%>">
                        <input class="hidden" type="text" id="inputDeleteProjectName" name="deleteProjectName" value="<%=pDeleteStringData.projectName%>">
                        <span id="projectdelete-submitgroup" class="form-group <%=submitDeleteClass%>">
                            <div class="center-text"><span id="projectdelete-submitmsg" class="control-label"><%=deleteMsg%></span></div>
                            <input type="submit" id="projectdelete-submitbutton" class="btn btn-default btn-danger <%=submitDeleteElementsHidden%>" disabled="disabled" value="Delete">
                            <button type="button" id="projectdelete-cancelbutton" class="projectdelete-popup_close btn btn-default btn-default <%=submitDeleteElementsHidden%>">Cancel</button>
                        </span>
                    </form>
                    <button type="button" class="projectdelete-popup_close btn btn-default btn-sm close-btn">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    </button>
                </div>
                <script type="text/javascript">openProjectDeletePopup(<%=shouldOpenDeletePopup%>);</script>
<jsp:include page="post-content.jsp"></jsp:include>
            