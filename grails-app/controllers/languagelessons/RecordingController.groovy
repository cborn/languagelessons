package languagelessons

class RecordingController {

    /* TODO: fix hardcoded assignment id (params aren't passed with post request)
     * TODO: get audio to play, not just download
     * TODO: save audio in right place (not in assignment) */

    def index() { }

    def test() {
        Assignment assignment = Assignment.findById(4)
        assignment.setAudio(params.audio.getBytes())
        assignment.save(flush: true, failOnError: true)
        render "audio posted"
    }

    def play() {

    }

    def playAudio() {
        response.outputStream << Assignment.findById(4).getAudio()
        response.outputStream.flush()
    }
}
