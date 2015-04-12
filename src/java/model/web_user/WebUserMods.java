package model.web_user;

import sql.DbConn;
import java.sql.*;
import encryption.Encryption;
import utils.FormatUtils;

/**
 * This class contains all code that modifies web user records in a table in the
 * database.
 */
public class WebUserMods {

    private final DbConn dbc;

    public WebUserMods(DbConn dbc) {
        this.dbc = dbc;
    }

    /**
     * Inserts a validated web user into the database. Returns an empty
     * string on success. Otherwise, returns a descriptive error message.
     * 
     * @param wuValidate the web user validation object
     * @return empty string on success, otherwise an error message
     */
    public String insert(Validate wuValidate) {

        String errorMsg = "";

        if (!wuValidate.isValidated()) {
            errorMsg = "WebUserMods.insert: Cannot insert due to " +
                    "validation errors. Please try again.";
        }
        else {
            TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
            String sql = "INSERT INTO web_user (user_email, user_password, user_password_encr, " +
                    "user_name, birthday, membership_fee, user_role_id) " +
                    "VALUES (?,?,?,?,?,?,?)";
            try {
                PreparedStatement ps = dbc.getConn().prepareStatement(sql);   
                ps.setString     (1, wuTypedData.getUserEmail());
                ps.setString     (2, wuTypedData.getUserPw());
                ps.setString     (3, Encryption.encryptPw(wuTypedData.getUserPw()));
                ps.setString     (4, wuTypedData.getUserName());
                ps.setDate       (5, wuTypedData.getBirthday());
                ps.setBigDecimal (6, wuTypedData.getMembershipFee());
                ps.setInt        (7, wuTypedData.getUserRoleId());

                try {
                    int numRows = ps.executeUpdate();
                    if (numRows != 1) {
                        errorMsg = "WebUserMods.insert: " + Integer.toString(numRows) +
                                " records were inserted when only 1 was expected.";
                    }
                }
                catch (SQLException e) {
                    if (e.getSQLState().equalsIgnoreCase("S1000")) {
                        errorMsg = "WebUserMods.insert: a record with that ID " +
                                "already exists.";
                    } 
                    else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                        errorMsg = "WebUserMods.insert: a record with that email " +
                                "address already exists.";
                    } 
                    else if (e.getMessage().toLowerCase().contains("foreign key")) {
                        errorMsg = "WebUserMods.insert: user role does not exist.";
                    } 
                    else {
                        errorMsg = "WebUserMods.insert: SQL Exception while " +
                                "attempting insert. SQLState:" + e.getSQLState() +
                                ", Error message: " + e.getMessage();
                    }
                }
                ps.close();
            }
            catch (Exception e) {
                errorMsg = "WebUserMods.insert: General Exception during " +
                            "insert operation: " + e.getMessage();
            }
        }
        
