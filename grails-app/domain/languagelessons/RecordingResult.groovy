package languagelessons
import java.util.Base64
class RecordingResult extends QuestionResult{
    def getAnswer() {
        return "data:audio/wav;base64," + audioAnswer.encodeBase64()
    }
    def putAnswer(answer) {
        audioAnswer = answer.replaceAll("data:audio/wav;base64,", "").decodeBase64();
    }
    static constraints = {
    }
}
