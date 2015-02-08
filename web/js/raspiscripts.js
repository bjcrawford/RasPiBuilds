/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   raspiscripts.js
 *  Date:   Feb 4, 2015
 *  Desc:
 */

/**
 * Enables/disables the user type radio buttons on the contact
 * page depending on the status of the registered user check box.
 */
function displayButtons() {
    if (document.getElementById("registereduser").checked) {
        document.getElementById("usertype1").disabled = false;
        document.getElementById("usertype2").disabled = false;
        document.getElementById("usertype3").disabled = false;
    }
    else {
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
}

