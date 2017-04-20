package languagelessons

import java.sql.Blob;

class RecordingQuestion extends Question{
    
    // String[] answers;
    static String view = "recordingQuestion";
    static String displayName = "Recording";
    static String buildView = "buildRecording";
    boolean requiresReview = true;
    static Question construct(params) {
        //not finalized
    }
    Question fromDraft() {
        //also not finalized
        //quick hack to get bootstrap working
        Question copy = new RecordingQuestion(
            question: question,
            pointValue: pointValue,
            audioType: audioType,
        )
        copy.isDraft = false;
        copy.oldId = id;
        return copy;
    }
    Blob audioAnswer;
    String audioType;
    
    static constraints = {
        audioAnswer nullable:true
    }
}
