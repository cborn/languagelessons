package languagelessons

class MultipleChoiceResult extends QuestionResult {
    boolean asyncUpload = false;
    def getAnswer() {
        return intAnswer
    }
    def putAnswer(answer) {
        answer = Integer.parseInt(answer)
        intAnswer = answer
    }
    static constraints = {
    }
}
