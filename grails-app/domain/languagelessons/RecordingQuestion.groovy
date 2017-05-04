package languagelessons

class RecordingQuestion extends Question{

    static String view = "recordingQuestion";
    static String displayName = "Recording";
    static String buildView = "buildRecording";
    static def resultType = RecordingResult;
    boolean requiresReview = true;
    static Closure<Question> construct = {params ->
        println(params.pointVal)
        int pointValue = Integer.parseInt(params.pointVal)
        Question q = new RecordingQuestion(question: params.question, pointValue: pointValue)
        return q
    }

    Question fromDraft() {
        //also not finalized
        //quick hack to get bootstrap working
        Question copy = new RecordingQuestion(
            question: question,
            pointValue: pointValue,
        )
        copy.isDraft = false;
        copy.oldId = id;
        return copy;
    }

    boolean grade(String answer) {
        return false;
    }
    static constraints = {
    }
}
