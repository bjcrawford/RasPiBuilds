/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   raspiscripts.js
 *  Date:   Feb 4, 2015
 *  Desc:   This file contains javascript that is used for various
 *          purposes within the web app.
 */


// Some global values to allow for aynchronous calls
var httpReq;
if (window.XMLHttpRequest) {
    httpReq = new XMLHttpRequest(); //For Firefox, Safari, Opera
}
else if (window.ActiveXObject) {
    httpReq = new ActiveXObject("Microsoft.XMLHTTP"); //For IE 5+
} 
else {
    alert('ajax not supported');
}

/**
 * Enables/disables the user type radio buttons on the contact
 * page depending on the status of the registered user check box.
 */
function displayUserTypeButtons() {
    if (document.getElementById("registereduser").checked) {
        document.getElementById("divUserType").hidden = false;
        document.getElementById("usertype1").disabled = false;
        document.getElementById("usertype2").disabled = false;
        document.getElementById("usertype3").disabled = false;
    }
    else {
        document.getElementById("divUserType").hidden = true;
        document.getElementById("usertype1").disabled = true;
        document.getElementById("usertype2").disabled = true;
        document.getElementById("usertype3").disabled = true;
    }
};

/**
 * Checks the cookie for a theme preference. If found, sets
 * the theme.
 */
function checkAndSetTheme() {
    var href = readCookie("RaspiBuilds_Theme");
    if(href !== null) {
        document.getElementById("styleID").href = href;
        var index = 1;
        if (href === "css/inversion.css") {
            index = 2;
        }
        else if (href === "css/minimal.css") {
            index = 3;
        }
        document.getElementById("theme-select").selectedIndex = index;        
    }
}

/**
 * Changes the stylesheet and creates a cookie to store
 * the theme preference. If the parameter matches the 
 * string "clear", the theme preference is cleared
 * from the cookie.
 * 
 * @param {string} newHref the path to the new stylesheet
 */
function changeStylesheet(newHref) {
    
    if(newHref === "clear") {
        eraseCookie("RaspiBuilds_Theme");
    }
    else {
        document.getElementById("styleID").href = newHref;

        // Write to cookie, should overwrite any existing key/value
        createCookie("RaspiBuilds_Theme", newHref, 1000);
    }
}

/**
 * Creates a cookie with the given parameters.
 * 
 * @param {string} name
 * @param {string} value
 * @param {int} days
 */
function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else {
        var expires = "";
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

/**
 * Returns the value stored in the cookie for the given 
 * name(key). Returns null if no matching name is found.
 * 
 * @param {string} name
 * @returns {string}
 */
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') { 
            c = c.substring(1, c.length);
        }
        if (c.indexOf(nameEQ) === 0) {
            return c.substring(nameEQ.length, c.length);
        }
    }
    return null;
}

/**
 * Erases the value stored in the cookie that is associated
 * with the given name(key).
 * 
 * @param {string} name
 */
function eraseCookie(name) {
    createCookie(name, "", -1);
}

/**
 * Shows the value of a given cookie name in an alert. For debugging.
 * 
 * @param {String} name
 */
function showCookie(name) {
    
    var cookieVal = readCookie(name);
    if (cookieVal === null) {
        alert ("No cookie value was stored with name " + name);
    } 
    else {
        alert ("The cookie named " + name + " has value " + cookieVal);
    }
}

/**
 * Calls the neccessary functions for page initialization. Called
 * from the close of every page.
 */
function initPage() {
    checkAndSetTheme();
    initSelectedPage();
}

/**
 * Determines the current page and takes the appropriate actions
 * for that page's initialization.
 */
