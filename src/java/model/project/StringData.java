package model.project;

public class StringData {

    public String projectId = "";
    public String projectName = "";
    public String projectDesc = "";
    public String projectGuide = "";
    public String projectImgUrl = "";
    public String projectCost = "";
    public String recordStatus = "default"; // will be used later when doing ajax

    /**
     * @return the projectId
     */
    public String getProjectId() {
        return projectId;
    }

    /**
     * @param projectId the projectId to set
     */
    public void setWebUserId(String projectId) {
        this.projectId = projectId;
    }
    
    /**
     * @return the projectName
     */
    public String getProjectName() {
        return projectName;
    }

    /**
     * @param projectName the projectName to set
     */
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /**
     * @return the projectDesc
     */
    public String getProjectDesc() {
        return projectDesc;
    }

    /**
     * @param projectDesc the projectDesc to set
     */
    public void setProjectDesc(String projectDesc) {
        this.projectDesc = projectDesc;
    }
    
    /**
     * @return the projectGuide
     */
    public String getProjectGuide() {
        return projectGuide;
    }

    /**
     * @param projectGuide the projectGuide to set
     */
    public void setProjectGuide(String projectGuide) {
        this.projectGuide = projectGuide;
    }
    
    /**
     * @return the projectImgUrl
     */
    public String getProjectImgUrl() {
        return projectImgUrl;
    }
    
    /**
     * @param projectImgUrl the projectImgUrl to set
     */
    public void setProjectImgUrl(String projectImgUrl) {
        this.projectImgUrl = projectImgUrl;
    }    
    
    /**
     * @return the projectCost
     */
    public String getProjectCost() {
        return projectCost;
    }

    /**
     * @param projectCost the projectCost to set
     */
    public void setProjectCost(String projectCost) {
        this.projectCost = projectCost;
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

    @Override
    public String toString() {
        return "projectId[" + valueOrNull(projectId) + "] " +
                "projectName[" + valueOrNull(projectName) + "] " +
                "projectDesc[" + valueOrNull(projectDesc) + "] " +
                "projectGuide[" + valueOrNull(projectGuide) + "] " +
                "projectImgUrl[" + valueOrNull(projectImgUrl) + "] " + 
                "projectCost[" + valueOrNull(projectCost) + "] " +
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
                "projectId: '" + valueOrNull(projectId) + "', " +
                "projectName: '" + valueOrNull(projectName) + "', " +
                "projectDesc: '" + valueOrNull(projectDesc) + "', " +
                "projectGuide: '" + valueOrNull(projectGuide) + "', " +
                "projectImgUrl: '" + valueOrNull(projectImgUrl) + "', " +
                "projectCost: '" + valueOrNull(projectCost) + "', " +
                "recordStatus: '" + valueOrNull(recordStatus) + "' " +
                "})";
    }
}