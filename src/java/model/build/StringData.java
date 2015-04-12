package model.build;

public class StringData {
    
    private String buildId = "";
    private String buildName = "";
    private String buildComm = "";
    private String buildImgUrl = "";
    private String buildCost = "";
    private String timestamp = "";
    private String webUserId = "";
    private String projectId = "";
    private String recordStatus = "default";
    private String errorMsg = "";

    /**
     * @return the buildId
     */
    public String getBuildId() {
        return buildId;
    }

    /**
     * @param buildId the buildId to set
     */
    public void setBuildId(String buildId) {
        this.buildId = buildId;
    }

    /**
     * @return the buildName
     */
    public String getBuildName() {
        return buildName;
    }

    /**
     * @param buildName the buildName to set
     */
    public void setBuildName(String buildName) {
        this.buildName = buildName;
    }

    /**
     * @return the buildComm
     */
    public String getBuildComm() {
        return buildComm;
    }

    /**
     * @param buildComm the buildComm to set
     */
    public void setBuildComm(String buildComm) {
        this.buildComm = buildComm;
    }

    /**
     * @return the buildImgUrl
     */
    public String getBuildImgUrl() {
        return buildImgUrl;
    }

    /**
     * @param buildImgUrl the buildImgUrl to set
     */
    public void setBuildImgUrl(String buildImgUrl) {
        this.buildImgUrl = buildImgUrl;
    }

    /**
     * @return the buildCost
     */
    public String getBuildCost() {
        return buildCost;
    }

    /**
     * @param buildCost the buildCost to set
     */
    public void setBuildCost(String buildCost) {
        this.buildCost = buildCost;
    }

    /**
     * @return the timestamp
     */
    public String getTimestamp() {
        return timestamp;
    }

    /**
     * @param timestamp the timestamp to set
     */
    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

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
     * @return the projectId
     */
    public String getProjectId() {
        return projectId;
    }

    /**
     * @param projectId the projectId to set
     */
    public void setProjectId(String projectId) {
        this.projectId = projectId;
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
        return "buildId[" + valueOrNull(buildId) + "] " +
                "buildName[" + valueOrNull(buildName) + "] " +
                "buildComm[" + valueOrNull(buildComm) + "] " +
                "buildImgUrl[" + valueOrNull(buildImgUrl) + "] " +
                "buildCost[" + valueOrNull(buildCost) + "] " + 
                "timestamp[" + valueOrNull(timestamp) + "] " +
                "webUserId[" + valueOrNull(webUserId) + "] " +
                "projectId[ " + valueOrNull(projectId) + "] " +
                "recordStatus[" + valueOrNull(recordStatus) + "]";
    }

    private String valueOrNull(String in) {
        if (in == null) {
            return "null";
        }
        return in;
    }

    public String toJSON() {
        return "({ " +
                "buildId: '" + valueOrNull(buildId) + "', " +
                "buildName: '" + valueOrNull(buildName) + "', " +
                "buildComm: '" + valueOrNull(buildComm) + "', " +
                "buildImgUrl: '" + valueOrNull(buildImgUrl) + "', " +
                "buildCost: '" + valueOrNull(buildCost) + "', " +
                "timestamp: '" + valueOrNull(timestamp) + "', " +
                "webUserId: '" + valueOrNull(webUserId) + "', " +
                "projectId: '" + valueOrNull(projectId) + "', " +
                "recordStatus: '" + valueOrNull(recordStatus) + "' " +
                "})";
    }
    
}
