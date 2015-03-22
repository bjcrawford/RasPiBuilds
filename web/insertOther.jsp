<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   insertOther.jsp
 Date:   Mar 11, 2015
 Desc:
-->

<%@page language="java" import="model.project.ProjectMods"%>
<%@page language="java" import="model.project.StringData"%>
<%@page language="java" import="model.project.Validate"%>
<%@page language="java" import="sql.DbConn" %>
<%
    // Constructor sets all fields of Project.StringData to "" (empty string) - good for 1st rendering
    StringData pStringData = new StringData();

    // Default constructor sets all error messages to "" - good for 1st rendering
    Validate pValidate = new Validate();

    // Message for confirmation of state of the insertion
    String msg = "";
    
    // Class names for success/error
    String projectNameErrorClass = "";
    String projectDescErrorClass = "";
    String projectGuideErrorClass = "";
    String projectImgUrlErrorClass = "";
    String projectCostErrorClass = "";
    String submitSuccessClass = "";

    if (request.getParameter("projectName") != null) {

        // Fill ProjectData object with form data (form data is always String)
        pStringData.projectName = request.getParameter("projectName");
        pStringData.projectDesc = request.getParameter("projectDesc");
        pStringData.projectGuide = request.getParameter("projectGuide");
        pStringData.projectImgUrl = request.getParameter("projectImgUrl");
        pStringData.projectCost = request.getParameter("projectCost");
        
        // Validate user input, set error messages.
        pValidate = new Validate(pStringData); 
        
        if (pValidate.isValidated()) { // data is good, proceed to try to insert
            
            DbConn dbc = new DbConn();
            msg = dbc.getErr();

            if (msg.length() == 0) { // means no error getting db connection

                // Instantiate Project Mod object and pass validated String Data to its insert method
                ProjectMods projectMods = new ProjectMods(dbc);
                msg = projectMods.insert(pValidate);

                if (msg.length() == 0) { // empty string means record was sucessfully inserted
                    msg = "Record inserted.";
                }
            }
            
            dbc.close(); // NEVER have db connection leaks !!!
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
        
        // Check for successful insert, on success display green text, on error display red text
        if (msg.equals("Record inserted.")) {
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
    }
%>

<!-- My web app uses the Bootstrap framework to handle validation states of the
     form elements. The label, input boxes, and error messages will all be 
     displayed in red if a validation error has occured -->

<jsp:include page="pre-content.jsp"></jsp:include>
            <div class="content">
                <div id="page" class="projects" display="none"></div>
                <div class="content-text">
                    <h1>Submit a Project</h1>
                    <form name="insertOther" method="post" action="insertOther.jsp"  onsubmit="return pgTinyEditor.post();">
                        <div class="form-group <%=projectNameErrorClass%>">
                            <label class="control-label" for="projectName">Project Name:</label>
                            <input class="form-control" type="text" id="inputProjectName" name="projectName" placeholder="Enter project name" value="<%= pStringData.projectName%>"/>
                            <span class="control-label"><%=pValidate.getProjectNameMsg()%></span>
                        </div>
                        <div class="form-group <%=projectDescErrorClass%>">
                            <label class="control-label" for="projectDesc">Project Description:</label>
                            <input class="form-control" type="text" id="inputProjectDesc" name="projectDesc" placeholder="Enter project description" value="<%= pStringData.projectDesc%>"/>
                            <span class="control-label"><%=pValidate.getProjectDescMsg()%></span>
                        </div>
                        <div class="form-group <%=projectGuideErrorClass%>">
                            <label class="control-label" for="projectGuide">Project Guidelines:</label>
                            <input class="form-control" type="textarea" id="inputProjectGuide" name="projectGuide"/>
                            
                            <script src="js/project_guide_tinyeditor.js" type="text/javascript"></script>
                            <script>pgTinyEditor.setEditorContent('<%=pStringData.projectGuide%>');</script>
                            
                            
                            <span class="control-label"><%=pValidate.getProjectGuideMsg()%></span>
                        </div>
                        <div class="form-group <%=projectImgUrlErrorClass%>">
                            <label class="control-label" for="projectImgUrl">Project Image URL (optional):</label>
                            <input class="form-control" type="text" id="inputProjectImgUrl" name="projectImgUrl" placeholder="Enter project image URL" value="<%= pStringData.projectImgUrl%>"/>
                            <span class="control-label"><%=pValidate.getProjectImgUrlMsg()%></span>
                        </div>
                        <div class="form-group <%=projectCostErrorClass%>">
                            <label class="control-label" for="projectCost">Project Cost (optional):</label>
                            <div class="input-group">
                                <div class="input-group-addon">$</div>
                                <input class="form-control" type="text" id="inputProjectCost" name="projectCost" placeholder="Enter project cost" value="<%= pStringData.projectCost%>"/>
                                <div class="input-group-addon">.00</div>
                            </div>
                            <span class="control-label"><%=pValidate.getProjectCostMsg()%></span>
                        </div>
                        <div class="form-group <%=submitSuccessClass%>">
                            <input type="submit" class="btn btn-default" value="Submit">
                            <span class="control-label"><%=msg%></span>
                        </div>
                    </form>
                    <a href="other.jsp"><h3>List Projects</h3></a>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
