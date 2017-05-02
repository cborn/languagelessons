package languagelessons

class ShortAnswerResult extends QuestionResult{
    def getAnswer() {
        return stringAnswer
    }
    def putAnswer(answer) {
        stringAnswer = answer
    }
    static constraints = {
    }
}
