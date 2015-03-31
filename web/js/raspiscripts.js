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
    }
    else if (document.getElementById("page").className.indexOf("projects") > -1) {
        document.title = "Projects | RasPi Builds";
        document.getElementById("projects-tab-connector").className = "";
    }
    else if (document.getElementById("page").className.indexOf("users") > -1) {
        document.title = "Users | RasPi Builds";
        document.getElementById("users-tab-connector").className = "";
        initUsersPopup();
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
}

/**
 * Initializes the user update popup. Sets an onOpen listener function
 * to clear any data when the popup is opened.
 */
function initUsersPopup() {
    
    $(document).ready(function() {
        $('#userupdate-popup').popup({
            onopen: function() {
                
                // Clear any previous data
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
 * Sends a request to the getUserJSON.jsp page for user information for a 
 * given id. Responses are sent to the handleUserInfoByIdResponse() method.
 * 
 * @param {int} userId
 */
function requestUserInfoById(userId) {
    httpReq.open("post", "getUserJSON.jsp?userId=" + userId);
    httpReq.onreadystatechange = handleUserInfoByIdResponse;
    httpReq.send(null);
}

/**
 * Handles receiving a response from a request for user information by id.
 * Populates fields on the user update form with non-null data, removes any 
 * css error classes, and clears any error messages.
 */
function handleUserInfoByIdResponse() {

    if (httpReq.readyState == 4 && httpReq.status == 200) {
        
        var userObj = eval(httpReq.responseText);

        // Populate form data
        $('#updateuser-id').html(userObj.webUserId);
        document.updateuserform.userId.value = userObj.webUserId;
        document.updateuserform.userEmail.value = userObj.userEmail;
        document.updateuserform.userPw.value = "";
        document.updateuserform.userPw2.value = "";
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

        // Clear all css error classes
        $('#userupdate-emailgroup').attr("class", "form-group");
        $('#userupdate-pwgroup').attr("class", "form-group");
        $('#userupdate-pw2group').attr("class", "form-group");
        $('#userupdate-namegroup').attr("class", "form-group");
        $('#userupdate-birthdaygroup').attr("class", "form-group");
        $('#userupdate-membershipfeegroup').attr("class", "form-group");
        $('#userupdate-roleidgroup').attr("class", "form-group");
        
        // Clear all error msgs
        $('#userupdate-emailmsg').html("");
        $('#userupdate-pwmsg').html("");
        $('#userupdate-pw2msg').html("");
        $('#userupdate-namemsg').html("");
        $('#userupdate-birthdaymsg').html("");
        $('#userupdate-membershipfeemsg').html("");
        $('#userupdate-roleidmsg').html("");

    }
    else {
        //alert("Response error\n" + 
        //        "Status: " + httpReq.status +
        //        "Status Text: " + httpReq.statusText);
    }
}