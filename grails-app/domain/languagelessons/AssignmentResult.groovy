package languagelessons

class AssignmentResult {
    int studentId
    Map<String, String> results = [:]
    static constraints = {
    }
    def getAnswer(int questNum) {
        assert results[Integer.toString(questNum)] != null
        return results[Integer.toString(questNum)]
    }
}
