package languagelessons

class MultipleChoiceQuestion extends Question{
    String[] answers;
    int correctAnswer;
    static constraints = {
    }
    boolean grade(String answer) {
        return Integer.parseInt(answer) == correctAnswer;
    }
}
