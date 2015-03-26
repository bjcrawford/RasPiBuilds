<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   labs.jsp
 Date:   Jan 28, 2015
 Desc:
-->
<jsp:include page="pre-content.jsp"></jsp:include>
            <div class="content">
                <div id="page" class="labs" display="none"></div>
                <div class="content-text">
                    <h2>Lab 01 Project Proposal<a id="lab01"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Proposal Document:</b>
                            <a href="doc/Crawford,Brett-ProjectProposal.doc">
                                Crawford,Brett-ProjectProposal.doc
                            </a>
                            <br/>
                        </p>
                    </div>
                    <h2>Lab 02 Data Model<a id="lab02"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Data Model:</b>
                            <a href="#datamodel-img-popup" class="datamodel-img-popup_open">
                                Crawford,Brett-DataModel.png
                            </a>
                            <br/>
                        </p>
                    </div>
                    <h2>Lab 03 Home Page<a id="lab03"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Home Page:</b>
                            <a href="index.jsp">
                                My Homepage
                            </a>
                            <br/>
                        </p>
                    </div>
                    <h2>Lab 04 Forms Javascript Cookies<a id="lab04"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Contact Page:</b>
                            <a href="contact.jsp">
                                Contact Us
                            </a>
                            <br/>
                            <b>Theme Chooser:</b> Any page, bottom-left in content, theme dropdown
                            <br/>
                            <b>jQuery Slide Toggle: </b>
                            <a href="index.jsp">My Homepage</a>, click headings
                        </p>
                    </div>
                    <h2>Lab 05 Display Data<a id="lab05"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Associative Page:</b>
                            <a href="assoc.jsp">
                                Builds
                            </a>
                            <br/>
                            <b>Other Page:</b>
                            <a href="other.jsp">
                                Projects
                            </a>
                            <br/>
                            <b>Web User Page:</b>
                            <a href="users.jsp">
                                Users
                            </a>
                        </p>
                    </div>
                    <h2>Lab 06 Search<a id="lab06"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Search Page:</b>
                            <a href="search.jsp">
                                Search
                            </a>
                            <br/>
                        </p>
                    </div>
                    <h2>Lab 07 Insert<a id="lab07"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Insert Web User:</b>
                            <a href="insertUser.jsp">
                                User Registration
                            </a>
                            <br/>
                            <b>Insert Project:</b>
                            <a href="insertOther.jsp">Submit a Project</a>,
                            Added a 
                            <a href="http://www.scriptiny.com/2010/02/javascript-wysiwyg-editor/">
                                WYSIWYG Editor
                            </a> 
                            to the Submit a Project page.
                            <br/>
                        </p>
                    </div>
                    <h2>Lab 08 Log On<a id="lab08"></a></h2>
                    <div class="indented-para">
                        <p>
                            <b>Sign In/Sign Off:</b> Any page (in the pre-content file). After 
                            successful or unsuccessful sign in, users are redirected to
                            the index page.
                            <br/>
                            <b>Members Only:</b>
                            <a href="membersOnly.jsp">Members Only</a>,
                            You must be signed in to view this page. If not sign in, the
                            user is redirected to the 
                            <a href="deny.jsp">
                                Deny
                            </a>
                            page.
                            <br/>
                            <b>Encrypted Passwords:</b>
                            <a href="users.jsp">Users</a>,
                            A new column has been added to store the encrypted passwords.
                            When a new user is added, the plaintext (for the sake of testing
                            and grading) is stored in addition to the encrypted value.
                            The sign on functionality encrypts the plaintext and compares
                            against the encrypted values in the database.
                            <br/>
                        </p>
                    </div>
                    <h2>Lab 09 Insert Associative<a id="lab09"></a></h2>
                    <h2>Lab 10 Update Ajax<a id="lab10"></a></h2>
                    <h2>Challenge<a id="challenge"></a></h2>
                    <div class="indented-para">
                        <p>
                            CSS Navigation Tab Dropdown: Any page, hover over labs navigation tab
                            <br/>
                            HTML5 Canvas Animation: Any page, click the raspberry image next to the title to begin
                            <br/>
                        </p>
                    </div>
                    
                    <!-- Hidden popups -->
                  
                    <div id="datamodel-img-popup" class="well raspi-popup">
                        <p>
                            <img src="img/Crawford,Brett-DataModel.png" />
                        </p>
                        <button type="button" class="datamodel-img-popup_close btn btn-default btn-sm close-btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </div>
                    
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
            