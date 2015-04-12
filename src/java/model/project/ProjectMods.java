package model.project;

import sql.DbConn;
import java.sql.*;

/**
 * This class contains all code that modifies project records in a table in the
 * database. 
 */
public class ProjectMods {

    private final DbConn dbc;

    public ProjectMods(DbConn dbc) {
        this.dbc = dbc;
    }

    /**
     * Inserts a validated project into the database. Returns an empty
     * string on success. Otherwise, returns a descriptive error message.
     * 
     * @param pValidate the web user validation object
     * @return empty string on success, otherwise an error message
     */
    public String insert(Validate pValidate) {

        String errorMsg = "";

        if (!pValidate.isValidated()) {
            errorMsg = "ProjectMods.insert: Cannot insert due to " +
                    "validation errors. Please try again.";
        }
        else {
            TypedData pTypedData = (TypedData) pValidate.getTypedData();
            String sql = "INSERT INTO project (project_name, project_desc, " + 
                    "project_guide, project_img_url, project_cost) " +
                    "VALUES (?,?,?,?,?)";
            try {
                PreparedStatement ps = dbc.getConn().prepareStatement(sql);   
                ps.setString     (1, pTypedData.getProjectName());
                ps.setString     (2, pTypedData.getProjectDesc());
                ps.setString     (3, pTypedData.getProjectGuide());
                ps.setString     (4, pTypedData.getProjectImgUrl());
                ps.setBigDecimal (5, pTypedData.getProjectCost());
                    
                int numRows = ps.executeUpdate();
                if (numRows != 1) {
                    errorMsg = "ProjectMods.update: " + numRows + " records were " +
                            "updated when only 1 was expected.";
                }
                ps.close();
            }
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    errorMsg = "ProjectMods.insert: a record with that ID " +
                            "already exists.";
                } 
                else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    errorMsg = "ProjectMods.insert: a record with that project " +
                            "name already exists.";
                } 
                else {
                    errorMsg = "ProjectMods.insert: SQL Exception while " +
                            "attempting insert. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
                }
            }
            catch (Exception e) {
                errorMsg = "ProjectMods.insert: General Exception during " +
                            "insert operation: " + e.getMessage();
            }
        }
        
        return errorMsg;
    }   
    
    /**
     * Returns a StringData (project) object if one exists in the database
     * with the given project id. Otherwise, an error message will be stored 
     * in the returned StringData object (errorMsg property).
     * 
     * @param dbc the database connection
     * @param projectId the project id
     * @return a StringData (project) object if found
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
            }
            else {
                foundProject.errorMsg = "ProjectMods.find: project_id " + projectId +
                        " was not found";
            }
                rs.close();
                ps.close();
        } 
        catch (Exception e) {
            foundProject.errorMsg = "ProjectMods.find: General Exception during " +
                        "find operation: " + e.getMessage();
        }
        
        return foundProject;
    }
    
    /**
     * Updates a validated project in the database. Returns an empty
     * string on success. Otherwise, returns a descriptive error message.
     * 
     * @param pValidate the project validated object
     * @return empty string on success, otherwise an error message
     */
    public String update(Validate pValidate) {

        String errorMsg = "";

        if (!pValidate.isValidated()) {
            errorMsg = "ProjectMods.update: Cannot update due to " + 
                    "validation errors. Please try again.";
        }
        else {
            TypedData pTypedData = (TypedData) pValidate.getTypedData();
            String sql = "UPDATE project SET " + 
                    "project_name=?, " + 
                    "project_desc=?, " + 
                    "project_guide=?, " + 
                    "project_img_url=?, " + 
                    "project_cost=? " +
                    "WHERE project_id=?";
            try {
                PreparedStatement ps = dbc.getConn().prepareStatement(sql);   
                ps.setString     (1, pTypedData.getProjectName());
                ps.setString     (2, pTypedData.getProjectDesc());
                ps.setString     (3, pTypedData.getProjectGuide());
                ps.setString     (4, pTypedData.getProjectImgUrl());
                ps.setBigDecimal (5, pTypedData.getProjectCost());
                ps.setInt        (6, pTypedData.getProjectId());

                
                int numRows = ps.executeUpdate();
                if (numRows != 1) {
                    errorMsg = "ProjectMods.update: " + numRows + " records were " +
                            "updated when only 1 was expected.";
                }
                ps.close();
            }
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    errorMsg = "ProjectMods.update: a record with that ID " +
                            "already exists.";
                }
                else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    errorMsg = "ProjectMods.update: a record with that project " + 
                            "name already exists.";
                }
                else {
                    errorMsg = "ProjectMods.update: SQL Exception while " +
                            "attempting update. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
                }
            }
            catch (Exception e) {
                errorMsg = "ProjectMods.update: General Exception during " +
                        "update operation. " + e.getMessage();
            }
        }
        
    return errorMsg;
    }
    
    /**
     * Deletes a project from the database. Returns an empty string on 
     * success. Otherwise, returns a descriptive error message.
     * 
     * @param projectId 
     * @return empty string on success, otherwise an error message
     */
    public String delete(int projectId) {
        
        String errorMsg = ""; 
        String sql = "DELETE FROM project where project_id=?";
        
        try {
            PreparedStatement ps = dbc.getConn().prepareStatement(sql);
            ps.setInt(1, projectId);

            int numRows = ps.executeUpdate();
            if (numRows != 1) {
                errorMsg = "ProjectMods.delete: " + numRows + " records were " +
                            "deleted when only 1 was expected.";
            }
        }
        catch (SQLException e) {
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                errorMsg = "ProjectMods.delete: Could not delete.";
            }
            else {
                errorMsg += "ProjectMods.delete: SQL Exception while " +
                            "attempting update. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
            }
        }
        catch (Exception e) {
            errorMsg = "ProjectMods.delete: General Exception during " +
                        "delete operation. " + e.getMessage();
        }
        
        return errorMsg;
    }
}
