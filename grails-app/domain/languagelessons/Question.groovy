package languagelessons

abstract class Question {
    /*All questions should extend the question abstract class. When creating a new class,
     * ensure that you have defined the values view and name in the class. In addition, add
     * the question class name to the list of question subtypes in this class.
     * 
     * ******The following are for every member of the class and should be defined by your new class******
     * view: the .gsp view that should be used for the question, stored in assignment/question
     * displayName: the type of the question that should be used for display when creating questions
     *       **THIS IS SOMETHING THE USER WILL SEE, NOT FOR SYNTAX**
     *       
     * buildView: the .gsp view that should be used for creating the question, stored in assignment/question.
     * After the form that allows the user to create the question, call the function
     * createQuestion() on the pertinent data (stored in a single javascript object) in your javascript. Make sure
     * your javascript object includes the attribute type, which should be the same name
     * as the view of your class so that the code can find your class.
     * 
     * ******The following are for specific instances of the class and should be defined by instances of your class******
     * pointValue: points that the question is worth
     * question: string that should be displayed before the question
     * 
     * ******The following are methods that your class should define******
     * construct(): the params that you pass into createQuestion() in the javascript of your
     * buildView gsp file will be passed in turn to the construct() static method of your class.
     * This should return a new question based on the parameters passed into it
     * 
     * fromDraft(): This is the method that will be called when a lesson is being pushed
     * to the calendar from the drafts section. Your fromDraft() method should duplicate
     * the question and all the relevant parameters, as well as set isDraft to false and oldId
     * to the id of the question it is being copied from
     * 
     * For a useful example of how all of this is structured, look at the files for
     * the MultipleChoiceQuestion
     * */
    int pointValue;
    int oldId;
    String question;
    abstract Question fromDraft();
    static String view;
    static String displayName;
    static String buildView;
    static Closure<Question> construct;
    int questionNum;
    static def subtypes = [RecordingQuestion, MultipleChoiceQuestion]
    boolean archived = false;
    boolean isDraft = true;
    boolean requiresReview;
    static belongsTo = Assignment;
    
    static constraints = {
        oldId nullable: true
        question maxSize: 5000
        archived nullable: true
        requiresReview nullable: true
    }
}
