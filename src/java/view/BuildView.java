/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   BuildView.java
 *  Date:   Feb 13, 2015
 *  Desc:
 */
package view;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import SQL.DbConn;
import utils.FormatUtils;

/**
 *
 * @author Brett Crawford <brett.crawford@temple.edu>
 */
public class BuildView {
    
    /**
     * Returns a string containing the HTML for a table displaying 
     * all the records of the build table.
     * 
     * @param className the name of a CSS style that will be 
     * applied to the HTML table. This style should be defined 
     * in the JSP page (header or style sheet referenced by the 
     * page).
     * @param dbc an open database connection.
     * @return a string containing the HTML table
     */
    public static String listAllBuilds(String className, DbConn dbc) {
        String htmlTable = "";
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
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
                       + "order by "
                         + "b.build_name";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            htmlTable += "<table class='" + className + "'>"
                         + "<tr>"
                           + "<th style='text-align:left'>Build Name</th>"
                           + "<th style='text-align:left'>Project Name</th>"
                           + "<th style='text-align:left'>Build Comments</th>"
                           + "<th style='text-align:center'>Build Image URL</th>"
                           + "<th style='text-align:right'>Build Cost</th>"
                           + "<th style='text-align:center'>Timestamp</th>"
                           + "<th style='text-align:left'>Web User Name</th>"
                         + "</tr>";
            while (results.next()) {
                htmlTable += "<tr>"
                             + FormatUtils.formatStringTd(results.getObject("build_name"))
                             + FormatUtils.formatStringTd(results.getObject("project_name"))
                             + FormatUtils.formatStringTd(results.getObject("build_comm"))
                             + FormatUtils.formatURLtoLinkTd(results.getObject("build_img_url"), "Image")
                             + FormatUtils.formatDollarTd(results.getObject("build_cost"))
                             + FormatUtils.formatTimestampTd(results.getObject("timestamp"))
                             + FormatUtils.formatStringTd(results.getObject("user_name"))
                           + "</tr>\n";
            }
            htmlTable += "</table>";
            results.close();
            stmt.close();
            return htmlTable;
        } 
        catch (Exception e) {
            return "Exception thrown in BuildView.listAllBuilds(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlTable;
        }
    }
}
