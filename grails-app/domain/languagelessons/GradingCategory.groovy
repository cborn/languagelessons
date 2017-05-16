package languagelessons

class GradingCategory {

    String name;
    // The weight will be saved as a decimal instead of percentage
    int weight;
    
    static belongsTo = [course: Course]
    static hasMany = [assignment: Assignment]
    
    static constraints = {
    }
}
