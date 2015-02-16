/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   ProjectView.java
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
public class ProjectView {
    
    /**
     * Returns a string containing the HTML for a table displaying 
     * all the records of the build table.
     * 
     * @param className the name of a CSS style that will be 
     * applied to the HTML table. This style should be defined 
     * in the JSP page(header or style sheet referenced by the 
     * page).
     * @param dbc an open database connection.
     * @return a string containing the HTML table
     */
    public static String listAllProjects(String className, DbConn dbc) {
        String htmlTable = "";
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
             String sql = "select "
                          + "project_id, project_name, project_desc, "
                          + "project_guide, project_img_url, project_cost "
                        + "from "
                          + "project "
                        + "order by "
                          + "project_name";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            htmlTable += "<table class='" + className + "'>"
                         + "<tr>"
                           + "<th style='text-align:left'>Project Name</th>"
                           + "<th style='text-align:left'>Project Description</th>"
                           + "<th style='text-align:left'>Project Guidelines</th>"
                           + "<th style='text-align:center'>Project Image URL</th>"
                           + "<th style='text-align:right'>Project Cost</th>"
                         + "</tr>";
            while (results.next()) {
                htmlTable += "<tr>"
                             + FormatUtils.formatStringTd(results.getObject("project_name"))
                             + FormatUtils.formatStringTd(results.getObject("project_desc"))
                             + FormatUtils.formatStringTd(results.getObject("project_guide"))
                             + FormatUtils.formatURLtoLinkTd(results.getObject("project_img_url"), "Image")
                             + FormatUtils.formatDollarTd(results.getObject("project_cost"))
                           + "</tr>\n";
            }
            htmlTable += "</table>";
            results.close();
            stmt.close();
            return htmlTable;
        } catch (Exception e) {
            return "Exception thrown in ProjectView.listAllProjects(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + htmlTable;
        }
    }
}