        return errorMsg;
    }
    
    /**
     * Returns a StringData (web_user) object if one exists in the database
     * with the given email address and password. Otherwise an error message 
     * will be stored in the returned StringData object (errorMsg property). 
     * This method encrypts the plaintext password received and compares it 
     * against the encrypted password stored in the web user table of the 
     * database.
     * 
     * @param dbc the database connection
     * @param userEmail the user email address
     * @param userPassword the user password
     * @return a StringData (web_user) object if found
     */
    public static StringData find(DbConn dbc, String userEmail, String userPassword) {
        
        StringData foundUser = new StringData();
        String userPasswordEncr = Encryption.encryptPw(userPassword);
        PreparedStatement ps;
        ResultSet rs;
        try {
            String sql = "select web_user_id, user_email, user_name, " +
                    "birthday, membership_fee, user_role_id from web_user " +
                    "where user_email = ? and user_password_encr = ?";
            ps = dbc.getConn().prepareStatement(sql);
            ps.setString(1, userEmail);
            ps.setString(2, userPasswordEncr);
            rs = ps.executeQuery();
            if (rs.next()) {
                foundUser.webUserId = rs.getString("web_user_id");
                foundUser.userEmail = rs.getString("user_email");
                foundUser.userName = rs.getString("user_name");
                foundUser.birthday = rs.getString("birthday");
                foundUser.membershipFee = rs.getString("membership_fee");
                foundUser.userRoleId = rs.getString("user_role_id");
            } 
            else {
                foundUser.errorMsg = "WebUserMods.find: Record not found";
            }
            rs.close();
            ps.close();
        } 
        catch (Exception e) {
            foundUser.errorMsg = "WebUserMods.find: General Exception during " +
                        "find operation: " + e.getMessage();
        }
        
        return foundUser;
    }    
    
    /**
     * Returns a StringData (web_user) object if one exists in the database
     * with the given user id. Otherwise an error message will be stored in the 
     * returned StringData object (errorMsg property).
     * 
     * @param dbc the database connection
     * @param webUserId the user id
     * @return a StringData (web_user) object
     */
    public static StringData find(DbConn dbc, String webUserId) {
        
        StringData foundUser = new StringData();
        PreparedStatement ps;
        ResultSet rs;
        try {
            String sql = "select web_user_id, user_email, user_name, user_password, " +
                    "birthday, membership_fee, user_role_id from web_user " +
                    "where web_user_id = ?";
            ps = dbc.getConn().prepareStatement(sql);
            ps.setString(1, webUserId);
            rs = ps.executeQuery();
            if (rs.next()) {
                foundUser.webUserId = rs.getString("web_user_id");
                foundUser.userEmail = rs.getString("user_email");
                foundUser.userName = rs.getString("user_name");
                foundUser.userPw = rs.getString("user_password");
                foundUser.birthday = FormatUtils.formatDate(rs.getObject("birthday"));
                foundUser.membershipFee = rs.getString("membership_fee");
                foundUser.userRoleId = rs.getString("user_role_id");
            }
            else {
                foundUser.errorMsg = "WebUserMods.find: web_user_id " + webUserId +
                        " was not found";
            }
            rs.close();
            ps.close();
        }
        catch (Exception e) {
            foundUser.errorMsg = "WebUserMods.find: General Exception during " +
                        "find operation: " + e.getMessage();
        }
        
        return foundUser;
    }
    
    /**
     * Updates a validated web user in the database. Returns an empty
     * string on success. Otherwise, returns a descriptive error message.
     * 
     * @param wuValidate the web user validated object
     * @return empty string on success, otherwise an error message
     */
    public String update(Validate wuValidate) {

        String errorMsg = "";

        if (!wuValidate.isValidated()) {
            errorMsg = "WebUserMods.update: Cannot update due to " + 
                    "validation errors. Please try again.";
        }
        else {
            TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
            String sql = "UPDATE web_user SET " + 
                    "user_email=?, " +
                    "user_password=?, " +
                    "user_password_encr=?, " +
                    "user_name=?, " +
                    "birthday=?, " + 
                    "membership_fee=?, " +
                    "user_role_id=? " +
                    "WHERE web_user_id=?";
            try {
                PreparedStatement ps = dbc.getConn().prepareStatement(sql);   
                ps.setString     (1, wuTypedData.getUserEmail());
                ps.setString     (2, wuTypedData.getUserPw());
                ps.setString     (3, Encryption.encryptPw(wuTypedData.getUserPw()));
                ps.setString     (4, wuTypedData.getUserName());
                ps.setDate       (5, wuTypedData.getBirthday());
                ps.setBigDecimal (6, wuTypedData.getMembershipFee());
                ps.setInt        (7, wuTypedData.getUserRoleId());
                ps.setInt        (8, wuTypedData.getWebUserId());

                int numRows = ps.executeUpdate();
                if (numRows != 1) {
                    errorMsg = "WebUserMods.update: " + numRows + " records were " +
                            "updated when only 1 was expected.";
                }
                ps.close();
            }
            catch (SQLException e) {
                if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    errorMsg = "WebUserMods.update: A record with that email " +
                            "address already exists.";
                }
                else if (e.getMessage().toLowerCase().contains("foreign key")) {
                    errorMsg = "WebUserMods.update: User role does not exist.";
                }
                else {
                    errorMsg = "WebUserMods.update: SQL Exception while " +
                            "attempting update. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
                }
            }
            catch (Exception e) {
                errorMsg = "WebUserMods.update: General Exception during " +
                        "update operation. " + e.getMessage();
            }
        }
        
        return errorMsg;
    }
    
    /**
     * Deletes a web user from the database. Returns an empty string on 
     * success. Otherwise, returns a descriptive error message.
     * 
     * @param webUserId 
     * @return empty string on success, otherwise an error message
     */
    public String delete(int webUserId) {
        
        String errorMsg = ""; 
        String sql = "DELETE FROM web_user where web_user_id=?";
        
        try {
            PreparedStatement ps = dbc.getConn().prepareStatement(sql);
            ps.setInt(1, webUserId);

            int numRows = ps.executeUpdate();
            if (numRows != 1) {
                errorMsg = "WebUserMods.delete: " + numRows + " records were " +
                            "deleted when only 1 was expected.";
            }
        }
        catch (SQLException e) {
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                errorMsg = "WebUserMods.delete: Could not delete.";
            }
            else {
                errorMsg += "WebUserMods.delete: SQL Exception while " +
                            "attempting update. SQLState:" + e.getSQLState() +
                            ", Error message: " + e.getMessage();
            }
        }
        catch (Exception e) {
            errorMsg = "WebUserMods.delete: General Exception during " +
                        "delete operation. " + e.getMessage();
        }
        
        return errorMsg;
    }
}
