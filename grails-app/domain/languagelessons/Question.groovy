package languagelessons

abstract class Question {
    /*All questions should extend the question abstract class. When creating a new class,
     * ensure that you have defined the values view and name in the class. In addition, add
     * the question class name to the subtypes array in this class.
     * 
     * ******The following are for every member of the class and should be defined by your new class******
     * view: the .gsp view that should be used for the question, stored in assignment/question
     * displayName: the type of the question that should be used for display when creating questions
     * buildView: the .gsp view that should be used for creating the question, stored in assignment/question
     * 
     * ******The following are for specific instances of the class and should be defined by instances of your class******
     * pointValue: points that the question is worth
     * question: string that should be displayed before the question
     * */
    int pointValue;
    String question;
    static String view;
    static String displayName;
    static String buildView;
    abstract static Question construct(params);
    int questionNum;
    static def subtypes = [RecordingQuestion, MultipleChoiceQuestion]
    Boolean archived = false;
    static belongsTo = Assignment;
    
    static constraints = {
        question maxSize: 5000
        archived nullable: true
    }
}
