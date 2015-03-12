package model.project;

/* This class just bundles together all the pre-validated String values that a 
 * user might enter as part of a Web_User record. 
 */
public class TypedData {

    private Integer projectId = null;
    private String projectName = "";
    private String projectDesc = "";
    private String projectGuide = "";
    private String projectImgUrl = "";
    private java.math.BigDecimal projectCost = null;
    
    public String displayHTML() {
        return buildDisplay("<br>");
    }

    public String displayLog() {
        return buildDisplay("\n");
    }

    // pass in "\n" for newline, "<br/>" if to be displayed on jsp page.
    public String buildDisplay(String newLineString) {
        return newLineString +
                "Project record" + newLineString +
                "==============" + newLineString +
                "projectId: " + myToString(this.getProjectId()) + newLineString +
                "projectName: " + myToString(this.getProjectName()) + newLineString +
                "projectDesc: " + myToString(this.getProjectDesc()) + newLineString +
                "projectGuide: " + myToString(this.getProjectGuide()) + newLineString +
                "ProjectImgUrl: " + myToString(this.getProjectImgUrl()) + newLineString +
                "projectCost: " + myToString(this.getProjectCost()) + newLineString;
    }

    private String myToString(Object obj) {
        if (obj == null) {
            return "null";
        } else {
            return obj.toString();
        }
    }
    
    /**
     * @return the projectId
     */
    public Integer getProjectId() {
        return projectId;
    }

    /**
     * @param projectId the projectId to set
     */
    public void setProjectId(Integer projectId) {
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
    public java.math.BigDecimal getProjectCost() {
        return projectCost;
    }

    /**
     * @param projectCost the projectCost to set
     */
    public void setProjectCost(java.math.BigDecimal projectCost) {
        this.projectCost = projectCost;
    }
}