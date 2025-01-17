package languagelessons

import static java.util.Calendar.*

class Course {
	
    String name;
    String syllabusId;
    String description; 

    Boolean isArchived = false;

    Date startDate;
    Date endDate;

    Integer applicantCap;
	
    static hasMany = [lessons:Lesson,
        // Don't ever use assignments, assignments should be attached to lessons
                        assignments:Assignment,
                        faculty:Faculty,
                        students:Student,
                        category: GradingCategory]
                    
    static belongsTo = [Faculty, Student];
                    
    static constraints = {
            description maxSize: 1000, nullable: true
            lessons nullable: true
            students nullable: true
            assignments nullable: true
            // faculty nullable: true
            syllabusId unique:true
    }
    
    // Easy method to get formatted course names as liked by the customer...
    // Country - Name, Year
    String getCourseName() {
        name + ", " + startDate[Calendar.YEAR]
    }
    
    int getTerm() {
        // calculate the season the course belongs to
        // season goes from 1st October - 30th September

        // set the date as 1st October
        Calendar calendar = new GregorianCalendar();
        calendar.set(Calendar.MONTH, OCTOBER);
        calendar.set(Calendar.DAY_OF_MONTH, 1);

        // get month
        // if month jan-sept, season starts in previous year 
        if(startDate[Calendar.MONTH] <= 8) {
            calendar.set(Calendar.YEAR, startDate[Calendar.YEAR]-1);   // get the previous year
        }
        // if oct-dec, season is current year
        else {
            calendar.set(Calendar.YEAR, startDate[Calendar.YEAR]);   // get the current year
        }

        // extract the date
        int year = calendar.get(Calendar.YEAR);
        
        return year
    }
    
    String getTermFull() {
        // calculate the season the course belongs to
        // season goes from 1st October - 30th September

        // set the date as 1st October
        Calendar calendar = new GregorianCalendar();
        calendar.set(Calendar.MONTH, OCTOBER);
        calendar.set(Calendar.DAY_OF_MONTH, 1);

        // get month
        // if month jan-sept, season starts in previous year 
        if(startDate[Calendar.MONTH] <= 8) {
            calendar.set(Calendar.YEAR, startDate[Calendar.YEAR]-1);   // get the previous year
        }
        // if oct-dec, season is current year
        else {
            calendar.set(Calendar.YEAR, startDate[Calendar.YEAR]);   // get the current year
        }

        // extract the date
        int year = calendar.get(Calendar.YEAR);
        
        return year + "/" + ((year + 1) % 100)
    }
    
    Boolean hasFinished() {
        // is today after the endDate?
        Date rightNow = new Date();
        if(rightNow.after(endDate)) {
            return true;
        }
        else {
            return false;
        }
    }
    String getCapacity() {
        return students.size() + "/" + applicantCap
    }
    
    def getStudentGrade(Student stu) {
        def grade = [0,0]
        for(Lesson l: lessons) {
            for(Assignment a: l.assignments) {
                def result = a.getStudentResults(stu)

                if(result) {

                    grade[0] += result.score
                    grade[1] += (result.maxScore - result.potentialPoints)
                }
            }
        }
        
        return grade
    }
}
