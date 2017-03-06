<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>LL - Faculty</title>
    </head>
    <body>
        <div class="col-xs-12 text-center">
            <h1>${thisFaculty.faculty.title + " " + thisFaculty.faculty.firstName + " " + thisFaculty.faculty.surname}</h1>
        </div>
        <ul class="nav nav-tabs">
                <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
                <li class="nav active"><a href="#content" data-toggle="tab">Faculty</a></li>
                <%-- SPLIT --%>
               <sec:access expression="hasRole('ROLE_ADMIN')">
                <li class="nav pull-right"> 
                <a class="ll-save-tab">
                    <form  action='${request.contextPath}/login/impersonate' method='POST'> 
            							<input type='hidden' value="${thisFaculty.username}"  name='username'/> 
            							<input type='submit'class="ll-save-tab" value='Impersonate'/> 
        							</form>
                                                                </a>
                </li>
               
                <li class="nav pull-right"><a class="ll-save-tab" href="${createLink(action:"index")}"><span class="glyphicon glyphicon-education" aria-hidden="true"></span> All Faculty</a></li>
                 </sec:access>
            </ul>
            <div class="tab-content">
<%-- HOME --%>
<%-- CONTENT --%>
                <div class="tab-pane fade in active" id="content">
                    <br />
                    <div class="col-md-12">
                        <h3>Faculty Information</h3>
                        <div class="panel panel-green-border text-center">
                            <div class="panel-body">
                                <div class="col-md-5">
                                    <div class="col-md-6">
                                        <div class="col-md-12">
                                            <label for="facultyUniversity">Email</label>
                                        </div>
                                        <div id="facultyUniversity">
                                             <p class="form-control-static">${thisFaculty.username}</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="col-md-12">
                                            <label for="facultyUniversity">Affiliation</label>
                                        </div>
                                        <div id="facultyUniversity" class="col-md-12">
                                             <p class="form-control-static">${thisFaculty.faculty.university}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <h3>Course Information</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <label for="assignedCourses">The following courses are assigned to ${thisFaculty.faculty.title + " " + thisFaculty.faculty.firstName + " " + thisFaculty.faculty.surname}:</label>
                                    </div>
                                    <div id="assignedCourses" class="col-md-12">
                                        <ul>
                                            <g:each var="course" in="${thisFaculty.faculty.courses}">
                                                <li><g:link controller="course" action="show" id="${course.id}">${course.name} (${course.syllabusId})</g:link></li>
                                            </g:each>
                                        </ul>
                                        <g:unless test="${thisFaculty.faculty.courses}">
                                            <p>No courses assigned</p>
                                        </g:unless>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>