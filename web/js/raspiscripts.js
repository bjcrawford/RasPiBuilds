/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   raspiscripts.js
 *  Date:   Feb 4, 2015
 *  Desc:
 */

window.displayButtons = function() {
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

function changeStylesheet(newHref) {
    document.getElementById("styleID").href = newHref;
}

// NOTE: USE FIREFOX.  DOES NOT WORK IN CHROME.
function createCookie(name, value, days) {
    alert ("Creating a cookie with name " + name + " and value " + value + 
           " that will last " + days + " days");
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
