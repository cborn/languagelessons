package languagelessons
import java.util.Base64
class RecordingResult extends QuestionResult{
    boolean asyncUpload = true;
    def getAnswer() {
        return "data:audio/mp3;base64," + audioAnswer.encodeBase64()
    }
    def putAnswer(answer) {
        audioAnswer = answer.replaceAll("data:audio/mp3;base64,", "").decodeBase64();
    }
    static constraints = {
    }
}
