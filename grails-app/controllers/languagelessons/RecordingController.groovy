package languagelessons

class RecordingController {

    def index() { }

    def test() {
        def assignment = Assignment.findById(2)
        System.out.println(assignment)
        System.out.println(params.audio)
        assignment.setAudio(params.audio)
        assignment.save()
        System.out.println(Assignment.findById(2).getAudio())
        render "audio posted"
    }

    def play() {
        // this is null, why??
        System.out.println(Assignment.findById(2).getAudio())
        [audio: Assignment.findById(2).getAudio()]
    }
}
