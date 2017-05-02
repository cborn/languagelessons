package languagelessons

class RecordingResult extends QuestionResult{
    def getAnswer() {
        return audioAnswer
    }
    def putAnswer(answer) {
        
        audioAnswer = answer
    }
    static constraints = {
    }
}
