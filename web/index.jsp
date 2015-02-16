<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   index.jsp
 Date:   Jan 27, 2015
 Desc:
-->
<jsp:include page="html-to-head.jsp"></jsp:include>
        <title>Home | RasPi Builds</title>
<jsp:include page="head-to-body.jsp"></jsp:include>
            <div class="content">
                <div class="content-text">
                    <a href="#rp-img1-popup" class="rp-img1-popup_open">
                        <img class="raspberrypi-img" src="img/raspberrypi.png" 
                             alt="Raspberry Pi Computer">
                    </a>
                    <h3 id="whatis-raspberrypi-heading">What is the Raspberry Pi?</h3>
                    <p id="whatis-raspberrypi-para"> 
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
                    <div class="newLine"></div>
                        
                    <a href="#rp-img2-popup" class="rp-img2-popup_open">
                    <img class="raspberrypidiagram-img" src="img/raspberrypidiagram.png"
                         alt="Raspberry Pi Diagram">
                    </a>
                    <h3 id="whatis-raspibuilds-heading">What is RasPi Builds?</h3>
                    <p id="whatis-raspibuilds-para"> 
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
                    <div class="newLine"></div>
                    
                <!-- Hidden popups -->
                  
                    <div id="rp-img1-popup" class="well raspi-popup">
                        <p>
                            <img src="img/raspberrypi(full).png" />
                        </p>
                        <button class="rp-img1-popup_close btn btn-default">Close</button>
                    </div>
                    
                    <div id="rp-img2-popup" class="well raspi-popup">
                        <p>
                            <img src="img/raspberrypidiagram(full).png" />
                        </p>
                        <button class="rp-img2-popup_close btn btn-default">Close</button>
                    </div>
                    
                </div>
<jsp:include page="body-to-html.jsp"></jsp:include>
