package languagelessons

class ShortAnswerResult extends QuestionResult{
    boolean asyncUpload = false;
    def getAnswer() {
        return stringAnswer
    }
    def putAnswer(answer) {
        stringAnswer = answer
    }
    static constraints = {
    }
}
