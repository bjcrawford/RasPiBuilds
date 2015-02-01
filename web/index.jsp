<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   index.jsp
 Date:   Jan 27, 2015
 Desc:
-->
<jsp:include page="html-to-head.jsp"></jsp:include>
<title>Home | RasPi Builds</title>
<jsp:include page="head-to-body.jsp"></jsp:include>
<script>document.getElementById("home-tab-connector").className = "";</script>
<div class="content">
    <div class="content-text">
        <p> 
            <img class="raspberrypi-img" src="img/raspberrypi.jpg" 
                 alt="Raspberry Pi Computer">
            The <a href="http://www.raspberrypi.org" target="_blank">
            Raspberry Pi</a> is a relatively cheap, wallet-sized computer 
            that makes a great base for all kinds of DIY and maker type 
            projects. The Pi can be connected to a monitor, keyboard, and 
            mouse to be used just like a normal computer, but can function 
            on its own (after being given a little code) with only a cell 
            phone sized power supply. Its USB ports and 
            <a href="http://www.raspberrypi.org/documentation/usage/gpio/" target="_blank">
            general purpose input/output</a> pins allow for a wide variety 
            of components to be connected to the Raspberry Pi and a vast 
            collection of programming 
            <a href="http://elinux.org/RPi_Low-level_peripherals" target="_blank">
            libraries</a> exist to allow communication between the Pi and 
            these components.
        </p>
        <p> 
            This site aims to host a collection of Raspberry Pi inspired
            project ideas. Additionally, we would like users to submit 
            their own personal project <a href="assoc.jsp">builds</a> to 
            show off their particular spin on the project or a novel new 
            way of accomplishing a project detail. Generally, 
            <a href="other.jsp">projects</a> will contain a rough
            outline of the project's goals/requirements, supplies list, 
            and approximate cost. Builds, on the other hand, will be 
            submissions from users. Users are encouraged to be as detailed
            as they want with regards the the build submissions. 
        </p>
        <p>
            Project Proposal Document:
            <a href="doc/Crawford,Brett-ProjectProposal.doc">
                Crawford,Brett-ProjectProposal.doc
            </a>
            <br>
            Project Data Model:
            <a href="img/Crawford,Brett-DataModel.png">
                Crawford,Brett-DataModel.png
            </a>
            <br>
        </p>
        <div class="newLine"></div>
    </div>
</div>
<jsp:include page="body-to-html.jsp"></jsp:include>
