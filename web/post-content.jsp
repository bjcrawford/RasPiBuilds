<%--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   post-content.jsp
 Date:   Jan 28, 2015
 Desc:   This file contains boiler plate html code for the web
         app pages. This file begins inside the content div and
         finishes with an html close tag.
--%>
<%
    String strUserEmail = "";
    if (request.getParameter("signin-email") != null) { 
        strUserEmail = request.getParameter("signin-email");
    }
%>
 
                <!-- Hidden popups -->
                
                <div id="signin-popup" class="well raspi-popup">
                    <h3>Sign in to your account</h3>
                    <form method="post" action="index.jsp">
                        <table>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                            <input type="email" class="form-control" name="signin-email" id="signin-email" placeholder="Email address" value="<%=strUserEmail%>">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon glyphicon glyphicon-lock" aria-hidden="true"></span>
                                            <input type="password" class="form-control" name="signin-pw" id="signin-pw" placeholder="Password">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <button type="submit" class="btn btn-success">Sign in</button>
                        <button type="button" class="signin-popup_close btn btn-default btn-sm close-btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
                <hr/>
                <span class="theme-chooser">
                    Theme: 
                    <select name="theme-select" id="theme-select" 
                            onchange="javascript:changeStylesheet(this.value)">
                        <option value="choose" disabled>&lt; Choose a theme &gt;</option>
                        <option value="css/default.css">Default</option>
                        <option value="css/inversion.css">Inversion</option>
                        <option value="css/minimal.css">Minimal</option>
                        <option value="clear">Clear stored theme</option>
                    </select>
                </span>
            </div>
            <div class="footer">
                <span class="footer-text">Web Site Design by <a href="http://www.brettjcrawford.com">Brett Crawford</a></span>
            </div>
            <div class="deadspace"></div>
        </div>
        <script>initPage();</script>
    </body>
</html>