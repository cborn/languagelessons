package languagelessons

class RecordingQuestion extends Question{

    static String view = "recordingQuestion";
    static String displayName = "Recording";
    static String buildView = "buildRecording";
    static def resultType = RecordingResult;
    boolean requiresReview = true;
    static Closure<Question> construct = {params ->
        Question q = new RecordingQuestion(question: params.question, pointVal: params.pointValue)
        return q
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

    String audioType;

    static constraints = {
    }
}
