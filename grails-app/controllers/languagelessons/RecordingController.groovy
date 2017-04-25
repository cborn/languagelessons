package languagelessons

class RecordingController {

    def index() { }

    def test() {
        Assignment assignment = Assignment.findById(4)
        System.out.println(assignment)
        System.out.println(params.audio)
        assignment.setAudio(params.audio)
        System.out.println(assignment.save(flush: true, failOnError: true))
        System.out.println(Assignment.findById(4).getAudio())
        render "audio posted"
    }

    def play() {
        // this is null, why??
        System.out.println(Assignment.findById(4))
        System.out.println(Assignment.findById(4).getAudio())
        [audio: Assignment.findById(4).getAudio()]
    }
}
