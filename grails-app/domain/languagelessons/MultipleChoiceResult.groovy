package languagelessons

class MultipleChoiceResult extends QuestionResult {
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
