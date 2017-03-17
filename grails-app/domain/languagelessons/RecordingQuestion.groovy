package languagelessons

import java.sql.Blob;

class RecordingQuestion extends Question{
    
    // String[] answers;
    Blob audioAnswer;
    String audioType;
    
    static constraints = {
        audioAnswer nullable:true
    }
}
