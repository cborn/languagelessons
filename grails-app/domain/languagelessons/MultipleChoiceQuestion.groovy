package languagelessons

class MultipleChoiceQuestion extends Question{
    String[] answers;
    boolean[] correctAnswers;
    boolean requiresReview = false;
    static String view = "multipleChoice";
    static String buildView = "buildMultipleChoice"
    static String displayName = "Multiple Choice";
    static def resultType = MultipleChoiceResult;
    static Closure<Question> construct = {params ->
        int pointValue = Integer.parseInt(params.pointVal);
        Question q = new MultipleChoiceQuestion(answers: params.answers, 
                                                correctAnswers: params.corrects,
                                                question: params.question,
                                                pointValue: pointValue)
        return q
    }
    Question fromDraft() {
        Question copy = new MultipleChoiceQuestion(
            answers: answers,
            correctAnswers: correctAnswers,
            question: question,
            pointValue: pointValue,
        )
        copy.isDraft = false;
        copy.oldId = id;
        return copy;
    }
    static constraints = {
        oldId nullable: true
    }
    boolean grade(String answer) {
        return correctAnswers[Integer.parseInt(answer)];
    }
}