function initSelectedPage() {
    
    initSignInPopup();
    
    if (document.getElementById("page").className.indexOf("home") > -1) {
        document.title = "Home | RasPi Builds";
        document.getElementById("home-tab-connector").className = "";
        initSlideToggleParagraphs();
        initHomePopups();
    }
    else if (document.getElementById("page").className.indexOf("builds") > -1) {
        document.title = "Builds | RasPi Builds";
        document.getElementById("builds-tab-connector").className = "";
        //initBuildDeletePopup();
    }
    else if (document.getElementById("page").className.indexOf("projects") > -1) {
        document.title = "Projects | RasPi Builds";
        document.getElementById("projects-tab-connector").className = "";
        initProjectUpdatePopup();
        //initProjectDeletePopup();
    }
    else if (document.getElementById("page").className.indexOf("users") > -1) {
        document.title = "Users | RasPi Builds";
        document.getElementById("users-tab-connector").className = "";
        initUsersUpdatePopup();
        initUsersDeletePopup();
    }
    else if (document.getElementById("page").className.indexOf("search") > -1) {
        document.title = "Search | RasPi Builds";
        document.getElementById("search-tab-connector").className = "";
    }
    else if (document.getElementById("page").className.indexOf("contact") > -1) {
        document.title = "Contact | RasPi Builds";
        document.getElementById("contact-tab-connector").className = "";
    }
    else if (document.getElementById("page").className.indexOf("members") > -1) {
        document.title = "Members | RasPi Builds";
        document.getElementById("members-tab-connector").className = "";
    }
    else if (document.getElementById("page").className.indexOf("labs") > -1) {
        document.title = "Labs | RasPi Builds";
        document.getElementById("labs-tab-connector").className = "";
        initLabsPopups();
    }
}

/**
 * Initializes the slide toggle functionality on the index page paragraphs.
 */
function initSlideToggleParagraphs() {
    $(document).ready(function(){
        $("#whatis-raspberrypi-heading").click(function(){
            $("#whatis-raspberrypi-para").slideToggle();
        });
    });
    $(document).ready(function(){
        $("#whatis-raspibuilds-heading").click(function(){
            $("#whatis-raspibuilds-para").slideToggle();
        });
    });
}

/**
 * Initializes the sign in popup.
 */
function initSignInPopup() {
    
    $(document).ready(function() {
       
        $('#signin-popup').popup();
        
    });
}

/**
 * Initializes the image popups on the index page.
 */
function initHomePopups() {
    
    $(document).ready(function() {

        $('#rp-img1-popup').popup();
        $('#rp-img2-popup').popup();
    });
}/**
 * Initializes the project update popup. Sets an onOpen listener function
 * to clear any data when the popup is opened.
 */
function initProjectUpdatePopup() {
    
    $(document).ready(function() {
        $('#projectupdate-popup').popup({
            onopen: function() {
                
                // Clear previous data
                $('#updateproject-id').html("");
                document.updateprojectform.projectName.value = "";
                document.updateprojectform.projectDesc.value = "";
                document.updateprojectform.projectGuide.value = "";
                //pgTinyEditor.setEditorContent("");
                document.updateprojectform.projectImgUrl.value = "";
                document.updateprojectform.projectCost.value = "";
            }
        });
    });
}

/**
 * Initializes the project delete popup. Sets an onOpen listener function
 * to clear any data when the popup is opened.
 */
function initProjectDeletePopup() {
    
    $(document).ready(function() {
        $('#projectdelete-popup').popup({
            onopen: function() {
                
                // Clear previous data
                $('#deleteproject-id').html("");
                $('#deleteproject-name').html("");
                document.deleteprojectform.deleteProjectId.value = "";
                document.deleteprojectform.deleteProjectName.value = "";
            }
        });
    });
}

/**
 * Initializes the user update popup. Sets an onOpen listener function
 * to clear any data when the popup is opened.
 */
function initUsersUpdatePopup() {
    
    $(document).ready(function() {
        $('#userupdate-popup').popup({
            onopen: function() {
                
                // Clear previous data
                $('#updateuser-id').html("");
                document.updateuserform.userId.value = "";
                document.updateuserform.userEmail.value = "";
                document.updateuserform.userPw.value = "";
                document.updateuserform.userPw2.value = "";
                document.updateuserform.userName.value = "";
                document.updateuserform.birthday.value = "";
                document.updateuserform.membershipFee.value = "";
                document.updateuserform.userRoleId.value = "";
            }
        });
    });
}

/**
 * Initializes the user update popup. Sets an onOpen listener function
 * to clear any data when the popup is opened.
 */
