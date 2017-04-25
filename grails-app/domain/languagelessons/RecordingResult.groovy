package languagelessons

class RecordingResult extends QuestionResult{
    def answer
    static constraints = {
        
    }
    static mapping = {
        answer sqlType: 'blob'
    }
}
