/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   BuildView.java
 *  Date:   Feb 13, 2015
 *  Desc:
 */
package view;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import sql.DbConn;
import utils.FormatUtils;

/**
 *
 * @author Brett Crawford <brett.crawford@temple.edu>
 */
public class BuildView {

    /**
     * Returns a string containing the HTML for a table displaying all the
     * records of the build table.
     *
     * @param cssClassName the name of a CSS style that will be applied to the HTML
     * table. This style should be defined in the JSP page (header or style
     * sheet referenced by the page).
     * @param dbc an open database connection.
     * @return a string containing the HTML table
     */
    public static String makeTableFromAllBuilds(String cssClassName, DbConn dbc) {
        String htmlTable = "";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select "
                    + "b.build_id, b.build_name, b.build_comm, "
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
                    + "order by "
                    + "b.build_name";
            ps = dbc.getConn().prepareStatement(sql);
            rs = ps.executeQuery();
            htmlTable += "<table class='" + cssClassName + "'>\n"
                    + "\t\t\t\t\t\t\t<tr>"
                    + "<th style='text-align:center'>Build Name</th>"
                    + "<th style='text-align:center'>Project Name</th>"
                    + "<th style='text-align:center'>Build Comments</th>"
                    + "<th style='text-align:center'>Build Image URL</th>"
                    + "<th style='text-align:center'>Build Cost</th>"
                    + "<th style='text-align:center'>Timestamp</th>"
                    + "<th style='text-align:center'>Web User Name</th>"
                    + "<th style='text-align:center'>Delete</th>"
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
                        + "<td style='text-align:center; vertical-align: middle;'>"
                        + "<a href=\"#builddelete-popup\" class=\"builddelete-popup_open\" "
                        + "onclick=\"requestDeleteBuildInfoById("
                        + rs.getString("build_id") + ")\">"
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
            return "Exception thrown in BuildView.listAllBuilds(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlTable;
        }
    }
}