function initUsersDeletePopup() {
    
    $(document).ready(function() {
        $('#userdelete-popup').popup({
            onopen: function() {
                
                // Clear previous data
                $('#deleteuser-id').html("");
                $('#deleteuser-email').html("");
                document.deleteuserform.deleteUserId.value = "";
                document.deleteuserform.deleteUserEmail.value = "";
                
                // Clear hidden confirmation elements
                $('#userdelete-popup-confirm').removeClass("hidden");
                $('#userdelete-submitbutton').removeClass("hidden");
                $('#userdelete-cancelbutton').removeClass("hidden");
        
                // Clear submit button disabled attribute
                $('#userdelete-submitbutton').removeAttr("disabled");
            }
        });
    });
}

/**
 * Initializes the build delete popup. Sets an onOpen listener function
 * to clear any data when the popup is opened.
 */
function initBuildDeletePopup() {
    
    $(document).ready(function() {
        $('#builddelete-popup').popup({
            onopen: function() {
                
                // Clear previous data
                $('#deletebuild-id').html("");
                $('#deletebuild-name').html("");
                document.deletebuildform.deleteBuildId.value = "";
                document.deletebuildform.deleteBuildName.value = "";
            }
        });
    });
}

/**
 * Initializes the image popup on the labs page.
 */
function initLabsPopups() {
    
    $(document).ready(function() {

        $('#datamodel-img-popup').popup();

    });
}

/**
 * Opens the user update form on the users page if passed true, Otherwise,
 * does nothing.
 * 
 * @param {boolean} shouldOpen
 */
function openUserUpdatePopup(shouldOpen) {
    
    if (shouldOpen) {
        $('#userupdate-popup').popup('show');
    }
}

/**
 * Opens the user delete popup on the users page if passed true, Otherwise,
 * does nothing.
 * 
 * @param {boolean} shouldOpen
 */
function openUserDeletePopup(shouldOpen) {
    
    if (shouldOpen) {
        $('#userdelete-popup').popup('show');
    }
}

/**
 * Opens the project update form on the projects page if passed true, Otherwise,
 * does nothing.
 * 
 * @param {boolean} shouldOpen
 */
function openProjectUpdatePopup(shouldOpen) {
    
    if (shouldOpen) {
        $('#projectupdate-popup').popup('show');
    }
}

/**
 * Sends a request associated with an update to the getUserJSON.jsp page for 
 * user information for a given id. Responses are sent to the 
 * handleUpdateUserInfoByIdResponse() method.
 * 
 * @param {int} userId
 */
function requestUpdateUserInfoById(userId) {
    httpReq.open("post", "getUserJSON.jsp?userId=" + userId);
    httpReq.onreadystatechange = handleUpdateUserInfoByIdResponse;
    httpReq.send(null);
}

/**
 * Handles receiving a response from a request associated with a user update
 * for user information by id. Populates fields on the user update form with 
 * non-null data, removes any css error classes, and clears any error messages.
 */
function handleUpdateUserInfoByIdResponse() {

    if (httpReq.readyState == 4 && httpReq.status == 200) {
        
        var userObj = eval(httpReq.responseText);

        // Populate form data
        $('#updateuser-id').html(userObj.webUserId);
        document.updateuserform.userId.value = userObj.webUserId;
        document.updateuserform.userEmail.value = userObj.userEmail;
        document.updateuserform.userPw.value = userObj.userPw;
        document.updateuserform.userPw2.value = userObj.userPw;
        if (userObj.userName != "null") {
            document.updateuserform.userName.value = userObj.userName;
        }
        if (userObj.birthday != "null") {
            document.updateuserform.birthday.value = userObj.birthday;
        }
        if (userObj.membershipFee != "null") {
            document.updateuserform.membershipFee.value = userObj.membershipFee;
        }
        document.updateuserform.userRoleId.value = userObj.userRoleId;
              
        // Clear css error classes
        $('#userupdate-emailgroup').attr("class", "form-group");
        $('#userupdate-pwgroup').attr("class", "form-group");
        $('#userupdate-pw2group').attr("class", "form-group");
        $('#userupdate-namegroup').attr("class", "form-group");
        $('#userupdate-birthdaygroup').attr("class", "form-group");
        $('#userupdate-membershipfeegroup').attr("class", "form-group");
        $('#userupdate-roleidgroup').attr("class", "form-group");
        $('#userupdate-submitgroup').attr("class", "form-group");

        // Clear error msgs
        $('#userupdate-emailmsg').html("");
        $('#userupdate-pwmsg').html("");
        $('#userupdate-pw2msg').html("");
        $('#userupdate-namemsg').html("");
        $('#userupdate-birthdaymsg').html("");
        $('#userupdate-membershipfeemsg').html("");
        $('#userupdate-roleidmsg').html("");
        $('#userupdate-submitmsg').html("");
    }
}


