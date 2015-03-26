package model.web_user;

import sql.PrepStatement;
import sql.DbConn;
import java.sql.*;
import encryption.Encryption;

/**
 * This class contains all code that modifies records in a table in the
 * database.
 */
public class WebUserMods {

    private final DbConn dbc;
    private String errorMsg = "";
    private String debugMsg = "";

    public WebUserMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    /**
     * Inserts a validated web user into the database. Returns an empty
     * string on success. Otherwise, returns a descriptive error message.
     * 
     * @param wuValidate the web user validated object
     * @return empty string on success, otherwise an error message
     */
    public String insert(Validate wuValidate) {

        this.errorMsg = "";
        this.debugMsg = "";

        if (!wuValidate.isValidated()) {
            this.errorMsg = "Cannot insert due to validation errors. " +
                    "Please try again.";
            return this.errorMsg;
        }

        TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
        String sql = "INSERT INTO web_user (user_email, user_password, user_password_encr, " +
                "user_name, birthday, membership_fee, user_role_id) " +
                "VALUES (?,?,?,?,?,?,?)";
        try {
            PrepStatement pStat = new PrepStatement(dbc, sql);   
            pStat.setString     (1, wuTypedData.getUserEmail());
            pStat.setString     (2, wuTypedData.getUserPw());
            pStat.setString     (3, Encryption.encryptPw(wuTypedData.getUserPw()));
            pStat.setString     (4, wuTypedData.getUserName());
            pStat.setDate       (5, wuTypedData.getBirthday());
            pStat.setBigDecimal (6, wuTypedData.getMembershipFee());
            pStat.setInt        (7, wuTypedData.getUserRoleId());
            this.errorMsg = pStat.getAllErrors();
            if (this.errorMsg.length() != 0) {
                return this.errorMsg;
            }

            try {
                int numRows = pStat.getPreparedStatement().executeUpdate();
                if (numRows == 1) {
                    return "";
                } else {
                    this.errorMsg = "Error: " + Integer.toString(numRows) +
                            " records were inserted where only 1 expected.";
                    return this.errorMsg;
                }
            }
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    this.errorMsg = "Cannot insert: a record with that ID " +
                            "already exists.";
                } else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot insert: a record with that email " +
                            "address already exists.";
                } else if (e.getMessage().toLowerCase().contains("foreign key")) {
                    this.errorMsg = "Cannot insert: user role does not exist.";
                } else {
                    this.errorMsg = "WebUserMods.insert: SQL Exception while " +
                            "attempting insert. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
                }
                return this.errorMsg;
            }
            catch (Exception e) {
                this.errorMsg = "WebUserMods.insert: General Error while " +
                        "attempting the insert. " + e.getMessage();
                return this.errorMsg;
            }
        }
        catch (Exception e) {
            this.errorMsg = "WebUserMods.insert: General Error while trying to " +
                    "prepare the SQL INSERT statement. " + e.getMessage();
            return this.errorMsg;
        }
    }
    
    /**
     * Returns a StringData (web_user) object if one exists in the database
     * with the given email address and password. Otherwise, null is returned.
     * If an exception is thrown, the error message will be stored in the 
     * returned StringData object (errorMsg property). This method encrypts
     * the plaintext password received and compares it against the encrypted
     * password stored in the web user table of the database.
     * 
     * @param dbc the database connection
     * @param userEmail the user email address
     * @param userPassword the user password
     * @return a StringData (web_user) object if found, otherwise null
     */
    public static StringData find(DbConn dbc, String userEmail, String userPassword) {
        StringData foundCust = new StringData();
        
        String userPasswordEncr = Encryption.encryptPw(userPassword);

        PreparedStatement stmt;
        ResultSet results;
        try {
            String sql = "select web_user_id, user_email, user_name, " +
                    "birthday, membership_fee, user_role_id from web_user " +
                    "where user_email = ? and user_password_encr = ?";

            stmt = dbc.getConn().prepareStatement(sql);
            stmt.setString(1, userEmail);
            stmt.setString(2, userPasswordEncr);

            results = stmt.executeQuery();

            if (results.next()) {
                foundCust.webUserId = results.getString("web_user_id");
                foundCust.userEmail = results.getString("user_email");
                foundCust.userName = results.getString("user_name");
                foundCust.birthday = results.getString("birthday");
                foundCust.membershipFee = results.getString("membership_fee");
                foundCust.userRoleId = results.getString("user_role_id");
                results.close();
                stmt.close();
                return foundCust;
            } 
            else {
                return null;
            }
        } catch (Exception e) {
            foundCust.errorMsg = "Exception thrown in " +
                    "modelCustomer.DbAccess.find(): " + e.getMessage();
            return foundCust;
        }
    }
    
    // a method to find a web user by web user id (instead of by email/pwd)
    
    // a method to insert a web user record
    
    // a method to delete a web user record
    
    // a method to update a web user record
}
