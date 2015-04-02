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
    StringData pStringData = new StringData();
    Validate pValidate = new Validate();
    
    // Message for confirmation of state of the update
    String msg = "";
    
    // Class names for success/error
    String projectNameErrorClass = "";
    String projectDescErrorClass = "";
    String projectGuideErrorClass = "";
    String projectImgUrlErrorClass = "";
    String projectCostErrorClass = "";
    String submitSuccessClass = "";
    
    // Don't automatically show user update popup on first load
    boolean shouldOpenPopup = false;
    
    DbConn dbc = new DbConn();
    if (dbc.getErr().length() == 0) {
        
        if (request.getParameter("projectName") != null) {

            // Populate StringData object with posted params
            pStringData.projectId = request.getParameter("projectId");
            pStringData.projectName = request.getParameter("projectName");
            pStringData.projectDesc = request.getParameter("projectDesc");
            pStringData.projectGuide = request.getParameter("projectGuide");
            pStringData.projectImgUrl = request.getParameter("projectImgUrl");
            pStringData.projectCost = request.getParameter("projectCost");

            pValidate = new Validate(pStringData); 
            if (pValidate.isValidated()) {

                // Instantiate Project Mod object and pass validated String Data to its update method
                ProjectMods projectMods = new ProjectMods(dbc);
                msg = projectMods.update(pValidate);

                if (msg.length() == 0) {
                    msg = "Record " + pStringData.projectName + " updated.";
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
            if (msg.equals("Record " + pStringData.projectName + " updated.")) {
                submitSuccessClass = "has-success";
            }
            else if (!msg.equals("")){
                submitSuccessClass = "has-error";
                if (msg.equals("Cannot insert: a record with that project name already exists.")) {
                    msg = "";
                    projectNameErrorClass = "has-error";
                    pValidate.setProjectNameMsg("Project name already exists. Please choose another.");
                }
            }
            
            // If on postback, we want to open the popup automatically so the 
            // user can see the persisted data or error messages associated
            // with the update
            shouldOpenPopup = true;
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
                    <h3>Update Project - ID: <span id="updateproject-id"><%= pStringData.projectId%></span></h3>        
                    <form name="updateprojectform" method="post" action="other.jsp">
                        <input class="hidden" type="text" id="inputProjectId" name="projectId" value="<%=pStringData.projectId%>">
                        <table>
                            <tr>
                                <td>
                                    <div id="projectupdate-namegroup" class="form-group <%=projectNameErrorClass%>">
                                        <label class="control-label" for="projectName">Project Name:</label>
                                        <input class="form-control" type="text" id="inputProjectName" name="projectName" placeholder="Enter project name" value="<%=pStringData.projectName%>"/>
                                        <span id="projectupdate-namemsg" class="control-label"><%=pValidate.getProjectNameMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="projectupdate-imgurlgroup" class="form-group <%=projectImgUrlErrorClass%>">
                                        <label class="control-label" for="projectImgUrl">Project Image URL (optional):</label>
                                        <input class="form-control" type="text" id="inputProjectImgUrl" name="projectImgUrl" placeholder="Enter project image URL" value="<%=pStringData.projectImgUrl%>"/>
                                        <span id="projectupdate-imgurlmsg" class="control-label"><%=pValidate.getProjectImgUrlMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="projectupdate-descgroup" class="form-group <%=projectDescErrorClass%>">
                                        <label class="control-label" for="projectDesc">Project Description:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <input class="form-control" type="text" id="inputProjectDesc" name="projectDesc" placeholder="Enter project description" value="<%=pStringData.projectDesc%>"/>
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
                                            <input class="form-control" type="text" id="inputProjectCost" name="projectCost" placeholder="Enter project cost" value="<%=pStringData.projectCost%>"/>
                                            <div class="input-group-addon">.00</div>
                                        </div>
                                        <span id="projectupdate-costmsg" class="control-label"><%=pValidate.getProjectCostMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div id="projectupdate-guidegroup" class="form-group <%=projectGuideErrorClass%>">
                            <label class="control-label" for="projectGuide">Project Guidelines:</label>
                            <input class="form-control" type="textarea" rows="5" id="inputProjectGuide" name="projectGuide" value="<%=pStringData.projectGuide%>"/>
                            <span id="projectupdate-guidemsg" class="control-label"><%=pValidate.getProjectGuideMsg()%></span>
                        </div>
                        <div id="projectupdate-submitgroup" class="form-group <%=submitSuccessClass%>">
                            <input type="submit" class="btn btn-default" value="Submit">
                            <span id="projectupdate-submitmsg" class="control-label"><%=msg%></span>
                        </div>
                        <button type="button" class="projectupdate-popup_close btn btn-default btn-sm close-btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
                <script type="text/javascript">openProjectUpdatePopup(<%=shouldOpenPopup%>);</script>   
<jsp:include page="post-content.jsp"></jsp:include>
            