<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   insertUser.jsp
 Date:   Mar 10, 2015
 Desc:
-->

<%@page language="java" import="model.web_user.StringData" %>
<%@page language="java" import="model.web_user.Validate" %>
<%@page language="java" import="model.web_user.WebUserMods" %>
<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="view.WebUserView" %>
<%
    // Constructor sets all fields of WebUser.StringData to "" (empty string) - good for 1st rendering
    StringData wuStringData = new StringData();

    // Default constructor sets all error messages to "" - good for 1st rendering
    Validate wuValidate = new Validate();

    // Message for confirmation of state of the insertion
    String msg = "";
    
    // The default user role to display in the dropdown
    int roleId = 3;
    
    // The HTML code for the user role dropdown
    String userRoleSelectOrError = "";
    
    // Class names for errors
    String userEmailErrorClass = "";
    String userPwErrorClass = "";
    String userPw2ErrorClass = "";
    String userNameErrorClass = "";
    String birthdayErrorClass = "";
    String membershipFeeErrorClass = "";
    String userRoleIdErrorClass = "";
    String submitSuccessClass = "";

    // The DB connection is obtained before validation in order to get the user role dropdown
    DbConn dbc = new DbConn();
    msg = dbc.getErr();

    if (request.getParameter("userEmail") != null) {

        // Fill WebUserData object with form data (form data is always String)
        wuStringData.userEmail = request.getParameter("userEmail");
        wuStringData.userPw = request.getParameter("userPw");
        wuStringData.userPw2 = request.getParameter("userPw2");
        wuStringData.userName = request.getParameter("userName");
        wuStringData.birthday = request.getParameter("birthday");
        wuStringData.membershipFee = request.getParameter("membershipFee");
        wuStringData.userRoleId = request.getParameter("userRoleId");
        
        // Grab the user role parameter to persist the user's selection
        roleId = Integer.decode(wuStringData.userRoleId);
        
        // Validate user input, set error messages.
        wuValidate = new Validate(wuStringData);
        
        if (wuValidate.isValidated()) { // data is good, proceed to try to insert

            if (msg.length() == 0) { // means no error getting db connection

                // Instantiate Web User Mod object and pass validated String Data to its insert method
                WebUserMods webUserMods = new WebUserMods(dbc);
                msg = webUserMods.insert(wuValidate);

                if (msg.length() == 0) { // empty string means record was sucessfully inserted
                    msg = "Record inserted.";
                }
            }
        }
        
        // Check for error messages and set class error names accordingly
        // My pages use the Bootstrap framework for error reporting
        if (!wuValidate.getUserEmailMsg().equals("")) {
            userEmailErrorClass = "has-error";
        }
        if (!wuValidate.getUserPwMsg().equals("")) {
            userPwErrorClass = "has-error";
        }
        if (!wuValidate.getUserPw2Msg().equals("")) {
            userPw2ErrorClass = "has-error";
        }
        if (!wuValidate.getMembershipFeeMsg().equals("")) {
            membershipFeeErrorClass = "has-error";
        }
        if (!wuValidate.getUserRoleIdMsg().equals("")) {
            userRoleIdErrorClass = "has-error";
        }
        if (!wuValidate.getBirthdayMsg().equals("")) {
            birthdayErrorClass = "has-error";
        }
        
        // Check for successful insert, on success display green text, on error display red text
        if (msg.equals("Record inserted.")) {
            submitSuccessClass = "has-success";
        }
        else if (!msg.equals("")){
            submitSuccessClass = "has-error";
        }
    }
    
    // Create the user role dropdown
    userRoleSelectOrError = WebUserView.makeSelectFromUserRoles("form-control", dbc, roleId);
    
    dbc.close(); // NEVER have db connection leaks !!!
%>

<!-- My web app uses the Bootstrap framework to handle validation states of the
     form elements. The label, input boxes, and error messages will all be 
     displayed in red if a validation error has occured -->

<jsp:include page="pre-content.jsp"></jsp:include>
            <div class="content">
                <div id="page" class="users" display="none"></div>
                <div class="content-text">
                    <h1>User Registration</h1>
                    <form name="insertUser" method="post" action="insertUser.jsp">
                        <div class="form-group <%=userEmailErrorClass%>">
                            <label class="control-label" for="userEmail">Your email:</label>
                            <input class="form-control" type="text" id="inputUserEmail" name="userEmail" placeholder="Enter email" value="<%= wuStringData.userEmail%>"/>
                            <span class="control-label"><%=wuValidate.getUserEmailMsg()%></span>
                        </div>
                        <div class="form-group <%=userPwErrorClass%>">
                            <label class="control-label" for="userPw">Your password:</label>
                            <input class="form-control" type="password" id="inputUserPw" name="userPw" placeholder="Enter password" value="<%= wuStringData.userPw%>"/>
                            <span class="control-label"><%=wuValidate.getUserPwMsg()%></span>
                        </div>
                        <div class="form-group <%=userPw2ErrorClass%>">
                            <label class="control-label" for="userPw2">Re-enter password:</label>
                            <input class="form-control" type="password" id="inputUserPw2" name="userPw2" placeholder="Re-enter password" value="<%= wuStringData.userPw2%>"/>
                            <span class="control-label"><%=wuValidate.getUserPw2Msg()%></span>
                        </div>
                        <div class="form-group <%=userNameErrorClass%>">
                            <label class="control-label" for="userName">Your user name (optional):</label>
                            <input class="form-control" type="text" id="inputUserName" name="userName" placeholder="Enter user name" value="<%= wuStringData.userName%>"/>
                            <span class="control-label"><%=wuValidate.getUserNameMsg()%></span>
                        </div>
                        <div class="form-group <%=birthdayErrorClass%>">
                            <label class="control-label" for="birthday">Your birthday (optional):</label>
                            <input class="form-control" type="text" id="inputBirthday" name="birthday" placeholder="Enter birthday" value="<%= wuStringData.birthday%>"/>
                            <span class="control-label"><%=wuValidate.getBirthdayMsg()%></span>
                        </div>
                        <div class="form-group <%=membershipFeeErrorClass%>">
                            <label class="control-label" for="membershipFee">Membership fee (optional):</label>
                            <div class="input-group">
                                <div class="input-group-addon">$</div>
                                <input class="form-control" type="text" id="inputMembershipFee" name="membershipFee" placeholder="Enter membership fee" value="<%= wuStringData.membershipFee%>"/>
                                <div class="input-group-addon">.00</div>
                            </div>
                            <span class="control-label"><%=wuValidate.getMembershipFeeMsg()%></span>
                        </div>
                        <div class="form-group <%=userRoleIdErrorClass%>">
                            <label class="control-label" for="userRoleId">User role ID:</label>
                            <%=userRoleSelectOrError%>
                            <span class="control-label"><%=wuValidate.getUserRoleIdMsg()%></span>
                        </div>
                        <div class="form-group <%=submitSuccessClass%>">
                            <input type="submit" class="btn btn-default" value="Submit">
                            <span class="control-label"><%=msg%></span>
                        </div>
                    </form>
                    <a href="users.jsp"><h3>List Web Users</h3></a>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>