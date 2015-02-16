/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   raspiscripts.js
 *  Date:   Feb 4, 2015
 *  Desc:   This file contains javascript that is used for various
 *          purposes within the web app.
 */

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


function showCookie(name) {
    var cookieVal = readCookie(name);
    if (cookieVal === null) {
        alert ("No cookie value was stored with name " + name);
    } else {
        alert ("The cookie named " + name + " has value " + cookieVal);
    }
}

/**
 * Calls the neccessary functions for page initialization. Called
 * from the close of every page.
 * @returns {undefined}
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
    
    if (document.title.indexOf("Home ") > -1) {
        document.getElementById("home-tab-connector").className = "";
        initSlideToggleParagraphs();
        initHomePopups();
    }
    else if (document.title.indexOf("Builds ") > -1) {
        document.getElementById("builds-tab-connector").className = "";
    }
    else if (document.title.indexOf("Projects ") > -1) {
        document.getElementById("projects-tab-connector").className = "";
    }
    else if (document.title.indexOf("Users ") > -1) {
        document.getElementById("users-tab-connector").className = "";
    }
    else if (document.title.indexOf("Search ") > -1) {
        document.getElementById("search-tab-connector").className = "";
    }
    else if (document.title.indexOf("Contact ") > -1) {
        document.getElementById("contact-tab-connector").className = "";
    }
    else if (document.title.indexOf("Labs ") > -1) {
        document.getElementById("labs-tab-connector").className = "";
        initLabsPopups();
    }
}

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

function initHomePopups() {
    
    $(document).ready(function() {

        $('#rp-img1-popup').popup();

        $('#rp-img2-popup').popup();
    });
}



function initLabsPopups() {
    
    $(document).ready(function() {

        $('#datamodel-img-popup').popup();

    });
}

