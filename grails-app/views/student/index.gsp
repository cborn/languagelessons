<!doctype html>
<html lang="en" class="no-js">
    <head>
        <g:set var="config" bean="configurationService"/>
        <meta name="layout" content="main" />
        <title>LL - Student Homepage</title>
        <script><g:tabSave /></script>
        <style>
        
        .new a { 

            color: green !important;
        }

        .new.active a{


            border-color: green !important;
            border-bottom-color: transparent !important;
        }

        .new a:before {
               font-size: 9px;
    content: "NEW";
    position: absolute;
    top: 4px;
    right: 2px;
    color: #921F1F;
        }
        
        
        
        </style>
    </head>
    <body>
        <div class="col-xs-12 text-center">
            <h1>Applicant: ${studentInfo.firstName} ${studentInfo.surname}  -<br/> LL ID: (${userInfo.id})</h1>
        </div>
        <ul id="myTabs" class="nav nav-tabs">
            <li class="nav active">
                <a class="ll-home-tab" href="#overview" data-toggle="tab">
                    <span class="glyphicon glyphicon-home" aria-hidden="true"></span> 
                    Home
                </a>
            </li>
            <li class="nav">
                <a href="#information" data-toggle="tab">
                    Your Information
                </a>
            </li>
            <li class="nav">
                <a id="applicationsTab" href="#applications" data-toggle="tab">
                    Applications
                </a>
            </li>
            <g:if test="${hasAcceptedApplications}">
                <li class="nav">
                    <a id="paymentsTab" href="#payments" data-toggle="tab">
                        Payments
                    </a>
                </li>
                <li class="nav">
                    <a href="#forms" data-toggle="tab">
                        Forms
                    </a>
                </li>
            </g:if>
            <li class="nav">
                <a id="coursesTab" href="#courses" data-toggle="tab">
                    Courses
                </a>
            </li>    
        </ul>
        <div class="tab-content">
            <%-- OVERVIEW --%>
            <div class="tab-pane fade in active" id="overview">
                <g:if test="${flash.message}">
                <%-- display an info message to confirm --%>
                    <div class="col-xs-12 text-center">
                        <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            ${raw(flash.message)}
                        </div>
                    </div>
                </g:if>
                <br />
                
                <div class="col-md-10">
                    <div class="col-md-12">
                        <p>Hello ${studentInfo.firstName},</p>
                        <p>Welcome to the LL Applicant Homepage. Below you will see the applications for the courses you applied to. It will also contain status updates about the applications and payments as they are processed.</p>
                        <p>If you have any questions, please contact the LL at <a href=***">****</a> or call us at ****.</p>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="col-md-12">
                        <g:form name="accountSettingsForm" controller="user">
                            <div class="row form-group">
                                <g:hiddenField name="id" value="${userInfo.id}" />
                                <g:actionSubmit class="btn btn-default btn-block submit-button-green pull-right" name="accountSettings" value="Account Settings" action="edit" />
                            </div>
                        </g:form>
                        <g:form name="logoutForm" controller="logout">
                            <div class="row form-group">
                                <g:actionSubmit class="btn btn-default btn-block submit-button-green pull-right" name="logout" value="Log Out" action="index" />
                            </div>
                        </g:form>
                    </div>
                </div>
                <div class="col-md-12" style="padding-top: 20px">
                    <div class="col-md-4">
                        <div class="panel panel-green-border admin-panel">
                            <div class="panel-body text-center">
                                <h4>Your Information:</h4>
                                <h3> <span class="glyphicon glyphicon-user" aria-hidden="true"></span></h3>
                                <g:link controller="student" action="edit">
                                    <h4>View & Edit</h4>
                                </g:link>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="panel panel-green-border admin-panel">
                            <div class="panel-body text-center">
                                <h4>Your Applications:</h4>
                                <h3>
                                    <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
                                </h3>
                                <a data-tab-destination="applicationsTab">
                                    <h4>View & Edit</h4>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="panel panel-green-border admin-panel">
                            <div class="panel-body text-center">
                                <h4>Your Courses:</h4>
                                <h3>
                                    <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
                                </h3>
                                <a data-tab-destination="coursesTab">
                                    <h4>View</h4>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="panel panel-green-border admin-panel">
                            <div class="panel-body text-center">
                                <h4>Make an Application</h4>
                                <br />
                                <g:link controller="GenericApplication" action="index"
                                    class="btn btn-lg submit-button-green">Apply Now</g:link>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                $("a[data-tab-destination]").on('click', function() {
                    var tab = $(this).attr('data-tab-destination');
                    $("#"+tab).click();
                });
                </script>
                <%-- INFORMATION --%>
            <div class="tab-pane fade" id="information">
                <br />
                <div class="col-md-12">
                    <h3>Your Information</h3>
                    <div class="panel panel-green-border">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="col-md-12">
                                        <dl class="dl-horizontal applicant-info-wide">
                                            <dt>Full Name</dt>
                                            <g:if test="${studentInfo.middleName}">
                                                <dd>
                                                    ${studentInfo.firstName + " " + studentInfo.middleName +" " + studentInfo.surname}
                                                </dd>
                                            </g:if>
                                            <g:else>
                                                <dd>
                                                    ${studentInfo.firstName + " " + studentInfo.surname}
                                                </dd>
                                            </g:else>
                                        </dl>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="col-md-12">
                                        <dl class="dl-horizontal applicant-info">
                                            <dt>University</dt>
                                            <dd>
                                                ${studentInfo.institution}
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <g:form name="goToInfo">
                                        <g:actionSubmit
                                            class="btn btn-default pull-right submit-button-green"
                                            name="editApplicant" value="Edit Your Information" action="edit" />
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- APPLICATIONS --%>
            <div class="tab-pane fade" id="applications">
                <br />
                <div class="col-md-12">
                    <h3>Your Courses</h3>
                    <div class="panel panel-green-border">
                        <div class="panel-body">
                            <g:if test="${studentInfo.courses.size() == 0}">
                                <p class="text-center">No applications.</p>
                            </g:if>
                            <g:else>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Course Name</th>
                                            <th>Application Date</th>
                                            <th>Rec. Letter</th>
                                            <th class="text-center">Status</th>
                                            <th>Grade</th>
                                            
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="student" in="${GenericApplications}" status="i">
                                            <tr>
                                                <td>
                                                    ${student.course.location.name + " - " +student.course.name}
                                                </td>
                                                <td><g:formatDate format="MMM dd, yyyy"
                                                    date="${student.applicationMade}" /></td>
                                                <td>
                                                        <%-- if the course requires a letter --%> <g:if
                                                    test="${application.course.recommendationRequired}">
                                                    <%-- if letter received --%>
                                                        <g:if test="${application.recommendationReceived}">
                                                            Rec. Letter Received
                                                        </g:if>
                                                                                                        <%-- if letter not received --%>
                                                        <g:else>
                                                            Rec. Letter Not Yet Received
                                                        </g:else>
                                                                                                </g:if> <%-- if the course doesn't require a letter --%> <g:else>
                                                        This course does not require a letter of recommendation
                                                    </g:else>
                                                </td>
                                                <td>
                                                <g:if test="${application.graded}">
                                                    ${application.grade}
                                                </g:if>
                                                <g:else>
                                                   No Grade
                                                </g:else>
                                                
                                                
                                                
                                                </td>
                                                <td><g:form name="editApp"
                                                        controller="GenericApplication">
                                                        <g:hiddenField name="applicationId"
                                                        value="${application.id}" />
                                                        <g:actionSubmit class="btn  submit-button-green btn-block"
                                                            name="editApplication" value="Show" action="edit" />
                                                    </g:form></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                            </g:else>
                            <g:form name="newApplication" controller="GenericApplication">
                                <g:actionSubmit
                                    class="btn btn-default submit-button-green pull-right"
                                    name="newApp" value="New Application" action="index" />
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>
            <%-- COURSES --%>
            <div class="tab-pane fade" id="courses">
                <br />
                <div class="col-md-12">
                    <h3>Your Courses</h3>
                    <div class="panel panel-green-border">
                        <div class="panel-body">
                            <g:each var="course" in="${studentInfo.courses}">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="col-md-12">
                                            <dl class="dl-horizontal course-info-wide">
                                                <dt>Course Name</dt>
                                                <dd>${course.name}</dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="col-md-12">
                                            <dl class="dl-horizontal course-info">
                                                <dt>Faculty</dt>
                                                <g:each var="faculty" in="${course.faculty}">
                                                    <dd>${faculty.getName()}</dd>
                                                </g:each>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="col-md-12">
                                            <g:form name="goToCourse" controller="course" params="[syllabusId: course.syllabusId]">
                                                <g:actionSubmit
                                                    class="btn btn-default pull-right submit-button-green"
                                                    name="viewCourse" value="View Course" action="show" />
                                            </g:form>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>