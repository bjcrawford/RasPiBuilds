package model.web_user;

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
public class WebUserMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public WebUserMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    public String insert(Validate wuValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!wuValidate.isValidated()) {
            this.errorMsg = "Cannot insert due to validation errors. Please try again.";
            return this.errorMsg;
        }

        TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
        String sql = "INSERT INTO web_user (user_email, user_password, user_name, birthday, membership_fee, user_role_id"
                + ") VALUES (?,?,?,?,?,?)";
        try {
            // This is Sally's wrapper class for java.sql.PreparedStatement
            PrepStatement pStat = new PrepStatement(dbc, sql);   
            pStat.setString     (1, wuTypedData.getUserEmail());
            pStat.setString     (2, wuTypedData.getUserPw());
            pStat.setString     (3, wuTypedData.getUserName());
            pStat.setDate       (4, wuTypedData.getBirthday());
            pStat.setBigDecimal (5, wuTypedData.getMembershipFee());
            pStat.setInt        (6, wuTypedData.getUserRoleId());
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
                    this.errorMsg = "Cannot insert: a record with that email address already exists."; // for example a unique key constraint.
                } else if (e.getMessage().toLowerCase().contains("foreign key")) {
                    this.errorMsg = "Cannot insert: user role does not exist."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "WebUserMods.insert: SQL Exception while attempting insert. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            }
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "WebUserMods.insert: General Error while attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            }
        } // trying to prepare the statement
        catch (Exception e) {
            this.errorMsg = "WebUserMods.insert: General Error while trying to prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println("****************** " + this.errorMsg);
            return this.errorMsg;
        }
    }
}
