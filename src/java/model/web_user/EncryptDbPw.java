/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   EncryptDbPw.java
 *  Date:   Mar 25, 2015
 *  Desc:
 */
package model.web_user;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import sql.DbConn;
import encryption.Encryption;

/**
 *
 * @author Brett Crawford <brett.crawford@temple.edu>
 */
public class EncryptDbPw {
    
    public static String EncryptPws(DbConn dbc) {
        PreparedStatement psSelect = null;
        ResultSet rsSelect = null;
        String textOrErrorMsg = "";
        try {
            String sqlSelect = "select web_user_id, user_password from web_user";
            psSelect = dbc.getConn().prepareStatement(sqlSelect);
            rsSelect = psSelect.executeQuery();
            while (rsSelect.next()) {
                String plaintext = rsSelect.getString("user_password");
                if (plaintext != null) {
                    String enctext = Encryption.encryptPw(plaintext);
                    String wuId = rsSelect.getString("web_user_id");
                    textOrErrorMsg += "User Id: " + wuId + 
                            ", User PW: " + plaintext + 
                            ", User Encrypted PW: " + enctext + "<br/>";
                    String sqlUpdate = "update web_user set user_password_encr='" +
                            enctext + "' where web_user_id='" + wuId + "'";
                    PreparedStatement psUpdate = dbc.getConn().prepareStatement(sqlUpdate);
                    psUpdate.executeUpdate();
                    psUpdate.close();
                }
            }
            rsSelect.close();
            psSelect.close();
            dbc.close();
        }
        catch (Exception e) {
            textOrErrorMsg = "Error: " + e.getMessage();
            e.printStackTrace();
        }
        
        return textOrErrorMsg;
    }
}
