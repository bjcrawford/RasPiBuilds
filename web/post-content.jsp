<%--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   post-content.jsp
 Date:   Jan 28, 2015
 Desc:   This file contains boiler plate html code for the web
         app pages. This file begins inside the content div and
         finishes with an html close tag.
--%>
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