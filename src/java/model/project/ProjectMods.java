package model.project;

import sql.PrepStatement;
import sql.DbConn;
import java.sql.*;

/**
 * This class contains all code that modifies records in a table in the
 * database. So, Insert, Update, and Delete code will be in this class
 * (eventually). Right now, it's just doing DELETE.
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
}
