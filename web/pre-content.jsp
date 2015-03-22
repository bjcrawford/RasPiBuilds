<%--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   pre-content.jsp
 Date:   Jan 31, 2015
 Desc:   This file contains the boiler plate html code for the
         web app pages. This file begins with an html open tag
         and finishes inside an opened head tag.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script src="js/raspiscripts.js" type="text/javascript"></script>
        <script src="js/pacman.js" type="text/javascript"></script>
        <script src="js/raspberry.js" type="text/javascript"></script>
        <script src="js/pacmanAnimation.js" type="text/javascript"></script>
        <script src="js/tinyeditor.js" type="text/javascript"></script>
        <title></title>
    </head>   
    <body onLoad="initializeCanvas();">
        <canvas id="pacman-canvas"></canvas>
        <button id="pacman-exit-button">Exit</button>
        <br/>
        <div class="container">
            <div class="header">
                <div class="signin-container">
                    <div class="signin-content">
                        <a href="#signin-popup" class="signin-popup_open">
                            <button type="button" class="btn btn-success btn-lg">Sign In</button>
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