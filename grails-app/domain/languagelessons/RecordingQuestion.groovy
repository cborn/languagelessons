package languagelessons

import java.sql.Blob;

class RecordingQuestion extends Question{
    
    // String[] answers;
    static String view = "recordingQuestion";
    static String displayName = "Recording";
    static String buildView = "buildRecording";
    static def resultType = RecordingResult;
    boolean requiresReview = true;
    static Closure<Question> construct = {params ->
        //placeholder
        return new RecordingQuestion();
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
