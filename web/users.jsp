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
    // The user table
    String userTableOrError = "";
    
    // Objects for the update functionality
    StringData wuUpdateStringData = new StringData();
    Validate wuUpdateValidate = new Validate();
    
    // Objects for the delete functionality
    StringData wuDeleteStringData = new StringData();
    
    // Message for confirmation of state of the update
    String updateMsg = "";
    
    // Message for confirmation of state of the delete
    String deleteMsg = "";
    
    // The HTML code for the user role dropdown
    String userRoleSelectOrError = "";
    
    // Default value for role id select
    int roleId = 1;
    
    // Class names for errors on update form
    String userEmailErrorClass = "";
    String userPwErrorClass = "";
    String userPw2ErrorClass = "";
    String userNameErrorClass = "";
    String birthdayErrorClass = "";
    String membershipFeeErrorClass = "";
    String userRoleIdErrorClass = "";
    
    // Class name for error/success on update form
    String submitClass = "";
    
    // Class name for error/success on delete form
    String submitDeleteClass = "";
    
    // Class name for hiding the elements on the delete form
    // after a successful deletion
    String submitDeleteElementsHidden = "";

    // Don't automatically show user update popup on first load
    boolean shouldOpenUpdatePopup = false;
    
    // Don't automatically show user delete popup on first load
    boolean shouldOpenDeletePopup = false;
    
    DbConn dbc = new DbConn();
    if (dbc.getErr().length() == 0) { 
    
        if (request.getParameter("userId") != null) { // update postback
            
            // Populate StringData object with posted params
            wuUpdateStringData.setWebUserId(request.getParameter("userId"));
            wuUpdateStringData.setUserEmail(request.getParameter("userEmail"));
            wuUpdateStringData.setUserPw(request.getParameter("userPw"));
            wuUpdateStringData.setUserPw2(request.getParameter("userPw2"));
            wuUpdateStringData.setUserName(request.getParameter("userName"));
            wuUpdateStringData.setBirthday(request.getParameter("birthday"));
            wuUpdateStringData.setMembershipFee(request.getParameter("membershipFee"));
            wuUpdateStringData.setUserRoleId(request.getParameter("userRoleId"));
            roleId = Integer.decode(wuUpdateStringData.getUserRoleId());

            wuUpdateValidate = new Validate(wuUpdateStringData);
            if (wuUpdateValidate.isValidated()) {

                // Instantiate WebUserMods object and pass validated StringData to its update method
                WebUserMods webUserMods = new WebUserMods(dbc);
                updateMsg = webUserMods.update(wuUpdateValidate);

                if (updateMsg.length() == 0) { // empty string means record was sucessfully updated
                    updateMsg = "Record " + wuUpdateStringData.getUserEmail() + " updated. ";
                }
            }

            // Check for error messages and set class error names accordingly
            // My pages use the Bootstrap framework for error reporting
            if (!wuUpdateValidate.getUserEmailMsg().equals("")) {
                userEmailErrorClass = "has-error";
            }
            if (!wuUpdateValidate.getUserPwMsg().equals("")) {
                userPwErrorClass = "has-error";
            }
            if (!wuUpdateValidate.getUserPw2Msg().equals("")) {
                userPw2ErrorClass = "has-error";
            }
            if (!wuUpdateValidate.getMembershipFeeMsg().equals("")) {
                membershipFeeErrorClass = "has-error";
            }
            if (!wuUpdateValidate.getUserRoleIdMsg().equals("")) {
                userRoleIdErrorClass = "has-error";
            }
            if (!wuUpdateValidate.getBirthdayMsg().equals("")) {
                birthdayErrorClass = "has-error";
            }

            // Check for successful update, on success display green text, on error display red text
            if (updateMsg.startsWith("Record") && updateMsg.endsWith("updated.")) {
                submitClass = "has-success";
            }
            else if (!updateMsg.equals("")){
                submitClass = "has-error";
                if (updateMsg.equals("Cannot update a record with that email address already exists.")) {
                    updateMsg = "";
                    userEmailErrorClass = "has-error";
                    wuUpdateValidate.setUserEmailMsg("Email address already exists. Please choose another.");
                }
            }

            // If on postback, we want to open the popup automatically so the 
            // user can see the persisted data or error messages associated
            // with the update
            shouldOpenUpdatePopup = true;
        }
        else if (request.getParameter("deleteUserId") != null) { // Delete postback
            
            try {
                int userId = Integer.decode(request.getParameter("deleteUserId"));
                wuDeleteStringData.setWebUserId(String.valueOf(userId));
                wuDeleteStringData.setUserEmail(request.getParameter("deleteUserEmail"));

                // Instantiate WebUserMods object and pass validated StringData to its delete method
                WebUserMods webUserMods = new WebUserMods(dbc);
                deleteMsg = webUserMods.delete(userId);
                
                if (deleteMsg.length() == 0) { // empty string means record was sucessfully deleted
                    deleteMsg = "Record " + wuDeleteStringData.getUserEmail() + " deleted. ";
                    submitDeleteClass = "has-success";
                    submitDeleteElementsHidden = "hidden";
                }
                else {
                    submitDeleteClass = "has-error";
                    if (deleteMsg.contains("Cannot delete or update a parent row: a foreign key constraint fails")) {
                        deleteMsg = "Please delete any associated Builds before deleting this User.";
                    }
                }
            }
            catch (NumberFormatException e) {
                submitDeleteClass = "has-error";
                deleteMsg = "Internal error, invalid user id format. Error: " +
                        e.getMessage();
            }
            
            // If on postback, we want to open the popup automatically so the 
            // user can see the sucess/error messages associated with the delete
            shouldOpenDeletePopup = true;
        }
        
        // Create the table of users
        String classes = "user-table table table-striped table-bordered";
        userTableOrError = WebUserView.makeTableFromAllUsers(classes, dbc);
        
        // Create the user role dropdown on user update form
        userRoleSelectOrError = WebUserView.makeSelectFromUserRoles("form-control", dbc, roleId);
        
    }
    else {
        userTableOrError = dbc.getErr();
    }
    
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
                    <h3>Update User - ID: <span id="updateuser-id"><%= wuUpdateStringData.getWebUserId()%></span></h3>
                    <form name="updateuserform" action="users.jsp" method="post">
                        <input class="hidden" type="text" id="inputUserId" name="userId" value="<%= wuUpdateStringData.getWebUserId()%>">
                        <table>
                            <tr>
                                <td>
                                    <div id="userupdate-emailgroup" class="form-group <%=userEmailErrorClass%>">
                                        <label class="control-label" for="userEmail">Your email:</label>
                                        <input class="form-control" type="text" id="inputUserEmail" name="userEmail" placeholder="Enter email" value="<%= wuUpdateStringData.getUserEmail()%>"/>
                                        <span id="userupdate-emailmsg" class="control-label"><%=wuUpdateValidate.getUserEmailMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="userupdate-namegroup" class="form-group <%=userNameErrorClass%>">
                                        <label class="control-label" for="userName">Your user name (optional):</label>
                                        <input class="form-control" type="text" id="inputUserName" name="userName" placeholder="Enter user name" value="<%= wuUpdateStringData.getUserName()%>"/>
                                        <span id="userupdate-namemsg" class="control-label"><%=wuUpdateValidate.getUserNameMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="userupdate-pwgroup" class="form-group <%=userPwErrorClass%>">
                                        <label class="control-label" for="userPw">Your password:</label>
                                        <input class="form-control" type="password" id="inputUserPw" name="userPw" placeholder="Enter password" value="<%= wuUpdateStringData.getUserPw()%>"/>
                                        <span id="userupdate-pwmsg" class="control-label"><%=wuUpdateValidate.getUserPwMsg()%></span>
                                    </div>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <div id="userupdate-birthdaygroup" class="form-group <%=birthdayErrorClass%>">
                                        <label class="control-label" for="birthday">Your birthday (optional):</label>
                                        <input class="form-control" type="text" id="inputBirthday" name="birthday" placeholder="Enter birthday" value="<%= wuUpdateStringData.getBirthday()%>"/>
                                        <span id="userupdate-birthdaymsg" class="control-label"><%=wuUpdateValidate.getBirthdayMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="userupdate-pw2group" class="form-group <%=userPw2ErrorClass%>">
                                        <label class="control-label" for="userPw2">Re-enter password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <input class="form-control" type="password" id="inputUserPw2" name="userPw2" placeholder="Re-enter password" value="<%= wuUpdateStringData.getUserPw2()%>"/>
                                        <span id="userupdate-pw2msg" class="control-label"><%=wuUpdateValidate.getUserPw2Msg()%></span>
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
                                            <input class="form-control" type="text" id="inputMembershipFee" name="membershipFee" placeholder="Enter membership fee" value="<%= wuUpdateStringData.getMembershipFee()%>"/>
                                            <div class="input-group-addon">.00</div>
                                        </div>
                                        <span id="userupdate-membershipfeemsg" class="control-label"><%=wuUpdateValidate.getMembershipFeeMsg()%></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div id="userupdate-roleidgroup" class="form-group <%=userRoleIdErrorClass%>">
                            <label class="control-label" for="userRoleId">User role ID:</label>
                            <%=userRoleSelectOrError%>
                            <span id="userupdate-roleidmsg" class="control-label"><%=wuUpdateValidate.getUserRoleIdMsg()%></span>
                        </div>
                        <div id="userupdate-submitgroup" class="form-group <%=submitClass%>">
                            <input type="submit" class="btn btn-default btn-success" value="Update">
                            <span id="userupdate-submitmsg" class="control-label"><%=updateMsg%></span>
                        </div>
                        <button type="button" class="userupdate-popup_close btn btn-default btn-sm close-btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
                <script type="text/javascript">openUserUpdatePopup(<%=shouldOpenUpdatePopup%>);</script>
                
                <!-- Hidden user delete popup -->    
                <div id="userdelete-popup" class="well raspi-popup">
                    <h3>Delete User - ID: <span id="deleteuser-id"><%= wuDeleteStringData.getWebUserId()%></span></h3>
                    <span id="userdelete-popup-confirm" class="<%=submitDeleteElementsHidden%>">
                        <p>Are you sure you wish to delete this user?</p>
                        <span><b>User email:</b></span>
                        <span id="deleteuser-email"><%=wuDeleteStringData.getUserEmail()%></span>
                        </br></br>
                    </span>
                    <form name="deleteuserform" action="users.jsp" method="post">
                        <input class="hidden" type="text" id="inputDeleteUserId" name="deleteUserId" value="<%=wuDeleteStringData.getWebUserId()%>">
                        <input class="hidden" type="text" id="inputDeleteUserEmail" name="deleteUserEmail" value="<%=wuDeleteStringData.getUserEmail()%>">
                        <span id="userdelete-submitgroup" class="form-group <%=submitDeleteClass%>">
                            <div class="center-text"><span id="userdelete-submitmsg" class="control-label"><%=deleteMsg%></span></div>
                            <input type="submit" id="userdelete-submitbutton" class="btn btn-default btn-danger <%=submitDeleteElementsHidden%>" disabled="disabled" value="Delete">
                            <button type="button" id="userdelete-cancelbutton" class="userdelete-popup_close btn btn-default btn-default <%=submitDeleteElementsHidden%>">Cancel</button>
                        </span>
                    </form>
                    <button type="button" class="userdelete-popup_close btn btn-default btn-sm close-btn">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    </button>
                </div>
                <script type="text/javascript">openUserDeletePopup(<%=shouldOpenDeletePopup%>);</script>
<jsp:include page="post-content.jsp"></jsp:include>
            