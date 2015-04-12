package model.build;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import sql.DbConn;
import utils.FormatUtils;

/**
 * This class contains all code that modifies build records in a table in the
 * database.
 */
public class BuildMods {

    private final DbConn dbc;

    public BuildMods(DbConn dbc) {
        this.dbc = dbc;
    }
    
    /**
     * Returns a StringData (build) object if one exists in the database
     * with the given build id. Otherwise an error message will be stored in the 
     * returned StringData object (errorMsg property).
     * 
     * @param dbc the database connection
     * @param buildId the build id
     * @return a StringData (build) object
     */
    public static StringData find(DbConn dbc, String buildId) {
        
        StringData foundUser = new StringData();
        PreparedStatement ps;
        ResultSet rs;
        try {
            String sql = "select build_id, build_name, build_comm, build_img_url, " +
                    "build_cost, timestamp, web_user_id, project_id from build " +
                    "where build_id = ?";
            ps = dbc.getConn().prepareStatement(sql);
            ps.setString(1, buildId);
            rs = ps.executeQuery();
            if (rs.next()) {
                foundUser.setBuildId(rs.getString("build_id"));
                foundUser.setBuildName(rs.getString("build_name"));
                foundUser.setBuildComm(rs.getString("build_comm"));
                foundUser.setBuildImgUrl(rs.getString("build_img_url"));
                foundUser.setBuildCost(FormatUtils.formatDollar(rs.getObject("build_cost")));
                foundUser.setTimestamp(FormatUtils.formatDate(rs.getObject("timestamp")));
                foundUser.setWebUserId(rs.getString("web_user_id"));
                foundUser.setProjectId(rs.getString("project_id"));
            }
            else {
                foundUser.setErrorMsg("BuildMods.find: build_id " + buildId +
                        " was not found");
            }
            rs.close();
            ps.close();
        }
        catch (Exception e) {
            foundUser.setErrorMsg("BuildMods.find: General Exception during " +
                    "find operation: " + e.getMessage());
        }
        
        return foundUser;
    }
    
    /**
     * Deletes a build from the database. Returns an empty string on 
     * success. Otherwise, returns a descriptive error message.
     * 
     * @param buildId 
     * @return empty string on success, otherwise an error message
     */
    public String delete(int buildId) {
        
        String errorMsg = ""; 
        String sql = "DELETE FROM build where build_id=?";
        
        try {
            PreparedStatement ps = dbc.getConn().prepareStatement(sql);
            ps.setInt(1, buildId);

            int numRows = ps.executeUpdate();
            if (numRows != 1) {
                errorMsg = "BuildMods.delete: " + numRows + " records were " +
                            "deleted when only 1 was expected.";
            }
        }
        catch (SQLException e) {
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                errorMsg = "BuildMods.delete: Could not delete.";
            }
            else {
                errorMsg += "BuildMods.delete: SQL Exception while " +
                            "attempting update. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
            }
        }
        catch (Exception e) {
            errorMsg = "BuildMods.delete: General Exception during " +
                        "delete operation. " + e.getMessage();
        }
        
        return errorMsg;
    }
    
}
