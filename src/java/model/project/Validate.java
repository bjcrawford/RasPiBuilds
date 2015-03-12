package model.project;

import utils.*;  

/* This class validates a Project object (bundle of pre-validated user entered string values)
 * and saves the validated data into a TypedData object (bundle of typed data values).
 * This class provides one error message per field in a Project object.
 * This class demonstrates the use of "object composition" and
 * "Single Responsibility" software design principles.
 */
public class Validate { 

    // validation error messages, one per field to be validated
    private String projectNameMsg = "";
    private String projectDescMsg = "";
    private String projectGuideMsg = "";
    private String projectImgUrlMsg = "";
    private String projectCostMsg = "";
    
    private boolean isValidated = false; // true iff all fields validate ok.
    private String debugMsg = "";
    
    // Web User data fields from form (all String, pre-validation), bundled in this object
    private StringData projectStringData = new StringData();
    
    // Web User data fields after validation (various data types), bundled into this object
    private TypedData projectTypedData = new TypedData();
    
    // default constructor is good for first rendering 
    //   -- all error messages are set to "" (empty string).
    public Validate() {
    }

    public Validate(StringData projectStringData) {
        // validationUtils method validates each user input (String even if destined for other type) from WebUser object
        // side effect of validationUtils method puts validated, converted typed value into TypedData object
        this.projectStringData = projectStringData;

        // this is not needed for insert, but will be needed for update.
        if (projectStringData.projectId != null && projectStringData.projectId.length() != 0) {
            ValidateInteger vi = new ValidateInteger(projectStringData.projectId, true);
            projectTypedData.setProjectId(vi.getConvertedInteger());
        }

        ValidateString vstr = new ValidateString(projectStringData.projectName, 60, true);
        projectTypedData.setProjectName(vstr.getConvertedString());
        this.projectNameMsg = vstr.getError();

        vstr = new ValidateString(projectStringData.projectDesc, 16000000, true);
        projectTypedData.setProjectDesc(vstr.getConvertedString());
        this.projectDescMsg = vstr.getError();
        
        vstr = new ValidateString(projectStringData.projectGuide, 16000000, true);
        projectTypedData.setProjectGuide(vstr.getConvertedString());
        this.projectGuideMsg = vstr.getError();
        
        // TODO: Change to validate URL
        vstr = new ValidateString(projectStringData.projectImgUrl, 255, false);
        projectTypedData.setProjectImgUrl(vstr.getConvertedString());
        this.projectImgUrlMsg = vstr.getError();

        ValidateDecimal vdec = new ValidateDecimal(projectStringData.projectCost, false);
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

    public String getDebugMsg() {
        return this.debugMsg;
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