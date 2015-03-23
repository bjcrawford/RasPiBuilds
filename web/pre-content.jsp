<%--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   pre-content.jsp
 Date:   Jan 31, 2015
 Desc:   This file contains the boiler plate html code for the
         web app pages. This file begins with an html open tag
         and finishes inside an opened head tag.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.web_user.*" %>   
<%@page import="sql.DbConn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="http://fonts.googleapis.com/css?family=Bitter:400,700,400italic" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link id="styleID" rel="stylesheet" type="text/css" href="css/default.css">
        <link rel="stylesheet" href="css/tinyeditor.css" />
        <script src="js/jquery_1.11.2.min.js"></script>
        <script src="js/jquery.popupoverlay.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/raspiscripts.js" type="text/javascript"></script>
        <script src="js/pacman.js" type="text/javascript"></script>
        <script src="js/raspberry.js" type="text/javascript"></script>
        <script src="js/pacmanAnimation.js" type="text/javascript"></script>
        <script src="js/tinyeditor.js" type="text/javascript"></script>
        <title></title>
    </head>   
    <body onLoad="initializeCanvas();">
        
        <%
            // variables to persist user entered data and give sign on success/failure message
            String strUserEmail = "";
            String strUserPw = "";
            String signInMsg = "";
            
            StringData signedInWebUser;

            //  Variables for the sign in/welcome content visiblity classes
            String signInVisibilityClass = "signin-content-visible";
            String welcomeVisibilityClass = "welcome-content-invisible";
            
            if ((signedInWebUser = (StringData) session.getAttribute("webUser")) != null) { // Web user is already signed in
                signInVisibilityClass = "signin-content-invisible";
                welcomeVisibilityClass = "welcome-content-visible";
                String welcomeName = signedInWebUser.userName.equals("") ? signedInWebUser.userEmail : signedInWebUser.userName;
                signInMsg = "Welcome, " + welcomeName + "</br>";
            }
            else { // Web user is not signed in, check for postback from sign in form

                if (request.getParameter("signin-email") != null) { // postback

                    strUserEmail = request.getParameter("signin-email");
                    strUserPw = request.getParameter("signin-pw");
                    DbConn dbc = new DbConn();

                    // put database connection error message to be displayed
                    // it will be "" empty string if no error.
                    signInMsg = dbc.getErr();
                    if (signInMsg.length() == 0) { // no error message -- database connection worked

                        // pass in user's email address and password (along with open db connection)
                        // to find method. The find method will return null if not found, else
                        // it will return a web user StringData object. 
                        signedInWebUser = WebUserMods.find(dbc, strUserEmail, strUserPw);
                        
                        if (signedInWebUser == null) { // Web users's credentials were not found
                            signInMsg = "<span style=\"color: red;\">Invalid email or password</span></br>";
                            try {
                                //session.invalidate();
                            } catch (Exception e) {
                                // don't care. If session was already invalidated, then I dont 
                                // need to do anything.
                            }
                        }
                        else if (signedInWebUser.errorMsg.length() > 0) { // Exception thrown in the find method
                            // Normally would not get this unless program has a bug.
                            signInMsg = "Error " + signedInWebUser.errorMsg + "</br>";
                        } 
                        else { // Web user signed in sucessfully
                            String welcomeName = signedInWebUser.userName.equals("") ? signedInWebUser.userEmail : signedInWebUser.userName;
                            signInMsg = "Welcome, " + welcomeName + "</br>";

                            // put object signedInWebUser into the session, giving it the name
                            // "web_user" (you need to use this name, later to pull the object
                            // back out of the session.
                            session.setAttribute("webUser", signedInWebUser);
                            
                            signInVisibilityClass = "signin-content-invisible";
                            welcomeVisibilityClass = "welcome-content-visible";
                        }
                    }
                }
            }
        %>
        
        <canvas id="pacman-canvas"></canvas>
        <button id="pacman-exit-button">Exit</button>
        <br/>
        <div class="container">
            <div class="header">
                <div class="signin-container">
                    <div class="signin-content <%=signInVisibilityClass%>">
                        <%=signInMsg%>
                        <a href="#signin-popup" class="signin-popup_open">
                            <button type="button" class="btn btn-success btn-lg">Sign In</button>
                        </a>
                        <a href="insertUser.jsp">
                            <button type="button" class="btn btn-default btn-lg">Sign Up</button>
                        </a>
                    </div>
                    <div class="welcome-content <%=welcomeVisibilityClass%>">
                        <%=signInMsg%>
                        <a href="signout.jsp">
                            <button type="button" class="btn btn-default btn-lg">Sign Out</button>
                        </a>
                    </div>
                </div>
                <div class="title-container">
                    <div id="raspilogo" class="title-img">
                        <img id="raspberry" src="img/raspilogo.png" alt="Raspberry Pi Logo">
                    </div>
                    <div class="title">RasPi Builds</div>
                    <div class="title-desc">
                        Inspiration for projects using Raspberry Pi
                    </div>
                </div>
            </div>
            <div class="nav">
                <div id="home" class="tab">
                    <a href="index.jsp"><span class="tab-link"></span></a>
                    Home
                    <span id="home-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="builds" class="tab">
                    <a href="assoc.jsp"><span class="tab-link"></span></a>
                    Builds
                    <span id="builds-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="projects" class="tab">
                    <a href="other.jsp"><span class="tab-link"></span></a>
                    Projects
                    <span id="projects-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="users" class="tab">
                    <a href="users.jsp"><span class="tab-link"></span></a>
                    Users
                    <span id="users-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="search" class="tab">
                    <a href="search.jsp"><span class="tab-link"></span></a>
                    Search
                    <span id="search-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="contact" class="tab">
                    <a href="contact.jsp"><span class="tab-link"></span></a>
                    Contact
                    <span id="contact-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="membersOnly" class="tab">
                    <a href="membersOnly.jsp"><span class="tab-link"></span></a>
                    Members
                    <span id="members-tab-connector" class="tab-connector-unselected"></span>
                    <span class="tab-divider"></span>
                </div>
                <div id="labs" class="tab tab-with-dropdown">
                    
                    <a href="labs.jsp"><span class="tab-link"></span></a>
                    Labs
                    <span id="labs-tab-connector" class="tab-connector-unselected"></span>
                    <div class="tab-dropdown-menu">
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab01"><span class="tab-dropdown-item-link"></span></a>
                            Lab 01
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab02"><span class="tab-dropdown-item-link"></span></a>
                            Lab 02
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab03"><span class="tab-dropdown-item-link"></span></a>
                            Lab 03
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab04"><span class="tab-dropdown-item-link"></span></a>
                            Lab 04
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab05"><span class="tab-dropdown-item-link"></span></a>
                            Lab 05
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab06"><span class="tab-dropdown-item-link"></span></a>
                            Lab 06
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab07"><span class="tab-dropdown-item-link"></span></a>
                            Lab 07
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab08"><span class="tab-dropdown-item-link"></span></a>
                            Lab 08
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab09"><span class="tab-dropdown-item-link"></span></a>
                            Lab 09
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#lab10"><span class="tab-dropdown-item-link"></span></a>
                            Lab 10
                        </div>
                        <div class="tab-dropdown-item">
                            <a href="labs.jsp#challenge"><span class="tab-dropdown-item-link"></span></a>
                            Challenge
                        </div>
                    </div>
                </div>
                <div class="newLine"></div>
            </div>