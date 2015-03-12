<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   insertOther.jsp
 Date:   Mar 11, 2015
 Desc:
-->

<%@page language="java" import="model.other.*" %>
<%@page language="java" import="utils.*" %>
<%@page language="java" import="sql.*" %>
<%
    // Constructor sets all fields of Project.StringData to "" (empty string) - good for 1st rendering
    StringData pStringData = new StringData();

    // Default constructor sets all error messages to "" - good for 1st rendering
    Validate pValidate = new Validate();

    String msg = "";
    
    // Class names for errors
    String projectNameErrorClass = "";
    String projectDescErrorClass = "";
    String projectGuideErrorClass = "";
    String projectImgUrlErrorClass = "";
    String projectCostErrorClass = "";
    String submitSuccessClass = "";

    if (request.getParameter("projectName") != null) { // postback 

        // fill WebUserData object with form data (form data is always String)
        pStringData.projectName = request.getParameter("projectName");
        pStringData.projectDesc = request.getParameter("projectDesc");
        pStringData.projectGuide = request.getParameter("projectGuide");
        pStringData.projectImgUrl = request.getParameter("projectImgUrl");
        pStringData.projectCost = request.getParameter("projectCost");
        
        pValidate = new Validate(pStringData); // validate user input, set error messages.
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
        if (msg.equals("Record inserted.")) {
            submitSuccessClass = "has-success";
        }
        else if (!msg.equals("")){
            submitSuccessClass = "has-error";
        }
    }
%>

<jsp:include page="pre-content.jsp"></jsp:include>
            <div class="content">
                <div id="page" class="projects" display="none"></div>
                <div class="content-text">
                    <h1>Submit a Project</h1>
                    <form name="insertOther" method="post" action="insertOther.jsp">
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
                            <input class="form-control" type="text" id="inputProjectGuide" name="projectGuide" placeholder="Enter project guidelines" value="<%= pStringData.projectGuide%>"/>
                            <span class="control-label"><%=pValidate.getProjectGuideMsg()%></span>
                        </div>
                        <div class="form-group <%=projectImgUrlErrorClass%>">
                            <label class="control-label" for="projectImgUrl">Project Image URL (optional):</label>
                            <input class="form-control" type="text" id="inputProjectImgUrl" name="projectImgUrl" placeholder="Enter project image URL" value="<%= pStringData.projectImgUrl%>"/>
                            <span class="control-label"><%=pValidate.getProjectImgUrlMsg()%></span>
                        </div>
                        <div class="form-group <%=projectCostErrorClass%>">
                            <label class="control-label" for="projectCost">Project Cost (optional):</label>
                            <input class="form-control" type="text" id="inputProjectCost" name="projectCost" placeholder="Enter project cost" value="<%= pStringData.projectCost%>"/>
                            <span class="control-label"><%=pValidate.getProjectCostMsg()%></span>
                        </div>
                        <div class="form-group <%=submitSuccessClass%>">
                            <input type="submit" class="btn btn-default" value="Submit">
                            <span class="control-label"><%=msg%></span>
                        </div>
                    </form>
                    <a href="other.jsp"><h3>List Projects</h3></a>
                    <p><%=pValidate.getAllValidationErrors()%></p>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
