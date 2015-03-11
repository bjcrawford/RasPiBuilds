/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   SearchView.java
 *  Date:   Feb 21, 2015
 *  Desc:
 */
package view;

import sql.DbConn;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.FormatUtils;

/**
 *
 * @author Brett Crawford <brett.crawford@temple.edu>
 */
public class SearchView {

    /**
     * Returns a string containing the HTML for a select dropdown displaying all
     * the non-blank user names of the web_user table. The corresponding user
     * id's of the user names will be used for the values of the select options.
     *
     * @param cssClassName the name of a CSS style that will be applied to the
     * HTML table. This style should be defined in the JSP page (header or style
     * sheet referenced by the page).
     * @param dbc an open database connection.
     * @param selectedId the id of the user name that should appear as selected.
     * Use -1 for the default selection, all
     * @return a string containing the HTML select
     */
    public static String makeSelectFromUserNames(String cssClassName, DbConn dbc, int selectedId) {
        String htmlSelect = "";
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select web_user_id, user_name from web_user";
        try {
            ps = dbc.getConn().prepareStatement(sql);
            rs = ps.executeQuery();
            htmlSelect += "<select name=\"selectUser\" "
                    + "id=\"selectUser\" "
                    + "class=\"" + cssClassName + "\">\n"
                    + "<option value=\"-1\">&lt; All &gt;</option>\n";
            while (rs.next()) {
                if (!FormatUtils.formatString(rs.getObject("user_name")).equals("")) {
                    int userId = rs.getInt("web_user_id");
                    htmlSelect += "<option value=\"" + userId + "\" ";
                    if (userId == selectedId) {
                        htmlSelect += "selected ";
                    }
                    htmlSelect += ">"
                            + FormatUtils.formatString(rs.getObject("user_name"))
                            + "</option>\n";
                }
            }
            htmlSelect += "</select>\n";
            ps.close();
            rs.close();

            return htmlSelect;
        } catch (Exception e) {
            return "Exception thrown in WebUserView.makeSelectFromUserNames(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlSelect;
        }
    }

    /**
     * Returns a string containing the HTML for a select dropdown displaying all
     * the project names from the project table. The corresponding project id's
     * of the project names will be used for the values of the select options.
     *
     * @param cssClassName the name of a CSS style that will be applied to the
     * HTML table. This style should be defined in the JSP page (header or style
     * sheet referenced by the page).
     * @param dbc an open database connection.
     * @param selectedId the id of the project name that should appear as selected.
     * @return a string containing the HTML select
     */
    public static String makeSelectFromProjectNames(String cssClassName, DbConn dbc, int selectedId) {
        String htmlSelect = "";
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select project_id, project_name from project";
        try {
            ps = dbc.getConn().prepareStatement(sql);
            rs = ps.executeQuery();
            htmlSelect += "<select name=\"selectProject\" "
                    + "id=\"selectProject\" "
                    + "class=\"" + cssClassName + "\">\n"
                    + "<option value=\"-1\">&lt; All &gt;</option>\n";
            while (rs.next()) {
                int projectId = rs.getInt("project_id");
                htmlSelect += "<option value=\"" + projectId + "\" ";
                    if (projectId == selectedId) {
                        htmlSelect += "selected ";
                    }
                htmlSelect += ">"
                        + FormatUtils.formatString(rs.getObject("project_name"))
                        + "</option>\n";
            }
            htmlSelect += "</select>\n";
            ps.close();
            rs.close();

            return htmlSelect;
        } catch (Exception e) {
            return "Exception thrown in ProjectView.makeSelectFromProjectNames(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlSelect;
        }
    }

    public static String makeTableFromSearchCriteria(String cssClassName, DbConn dbc,
            String keyword, int userId, int projectId,
            int minBuildPrice, int maxBuildPrice) {
        String htmlTable = "";
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select "
                + "b.build_name, b.build_comm, "
                + "b.build_img_url, b.build_cost, b.timestamp, "
                + "b.web_user_id, w.user_name, b.project_id, "
                + "p.project_name "
                + "from "
                + "web_user as w "
                + "inner join "
                + "build as b "
                + "on "
                + "b.web_user_id = w.web_user_id "
                + "inner join "
                + "project as p "
                + "on "
                + "b.project_id = p.project_id "
                + "where "
                + "b.web_user_id = w.web_user_id ";
        if (!keyword.equals("")) {
            sql += "and (lower(b.build_name) like ? "
                    + "or lower(b.build_comm) like ? "
                    + "or lower(w.user_name) like ? "
                    + "or lower(p.project_name) like ?) ";
        }
        if (userId >= 0) {
            sql += "and b.web_user_id = ? ";
        }
        if (projectId >= 0) {
            sql += "and b.project_id = ? ";
        }
        if (minBuildPrice >= 0) {
            sql += "and b.build_cost > ? ";
        }
        if (maxBuildPrice >= 0) {
            sql += "and b.build_cost < ? ";
        }
        try {
            ps = dbc.getConn().prepareStatement(sql);
            int bindVariableNum = 1;
            if (!keyword.equals("")) {
                keyword = "%" + keyword.toLowerCase() + "%";
                ps.setString(bindVariableNum++, keyword);
                ps.setString(bindVariableNum++, keyword);
                ps.setString(bindVariableNum++, keyword);
                ps.setString(bindVariableNum++, keyword);
            }
            if (userId >= 0) {
                ps.setInt(bindVariableNum++, userId);
            }
            if (projectId >= 0) {
                ps.setInt(bindVariableNum++, projectId);
            }
            if (minBuildPrice >= 0) {
                ps.setInt(bindVariableNum++, minBuildPrice);
            }
            if (maxBuildPrice >= 0) {
                ps.setInt(bindVariableNum++, maxBuildPrice);
            }
            rs = ps.executeQuery();
            htmlTable += "<table class='" + cssClassName + "'>\n"
                    + "\t\t\t\t\t\t\t<tr>"
                    + "<th style='text-align:left'>Build Name</th>"
                    + "<th style='text-align:left'>Project Name</th>"
                    + "<th style='text-align:left'>Build Comments</th>"
                    + "<th style='text-align:center'>Build Image URL</th>"
                    + "<th style='text-align:right'>Build Cost</th>"
                    + "<th style='text-align:center'>Timestamp</th>"
                    + "<th style='text-align:left'>Web User Name</th>"
                    + "</tr>";
            while (rs.next()) {
                htmlTable += "\t\t\t\t\t\t\t<tr>"
                        + FormatUtils.formatStringTd(rs.getObject("build_name"))
                        + FormatUtils.formatStringTd(rs.getObject("project_name"))
                        + FormatUtils.formatStringTd(rs.getObject("build_comm"))
                        + FormatUtils.formatURLtoLinkTd(rs.getObject("build_img_url"), "Image")
                        + FormatUtils.formatDollarTd(rs.getObject("build_cost"))
                        + FormatUtils.formatTimestampTd(rs.getObject("timestamp"))
                        + FormatUtils.formatStringTd(rs.getObject("user_name"))
                        + "</tr>\n";
            }
            htmlTable += "\t\t\t\t\t\t</table>";
            rs.close();
            ps.close();

            return htmlTable;
        } 
        catch (Exception e) {
            return "Exception thrown in SearchView.makeTableFromSearchCriteria(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlTable;
        }
    }
}
