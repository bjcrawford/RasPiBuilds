<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   contact.jsp
 Date:   Jan 28, 2015
 Desc:
-->
<jsp:include page="html-to-head.jsp"></jsp:include>
        <title>Contact | RasPi Builds</title>
<jsp:include page="head-to-body.jsp"></jsp:include>  
            <div class="content">
                <div class="content-text">
                    <h2>Contact Us</h2>
                    <p>
                        Please use the form below to contact us with any suggestions, 
                        questions, comments, or concerns.
                    </p>
                    <form name="contact" method="post" action="http://www.temple.edu/cgi-bin/mail?tuf00901@temple.edu">
                        <div class="form-group">
                            <label for="inputName">Your name:</label>
                            <input class="form-control" type="text" id="inputName" name="name" placeholder="Enter name"/>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail">Your email:</label>
                            <input class="form-control" type="email" id="inputEmail" name="email" placeholder="Enter email"/>
                        </div>
                        <div class="form-group">
                            <label for="registereduser">Registered user:</label>
                            <input id="registereduser" type="checkbox" 
                                   name="registereduser" onclick="displayUserTypeButtons()" /> 
                            <div class="form-group indented-para" id="divUserType" hidden="true">
                                <label>User type:</label>
                                &nbsp;&nbsp;&nbsp;<input id="usertype1" type="radio" name="usertype" value="P" disabled="true" />&nbsp;&nbsp;Project Admin
                                &nbsp;&nbsp;&nbsp;<input id="usertype2" type="radio" name="usertype" value="B" disabled="true" />&nbsp;&nbsp;Builder
                                &nbsp;&nbsp;&nbsp;<input id="usertype3" type="radio" name="usertype" value="V" disabled="true" />&nbsp;&nbsp;View Only
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputSubject">Subject:</label>
                            <select class="form-control" name="subject" id="inputSubject">
                                <option value="RaspiBuilds-No Subject">&lt; Choose One &gt;</option>
                                <option value="RaspiBuilds-Suggestion">Suggestion</option>
                                <option value="RaspiBuilds-Question">Question</option>
                                <option value="RaspiBuilds-Comment">Comment</option>
                                <option value="RaspiBuilds-Concern">Concern</option>
                                <option value="RaspiBuilds-Project Idea">Project Idea</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="inputMessage">Message:</label>
                            <textarea class="form-control" name="message" rows="5" placeholder="Enter message"></textarea>
                        </div>
                        <input type="submit" class="btn btn-default" value="Submit">
                    </form>
                </div>
<jsp:include page="body-to-html.jsp"></jsp:include>
            