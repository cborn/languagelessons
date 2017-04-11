package languagelessons

class RecordingController {

    def index() { }

    def test() {
        Assignment assignment = Assignment.findByAssignmentId(params.assignId)
//        Set<Question> questions = assignment.getQuestions()
//        Question question
//        for(Question q : questions) {
//            if(q.getQuestionNum() == params.questionNum) question = q
//        }
//        if(question != null && question instanceof RecordingQuestion) {
//            ((RecordingQuestion)question).setAudioAnswer(params.audio)
//        }else {
//            // error checking??
//        }
//        question.save()
        render params.audio
    }
}
