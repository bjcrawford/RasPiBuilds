/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   WebUserView.java
 *  Date:   Feb 13, 2015
 *  Desc:
 */
package view;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import sql.DbConn;
import utils.FormatUtils;

public class WebUserView {

    /**
     * Returns a string containing the HTML for a table displaying all the
     * records of the web_user table.
     *
     * @param cssClassName the name of a CSS style that will be applied to the
     * HTML table. This style should be defined in the JSP page (header or style
     * sheet referenced by the page).
     * @param dbc an open database connection.
     * @return a string containing the HTML table
     */
    public static String makeTableFromAllUsers(String cssClassName, DbConn dbc) {
        String htmlTable = "";
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            String sql = "select "
                    + "wu.web_user_id, wu.user_email, wu.user_password, "
                    + "wu.membership_fee, wu.user_role_id, wu.birthday, "
                    + "wu.user_name, ur.user_role_id, ur.role_name "
                    + "from "
                    + "web_user as wu "
                    + "inner join "
                    + "user_role as ur "
                    + "on "
                    + "wu.user_role_id = ur.user_role_id "
                    + "order by "
                    + "wu.user_email";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            htmlTable += "<table class='" + cssClassName + "'>\n"
                    + "\t\t\t\t\t\t\t<tr>"
                    + "<th style='text-align:left'>User Email</th>"
                    + "<th style='text-align:left'>User Name</th>"
                    + "<th style='text-align:left'>User Password</th>"
                    + "<th style='text-align:right'>Membership Fee</th>"
                    + "<th style='text-align:left'>User Role</th>"
                    + "<th style='text-align:center'>Birthday</th>"
                    + "</tr>";
            while (results.next()) {
                htmlTable += "\t\t\t\t\t\t\t<tr>"
                        + FormatUtils.formatStringTd(results.getObject("user_email"))
                        + FormatUtils.formatStringTd(results.getObject("user_name"))
                        + FormatUtils.formatStringTd(results.getObject("user_password"))
                        + FormatUtils.formatDollarTd(results.getObject("membership_fee"))
                        + FormatUtils.formatStringTd(results.getObject("role_name"))
                        + FormatUtils.formatDateTd(results.getObject("birthday"))
                        + "</tr>\n";
            }
            htmlTable += "\t\t\t\t\t\t</table>";
            results.close();
            stmt.close();
            return htmlTable;
        } catch (Exception e) {
            return "Exception thrown in WebUserView.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlTable;
        }
    }
}
