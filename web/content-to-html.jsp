<%--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   post-content.jsp
 Date:   Jan 28, 2015
 Desc:
--%>

                <hr>
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
            </div> <!-- Content div close -->
            <div class="footer">
                <span class="footer-text">Web Site Design by Brett Crawford</span>
            </div>
            <div class="deadspace"></div>
        </div> <!-- Container div close -->
    </body>
    <script>
        initPage();
    </script>
</html>