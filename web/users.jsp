<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   users.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="model.web_user.StringData" %>
<%@page language="java" import="model.web_user.Validate" %>
<%@page language="java" import="model.web_user.WebUserMods" %>
<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="view.WebUserView" %>
<%
    StringData wuStringData = new StringData();
    Validate wuValidate = new Validate();

    // Message for confirmation of state of the update
    String msg = "";
    
    // The HTML code for the user role dropdown
    String userRoleSelectOrError = "";
    
    // Class names for errors on form submission
    String userEmailErrorClass = "";
    String userPwErrorClass = "";
    String userPw2ErrorClass = "";
    String userNameErrorClass = "";
    String birthdayErrorClass = "";
    String membershipFeeErrorClass = "";
    String userRoleIdErrorClass = "";
    String submitSuccessClass = "";

    int roleId = 1;
    boolean shouldOpenPopup = false;
    
    DbConn dbc = new DbConn();
    String userTableOrError = dbc.getErr();
    if (userTableOrError.length() == 0) { 
        String classes = "user-table table table-striped table-bordered";
        userTableOrError = WebUserView.makeTableFromAllUsers(classes, dbc);
    }
    
    if (request.getParameter("userId") != null) { // Postback, perform update
        
        // Fill WebUserData object with form data (form data is always String)
        wuStringData.webUserId = request.getParameter("userId");
        wuStringData.userEmail = request.getParameter("userEmail");
        wuStringData.userPw = request.getParameter("userPw");
        wuStringData.userPw2 = request.getParameter("userPw2");
        wuStringData.userName = request.getParameter("userName");
        wuStringData.birthday = request.getParameter("birthday");
        wuStringData.membershipFee = request.getParameter("membershipFee");
        wuStringData.userRoleId = request.getParameter("userRoleId");
        roleId = Integer.decode(wuStringData.userRoleId);
        
    
        // Validate user input, set error messages.
        wuValidate = new Validate(wuStringData);

        if (wuValidate.isValidated()) { // data is good, proceed to try to update

            if (msg.length() == 0) { // means no error getting db connection

                // Instantiate Web User Mod object and pass validated String Data to its insert method
                WebUserMods webUserMods = new WebUserMods(dbc);
                msg = webUserMods.update(wuValidate);

                if (msg.length() == 0) { // empty string means record was sucessfully updated
                    msg = "Record " + wuStringData.userEmail + " updated. ";
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
        if (msg.startsWith("Record") && msg.endsWith("updated.")) {
            submitSuccessClass = "has-success";
        }
        else if (!msg.equals("")){
            submitSuccessClass = "has-error";
            if (msg.equals("Cannot update a record with that email address already exists.")) {
                msg = "";
                userEmailErrorClass = "has-error";
                wuValidate.setUserEmailMsg("Email address already exists. Please choose another.");
            }
        }
        
        // Need to figure out how to open the update user popup from here
        shouldOpenPopup = true;
    }
    
    
    
    
    // Create the user role dropdown on user update form
    userRoleSelectOrError = WebUserView.makeSelectFromUserRoles("form-control", dbc, roleId);
    
    dbc.close();
%>

<jsp:include page="pre-content.jsp"></jsp:include> 
            <div class="content">
                <div id="page" class="users" display="none"></div>
                <div class="content-text">
                    <br/>
                    <h3><a href="insertUser.jsp">Add a user</a></h3>
                    <p>
                        This table contains a list of all of the users in the 
                        database. After grading of lab 8, I have removed the 
                        encrypted password column to make the display of this
                        list better fit the page.
                    </p>
                    <br/>
                    <div class="table-responsive">
                        <%=userTableOrError%>
                    </div>
                </div>
                    
                <!-- Hidden user update popup -->    
                    
                <div id="userupdate-popup" class="well raspi-popup">
                    <h3>Update User - ID: <span id="updateuser-id"><%= wuStringData.webUserId%></span></h3>
                    <form name="updateuserform" action="users.jsp" method="post">
                        <input class="hidden" type="text" id="inputUserId" name="userId" value="<%= wuStringData.webUserId%>">
                        <table>
                            <tr>
                                <td>
                                    <div id="userupdate-emailgroup" class="form-group <%=userEmailErrorClass%>">
                                        <label class="control-label" for="userEmail">Your email:</label>
                                        <input class="form-control" type="text" id="inputUserEmail" name="userEmail" placeholder="Enter email" value="<%= wuStringData.userEmail%>"/>
                                        <span id="userupdate-emailmsg" class="control-label"><%=wuValidate.getUserEmailMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="userupdate-namegroup" class="form-group <%=userNameErrorClass%>">
                                        <label class="control-label" for="userName">Your user name (optional):</label>
                                        <input class="form-control" type="text" id="inputUserName" name="userName" placeholder="Enter user name" value="<%= wuStringData.userName%>"/>
                                        <span id="userupdate-namemsg" class="control-label"><%=wuValidate.getUserNameMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="userupdate-pwgroup" class="form-group <%=userPwErrorClass%>">
                                        <label class="control-label" for="userPw">Your password:</label>
                                        <input class="form-control" type="password" id="inputUserPw" name="userPw" placeholder="Enter password" value="<%= wuStringData.userPw%>"/>
                                        <span id="userupdate-pwmsg" class="control-label"><%=wuValidate.getUserPwMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="userupdate-birthdaygroup" class="form-group <%=birthdayErrorClass%>">
                                        <label class="control-label" for="birthday">Your birthday (optional):</label>
                                        <input class="form-control" type="text" id="inputBirthday" name="birthday" placeholder="Enter birthday" value="<%= wuStringData.birthday%>"/>
                                        <span id="userupdate-birthdaymsg" class="control-label"><%=wuValidate.getBirthdayMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="userupdate-pw2group" class="form-group <%=userPw2ErrorClass%>">
                                        <label class="control-label" for="userPw2">Re-enter password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <input class="form-control" type="password" id="inputUserPw2" name="userPw2" placeholder="Re-enter password" value="<%= wuStringData.userPw2%>"/>
                                        <span id="userupdate-pw2msg" class="control-label"><%=wuValidate.getUserPw2Msg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="userupdate-membershipfeegroup" class="form-group <%=membershipFeeErrorClass%>">
                                        <label class="control-label" for="membershipFee">Membership fee (optional):</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">$</div>
                                            <input class="form-control" type="text" id="inputMembershipFee" name="membershipFee" placeholder="Enter membership fee" value="<%= wuStringData.membershipFee%>"/>
                                            <div class="input-group-addon">.00</div>
                                        </div>
                                        <span id="userupdate-membershipfeemsg" class="control-label"><%=wuValidate.getMembershipFeeMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div id="userupdate-roleidgroup" class="form-group <%=userRoleIdErrorClass%>">
                            <label class="control-label" for="userRoleId">User role ID:</label>
                            <%=userRoleSelectOrError%>
                            <span id="userupdate-roleidmsg" class="control-label"><%=wuValidate.getUserRoleIdMsg()%></span>
                        </div>
                        <div id="userupdate-submitgroup" class="form-group <%=submitSuccessClass%>">
                            <input type="submit" class="btn btn-default btn-success" value="Update">
                            <span id="userupdate-submitmsg" class="control-label"><%=msg%></span>
                        </div>
                        <button type="button" class="userupdate-popup_close btn btn-default btn-sm close-btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
                <script type="text/javascript">openUserUpdatePopup(<%=shouldOpenPopup%>);</script>
<jsp:include page="post-content.jsp"></jsp:include>
            