package model.project;

import utils.*;  

/* This class validates a Project object (bundle of pre-validated user entered string values)
 * and saves the validated data into a TypedData object (bundle of typed data values).
 * This class provides one error message per field in a Project object.
 * This class demonstrates the use of "object composition" and
 * "Single Responsibility" software design principles.
 */
public class Validate { 

    private String projectNameMsg;
    private String projectDescMsg;
    private String projectGuideMsg;
    private String projectImgUrlMsg;
    private String projectCostMsg;
    
    private boolean isValidated;
    private StringData projectStringData;
    private TypedData projectTypedData;
    
    public Validate() {
        projectNameMsg = "";
        projectDescMsg = "";
        projectGuideMsg = "";
        projectImgUrlMsg = "";
        projectCostMsg = "";  
        isValidated = false;
        projectStringData = new StringData();
        projectTypedData = new TypedData();
    }

    public Validate(StringData projectStringData) {
        
        this.projectStringData = projectStringData;
        projectTypedData = new TypedData();

        if (projectStringData.getProjectId() != null && projectStringData.getProjectId().length() != 0) {
            ValidateInteger vi = new ValidateInteger(projectStringData.getProjectId(), true);
            projectTypedData.setProjectId(vi.getConvertedInteger());
        }

        ValidateString vstr = new ValidateString(projectStringData.getProjectName(), 60, true);
        projectTypedData.setProjectName(vstr.getConvertedString());
        this.projectNameMsg = vstr.getError();

        vstr = new ValidateString(projectStringData.getProjectDesc(), 16000000, true);
        projectTypedData.setProjectDesc(vstr.getConvertedString());
        this.projectDescMsg = vstr.getError();
        
        vstr = new ValidateString(projectStringData.getProjectGuide(), 16000000, true);
        projectTypedData.setProjectGuide(vstr.getConvertedString());
        this.projectGuideMsg = vstr.getError();
        
        // TODO: Change to validate URL
        vstr = new ValidateString(projectStringData.getProjectImgUrl(), 255, false);
        projectTypedData.setProjectImgUrl(vstr.getConvertedString());
        this.projectImgUrlMsg = vstr.getError();

        ValidateDecimal vdec = new ValidateDecimal(projectStringData.getProjectCost(), false);
        projectTypedData.setProjectCost(vdec.getConvertedDecimal());
        this.projectCostMsg = vdec.getError();

        String allMessages = this.projectNameMsg + 
                this.projectDescMsg + 
                this.projectGuideMsg + 
                this.projectImgUrlMsg + 
                this.projectCostMsg;
        
        isValidated = (allMessages.length() == 0);
    }

    public StringData getStringData() {
        return this.projectStringData;
    }

    public TypedData getTypedData() {
        return this.projectTypedData;
    }

    public String getProjectNameMsg() {
        return this.projectNameMsg;
    }
    
    public void setProjectNameMsg(String projectNameMsg) {
        this.projectNameMsg = projectNameMsg;
    }

    public String getProjectDescMsg() {
        return this.projectDescMsg;
    }

    public String getProjectGuideMsg() {
        return this.projectGuideMsg;
    }
    
    public String getProjectImgUrlMsg() {
        return this.projectImgUrlMsg;
    }

    public String getProjectCostMsg() {
        return this.projectCostMsg; 
    }

    public boolean isValidated() { 
        return this.isValidated;
    }

    public String getAllValidationErrors() { 
        String allMessages = "projectName error: " + this.projectNameMsg + ", " +
                "projectDesc error: " + this.projectDescMsg + ", " +
                "projectGuide error: " + this.projectGuideMsg + ", " +
                "projectImgUrl error: " + this.projectImgUrlMsg + ", " +
                "projectCost error: " + this.projectCostMsg;
        
        return allMessages;
    }
}