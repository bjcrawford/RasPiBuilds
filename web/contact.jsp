<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   contact.jsp
 Date:   Jan 28, 2015
 Desc:
-->
<jsp:include page="html-to-head.jsp"></jsp:include>
<title>Contact | RasPi Builds</title>
<jsp:include page="head-to-body.jsp"></jsp:include>  
    <script>document.getElementById("contact-tab-connector").className = "";</script>
    <div class="content">
        <div class="content-text">
            <h2>Contact Us</h2>
            <p>
                Please use the form below to contact us with any suggestions, 
                questions, comments, or concerns.
            </p>
            
            <form name="contact" method="post" action="http://www.temple.edu/cgi-bin/mail?tuf00901@temple.edu">
                <table>
                    <tr>
                        <td>Your name: </td>
                        <td><input type="text" name="name" /></td>
                    </tr>
                    <tr>
                        <td>Your email: </td>
                        <td><input type="text" name="email" /></td>
                    </tr>
                    <tr>
                        <td>Registered user: </td>
                        <td><input id="registereduser" type="checkbox" name="registereduser" onclick="displayButtons()" /></td>
                        
                    </tr>
                    <tr>
                        <td>User Type: </td>
                        <td>
                            <input id="usertype1" type="radio" name="usertype" value="P" disabled="true" />Project Admin
                            <input id="usertype2" type="radio" name="usertype" value="B" disabled="true" />Builder
                            <input id="usertype3" type="radio" name="usertype" value="V" disabled="true" />View Only
                        </td>
                    </tr>
                    <tr>
                        <td>Subject: </td>
                        <td>
                            <select name="subject">
                                <option value="RaspiBuilds-No Subject">&lt; Choose One &gt;</option>
                                <option value="RaspiBuilds-Suggestion">Suggestion</option>
                                <option value="RaspiBuilds-Question">Question</option>
                                <option value="RaspiBuilds-Comment">Comment</option>
                                <option value="RaspiBuilds-Concern">Concern</option>
                                <option value="RaspiBuilds-Project Idea">Project Idea</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Body: </td>
                        <td>
                            <textarea name="body" cols="45" rows="5"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Submit"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
<jsp:include page="body-to-html.jsp"></jsp:include>
            