/**
 * Sends a request associated with a delete to the getUserJSON.jsp page for 
 * user information for a given id. Responses are sent to the 
 * handleDeleteUserInfoByIdResponse() method.
 * 
 * @param {int} userId
 */
function requestDeleteUserInfoById(userId) {
    httpReq.open("post", "getUserJSON.jsp?userId=" + userId);
    httpReq.onreadystatechange = handleDeleteUserInfoByIdResponse;
    httpReq.send(null);
}

/**
 * Handles receiving a response from a request associated with a user delete
 * for user information by id. Populates fields on the verify user delete form 
 * with non-null data.
 */
function handleDeleteUserInfoByIdResponse() {

    if (httpReq.readyState == 4 && httpReq.status == 200) {
        
        var userObj = eval(httpReq.responseText);
        
        // Populate form data
        $('#deleteuser-id').html(userObj.webUserId);
        $('#deleteuser-email').html(userObj.userEmail);
        document.deleteuserform.deleteUserId.value = userObj.webUserId;
        document.deleteuserform.deleteUserEmail.value = userObj.userEmail;
        
        // Clear css error classes
        $('#userdelete-submitgroup').attr("class", "form-group");

        // Clear error msgs
        $('#userdelete-submitmsg').html("");
        
    }
}


/**
 * Sends a request to the getProjectJSON.jsp page for project information for a 
 * given id. Responses are sent to the handleProjectInfoByIdResponse() method.
 * 
 * @param {int} projectId
 */
function requestProjectInfoById(projectId) {
    httpReq.open("post", "getProjectJSON.jsp?projectId=" + projectId);
    httpReq.onreadystatechange = handleProjectInfoByIdResponse;
    httpReq.send(null);
}

/**
 * Handles receiving a response from a request for project information by id.
 * Populates fields on the project update form with non-null data, removes any 
 * css error classes, and clears any error messages.
 */
function handleProjectInfoByIdResponse() {

    if (httpReq.readyState == 4 && httpReq.status == 200) {
        
        var projectObj = eval(httpReq.responseText);

        // Populate form data
        $('#updateproject-id').html(projectObj.projectId);
        document.updateprojectform.projectId.value = projectObj.projectId;
        document.updateprojectform.projectName.value = projectObj.projectName;
        document.updateprojectform.projectDesc.value = projectObj.projectDesc;
        document.updateprojectform.projectGuide.value = projectObj.projectGuide;
        //pgTinyEditor.setEditorContent(projectObj.projectGuide);
        if (projectObj.projectImgUrl != "null") {
            document.updateprojectform.projectImgUrl.value = projectObj.projectImgUrl;
        }
        if (projectObj.projectCost != "null") {
            document.updateprojectform.projectCost.value = projectObj.projectCost;
        }
                
        // Clear css error classes
        $('#projectupdate-namegroup').attr("class", "form-group");
        $('#projectupdate-descgroup').attr("class", "form-group");
        $('#projectupdate-guidegroup').attr("class", "form-group");
        $('#projectupdate-imgurlgroup').attr("class", "form-group");
        $('#projectupdate-costgroup').attr("class", "form-group");
        $('#projectupdate-submitgroup').attr("class", "form-group");

        // Clear error msgs
        $('#projectupdate-namemsg').html("");
        $('#projectupdate-descmsg').html("");
        $('#projectupdate-guidemsg').html("");
        $('#projectupdate-imgurlmsg').html("");
        $('#projectupdate-costmsg').html("");
        $('#projectupdate-submitmsg').html("");
    }
}