package model.project;

import sql.PrepStatement;
import sql.DbConn;
import java.sql.*;
import utils.FormatUtils;

/**
 * This class contains all code that modifies project records in a table in the
 * database. 
 *
 * This class requires an open database connection for its constructor method.
 */
public class ProjectMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public ProjectMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    public String insert(Validate pValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!pValidate.isValidated()) {
            this.errorMsg = "Cannot insert due to validation errors. Please try again.";
            return this.errorMsg;
        }

        TypedData pTypedData = (TypedData) pValidate.getTypedData();
        String sql = "INSERT INTO project (project_name, project_desc, project_guide, project_img_url, project_cost"
                + ") VALUES (?,?,?,?,?)";
        try {
            // This is Sally's wrapper class for java.sql.PreparedStatement
            PrepStatement pStat = new PrepStatement(dbc, sql);   
            pStat.setString     (1, pTypedData.getProjectName());
            pStat.setString     (2, pTypedData.getProjectDesc());
            pStat.setString     (3, pTypedData.getProjectGuide());
            pStat.setString     (4, pTypedData.getProjectImgUrl());
            pStat.setBigDecimal (5, pTypedData.getProjectCost());
            this.errorMsg = pStat.getAllErrors();
            if (this.errorMsg.length() != 0) {
                return this.errorMsg;
            }

            //System.out.println("************* got past encoding");
            try {
                // extract the real java.sql.PreparedStatement from Sally's wrapper class.
                int numRows = pStat.getPreparedStatement().executeUpdate();
                if (numRows == 1) {
                    return ""; // all is GOOD, one record inserted is what we expect
                } else {
                    this.errorMsg = "Error: " + Integer.toString(numRows) +
                            " records were inserted where only 1 expected."; // probably never get here, would be bulk sql insert
                    return this.errorMsg;
                }
            }
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    // this error would only be possible for a non-auto-increment primary key.
                    this.errorMsg = "Cannot insert: a record with that ID already exists.";
                } else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot insert: a record with that project name already exists."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "ProjectMods.insert: SQL Exception while attempting insert. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            }
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "ProjectMods.insert: General Error while attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            }
        }
        catch (Exception e) {
            this.errorMsg = "ProjectMods.insert: General Error while trying to prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println("****************** " + this.errorMsg);
            return this.errorMsg;
        }
    }   
    
    /**
     * Returns a StringData (project) object if one exists in the database
     * with the given project id. Otherwise, null is returned.
     * If an exception is thrown, the error message will be stored in the 
     * returned StringData object (errorMsg property).
     * 
     * @param dbc the database connection
     * @param projectId the project id
     * @return a StringData (project) object if found, otherwise null
     */
    public static StringData find(DbConn dbc, String projectId) {
        
        StringData foundProject = new StringData();
        PreparedStatement ps;
        ResultSet rs;
        try {
            String sql = "select project_id, project_name, project_desc, " +
                    "project_guide, project_img_url, project_cost from project " +
                    "where project_id = ?";

            ps = dbc.getConn().prepareStatement(sql);
            ps.setString(1, projectId);

            rs = ps.executeQuery();

            if (rs.next()) {
                foundProject.projectId = rs.getString("project_id");
                foundProject.projectName = rs.getString("project_name");
                foundProject.projectDesc = rs.getString("project_desc");
                foundProject.projectGuide = rs.getString("project_guide");
                foundProject.projectImgUrl = rs.getString("project_img_url");
                foundProject.projectCost = rs.getString("project_cost");
                rs.close();
                ps.close();
                return foundProject;
            } 
            else {
                return null;
            }
        } catch (Exception e) {
            foundProject.errorMsg = "Exception thrown in " +
                    "ProjectsMods.find(DbConn dbc, String projectId): " + e.getMessage();
            return foundProject;
        }
    }
    
    /**
     * Updates a validated project in the database. Returns an empty
     * string on success. Otherwise, returns a descriptive error message.
     * 
     * @param pValidate the project validated object
     * @return empty string on success, otherwise an error message
     */
    public String update(Validate pValidate) {

        this.errorMsg = "";
        this.debugMsg = "";

        if (!pValidate.isValidated()) {
            this.errorMsg = "Cannot update due to validation errors. Please try again.";
            return this.errorMsg;
        }

        TypedData pTypedData = (TypedData) pValidate.getTypedData();
        String sql = "UPDATE project SET " + 
                "project_name=?, " + 
                "project_desc=?, " + 
                "project_guide=?, " + 
                "project_img_url=?, " + 
                "project_cost=? " +
                "WHERE project_id=?";
        try {
            PrepStatement ps = new PrepStatement(dbc, sql);   
            ps.setString     (1, pTypedData.getProjectName());
            ps.setString     (2, pTypedData.getProjectDesc());
            ps.setString     (3, pTypedData.getProjectGuide());
            ps.setString     (4, pTypedData.getProjectImgUrl());
            ps.setBigDecimal (5, pTypedData.getProjectCost());
            ps.setInt        (6, pTypedData.getProjectId());
            this.errorMsg = ps.getAllErrors();
            if (this.errorMsg.length() != 0) {
                return this.errorMsg;
            }

            try {
                int numRows = ps.getPreparedStatement().executeUpdate();
                if (numRows == 1) {
                    return "";
                } 
                else {
                    this.errorMsg = "Error: " + numRows +
                            " records were updated (when only 1 was expected).";
                            
                    return this.errorMsg;
                }
            }
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    this.errorMsg = "Cannot insert: a record with that ID " +
                            "already exists.";
                }
                else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot insert: a record with that project " + 
                            "name already exists.";
                }
                else {
                    this.errorMsg = "ProjectMods.update: SQL Exception while " + 
                            "attempting update. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                }
                return this.errorMsg;
            }
            catch (Exception e) {
                this.errorMsg = "ProjectMods.update: General Error while " +
                        "attempting the insert. " + e.getMessage();
                System.out.println(this.errorMsg);
                return this.errorMsg;
            }
        }
        catch (Exception e) {
            this.errorMsg = "ProjectMods.Update: General Error while trying to " +
                    "prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println(this.errorMsg);
            return this.errorMsg;
        }
    }
}
