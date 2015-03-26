/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   Encryption.java
 *  Date:   Mar 25, 2015
 *  Desc:
 */
package encryption;

import java.security.MessageDigest;
import sun.misc.BASE64Encoder;

public class Encryption {

    /**
     * Encrypts the given plaintext using a base 64 encryption scheme.
     * @param plaintext The text to encrypt.
     * @return The encrypted text.
     */
  public static String encryptPw(String plaintext) {
    String encryptedOrMsg = "Not Encrypted Yet";
    MessageDigest md = null;
    try {
      md = MessageDigest.getInstance("SHA"); //step 2
      md.update(plaintext.getBytes("UTF-8")); //step 3
    } 
    catch (Exception e) {
      encryptedOrMsg += e.getMessage();
    }

    byte raw[] = md.digest(); //step 4
    encryptedOrMsg = (new BASE64Encoder()).encode(raw); //step 5
    return encryptedOrMsg; //step 6
  }
}
