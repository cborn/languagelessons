package languagelessons

class RecordingQuestion extends Question{
    
    // String[] answers;
    byte[] audioAnswer;
    String audioType;
    
    static constraints = {
        audioAnswer nullable:true
    }
}
