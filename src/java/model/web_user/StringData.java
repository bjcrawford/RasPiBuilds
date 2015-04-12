package model.web_user;

public class StringData {

    private String webUserId = "";
    private String userEmail = "";
    private String userPw = "";
    private String userPw2 = "";
    private String userName = "";
    private String birthday = "";
    private String membershipFee = "";
    private String userRoleId = "";
    private String recordStatus = "default"; // will be used later when doing ajax
    private String errorMsg = "";

    /**
     * @return the webUserId
     */
    public String getWebUserId() {
        return webUserId;
    }

    /**
     * @param webUserId the webUserId to set
     */
    public void setWebUserId(String webUserId) {
        this.webUserId = webUserId;
    }
    
    /**
     * @return the userEmail
     */
    public String getUserEmail() {
        return userEmail;
    }

    /**
     * @param userEmail the userEmail to set
     */
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    /**
     * @return the userPassword
     */
    public String getUserPw() {
        return userPw;
    }

    /**
     * @param userPw the userPassword to set
     */
    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }
    
    /**
     * @return the userPw2
     */
    public String getUserPw2() {
        return userPw2;
    }

    /**
     * @param userPw2 the userPw2 to set
     */
    public void setUserPw2(String userPw2) {
        this.userPw2 = userPw2;
    }
    
    /**
     * @return the user name
     */
    public String getUserName() {
        return userName;
    }
    
    /**
     * @param userName the user name to set
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }    
    
    /**
     * @return the dateAdded
     */
    public String getBirthday() {
        return birthday;
    }

    /**
     * @param birthday the birthday to set
     */
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /**
     * @return the membershipFee
     */
    public String getMembershipFee() {
        return membershipFee;
    }

    /**
     * @param membershipFee the membershipFee to set
     */
    public void setMembershipFee(String membershipFee) {
        this.membershipFee = membershipFee;
    }
    
    /**
     * @return the userRoleId
     */
    public String getUserRoleId() {
        return userRoleId;
    }

    /**
     * @param userRoleId the userRoleId to set
     */
    public void setUserRoleId(String userRoleId) {
        this.userRoleId = userRoleId;
    }

    /**
     * @return the recordStatus
     */
    public String getRecordStatus() {
        return recordStatus;
    }

    /**
     * @param recordStatus the recordStatus to set
     */
    public void setRecordStatus(String recordStatus) {
        this.recordStatus = recordStatus;
    }

    /**
     * @return the errorMsg
     */
    public String getErrorMsg() {
        return errorMsg;
    }

    /**
     * @param errorMsg the errorMsg to set
     */
    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    @Override
    public String toString() {
        return "webUserId[" + valueOrNull(webUserId) + "] " +
                "userEmail[" + valueOrNull(userEmail) + "] " +
                "userPw[" + valueOrNull(userPw) + "] " +
                "userPw2[" + valueOrNull(userPw2) + "] " +
                "userName[" + valueOrNull(userName) + "] " + 
                "birthday[" + valueOrNull(birthday) + "] " +
                "membershipFee[" + valueOrNull(membershipFee) + "] " +
                "userRoleId[ " + valueOrNull(userRoleId) + "] " +
                "recordStatus[" + valueOrNull(recordStatus) + "]";
    } // toString()

    private String valueOrNull(String in) {
        if (in == null) {
            return "null";
        }
        return in;
    }

    public String toJSON() {
        return "({ " +
                "webUserId: '" + valueOrNull(webUserId) + "', " +
                "userEmail: '" + valueOrNull(userEmail) + "', " +
                "userPw: '" + valueOrNull(userPw) + "', " +
                "userPw2: '" + valueOrNull(userPw2) + "', " +
                "userName: '" + valueOrNull(userName) + "', " +
                "birthday: '" + valueOrNull(birthday) + "', " +
                "membershipFee: '" + valueOrNull(membershipFee) + "', " +
                "userRoleId: '" + valueOrNull(userRoleId) + "', " +
                "recordStatus: '" + valueOrNull(recordStatus) + "' " +
                "})";
    }
}