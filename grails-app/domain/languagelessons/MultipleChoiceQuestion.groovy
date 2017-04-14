package languagelessons

class MultipleChoiceQuestion extends Question{
    String[] answers;
    boolean[] correctAnswers;
    static String view = "multipleChoice";
    static String buildView = "buildMultipleChoice"
    static String displayName = "Multiple Choice";
    static Question construct(params) {
        Question q = new MultipleChoiceQuestion(answers: params.answers, 
                                                correctAnswers: params.correct,
                                                question: params.question,
                                                pointValue: params.pointValue)
        return q
    }
    static constraints = {
    }
    boolean grade(String answer) {
        return correctAnswers[Integer.parseInt(answer)];
    }
}
