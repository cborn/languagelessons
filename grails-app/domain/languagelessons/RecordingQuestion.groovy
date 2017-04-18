package languagelessons

import java.sql.Blob;

class RecordingQuestion extends Question{
    
    // String[] answers;
    static String view = "recordingQuestion";
    static String displayName = "Recording";
    static String buildView = "buildRecording";
    static Question construct(params) {
        //not finalized
    }
    Question fromDraft() {
        //also not finalized
    }
    Blob audioAnswer;
    String audioType;
    
    static constraints = {
        audioAnswer nullable:true
    }
}
