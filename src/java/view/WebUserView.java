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
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select "
                    + "wu.web_user_id, wu.user_email, wu.user_password, wu.user_password_encr, "
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
            ps = dbc.getConn().prepareStatement(sql);
            rs = ps.executeQuery();
            htmlTable += "<table class='" + cssClassName + "'>\n"
                    + "\t\t\t\t\t\t\t<tr>"
                    + "<th style='text-align:center'>Edit</th>"
                    + "<th style='text-align:center'>User Email</th>"
                    + "<th style='text-align:center'>User Name</th>"
                    + "<th style='text-align:center'>User Pw</th>"
                    + "<th style='text-align:center'>Fee</th>"
                    + "<th style='text-align:center'>User Role</th>"
                    + "<th style='text-align:center'>Birthday</th>"
                    + "<th style='text-align:center'>Delete</th>"
                    + "</tr>\n";
            while (rs.next()) {
                htmlTable += "\t\t\t\t\t\t\t<tr>"
                        + "<td style='text-align:center; vertical-align: middle;'>"
                        + "<a href=\"#userupdate-popup\" class=\"userupdate-popup_open\" "
                        + "onclick=\"requestUpdateUserInfoById("
                        + rs.getString("web_user_id") + ")\">"
                        + "<button type=\"button\" class=\"btn btn-default\">"
                        + "  <span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>"
                        + "</button>"
                        + "</a></td>"
                        + FormatUtils.formatStringTd(rs.getObject("user_email"))
                        + FormatUtils.formatStringTd(rs.getObject("user_name"))
                        + FormatUtils.formatStringTd(rs.getObject("user_password"))
                        + FormatUtils.formatDollarTd(rs.getObject("membership_fee"))
                        + FormatUtils.formatStringTd(rs.getObject("role_name"))
                        + FormatUtils.formatDateTd(rs.getObject("birthday"))
                        + "<td style='text-align:center; vertical-align: middle;'>"
                        + "<a href=\"#userdelete-popup\" class=\"userdelete-popup_open\" "
                        + "onclick=\"requestDeleteUserInfoById("
                        + rs.getString("web_user_id") + ")\">"
                        + "<button type=\"button\" class=\"btn btn-default\">"
                        + "  <span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>"
                        + "</button>"
                        + "</a></td>"
                        + "</tr>\n";
            }
            htmlTable += "\t\t\t\t\t\t</table>";
            rs.close();
            ps.close();
            return htmlTable;
        } catch (Exception e) {
            return "Exception thrown in WebUserView.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlTable;
        }
    }
    
    /**
     * Returns a string containing the HTML for a select dropdown displaying all
     * the user roles from the user role table. The corresponding user role id's
     * of the user roles will be used for the values of the select options.
     *
     * @param cssClassName the name of a CSS style that will be applied to the
     * HTML select. This style should be defined in the JSP page (header or style
     * sheet referenced by the page).
     * @param dbc an open database connection.
     * @param selectedId the id of the user role that should appear as selected.
     * @return a string containing the HTML select
     */
    public static String makeSelectFromUserRoles(String cssClassName, DbConn dbc, int selectedId) {
        String htmlSelect = "";
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select user_role_id, role_name from user_role";
        try {
            ps = dbc.getConn().prepareStatement(sql);
            rs = ps.executeQuery();
            htmlSelect += "<select name=\"userRoleId\" "
                    + "id=\"selectUserRoleId\" "
                    + "class=\"" + cssClassName + "\">\n";
            while (rs.next()) {
                int userRoleId = rs.getInt("user_role_id");
                htmlSelect += "\t\t\t\t\t\t\t\t<option value=\"" + userRoleId + "\"";
                    if (userRoleId == selectedId) {
                        htmlSelect += " selected ";
                    }
                htmlSelect += ">"
                        + FormatUtils.formatString(rs.getObject("role_name"))
                        + "</option>\n";
            }
            htmlSelect += "\t\t\t\t\t\t\t</select>";
            ps.close();
            rs.close();

            return htmlSelect;
        } catch (Exception e) {
            return "Exception thrown in WebUserView.makeSelectFromUserRoles(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlSelect;
        }
    }
}
