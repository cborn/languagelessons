<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
         <g:set var="config" bean="configurationService"/>
        <meta name="layout" content="main"/>
        <title>IFR - ${config.getInstance().courseName} Edit</title>
        <script><g:tabSave /></script>
    </head>
    <body>
        <g:form action="updateCourses" name="updateCoursesForm">
            <div class="col-md-12 text-center">
                <h1>${title}</h1>
            </div>
            <ul class="nav nav-tabs">
                <li class="nav"><a class="ifr-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
                <li class="nav"><a href="${createLink(action:'index', params:[status:params.status])}">View ${config.getInstance().courseNamePlural}</a></li>
                <li class="nav active"><a href="${createLink(action:'editAll', params:[status:params.status])}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit ${config.getInstance().courseNamePlural}</a></li>
                <li class="nav"><a class="ifr-save-tab"><span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span> <g:submitButton class="btn-masking-as-tab" name="action" value="Save Changes" onclick="return confirm('Are you sure?')" /></a></li>
                <%-- SPLIT --%>
                <g:if test="${params.status == "archive"}">
                    <li class="nav pull-right"><a class="ifr-save-tab" href="${createLink(action:'editAll', params:[status:"all"])}"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Show Non-Archived ${config.getInstance().courseNamePlural}</a></li>
                </g:if>
                <g:else>
                    <li class="nav pull-right"><a class="ifr-save-tab" href="${createLink(action:'editAll', params:[status:"archive"])}"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Show Archived ${config.getInstance().courseNamePlural}</a></li>
                </g:else>
                <li class="nav pull-right"><a class="ifr-save-tab" href="${createLink(controller:"questions", action:"index")}"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> Application Questions</a></li>
            </ul>
            <div class="tab-content">
<%-- HOME --%>
<%-- CONTENT --%>
                <div class="tab-pane fade in active" id="content">
                    <br />
                    <div class="col-md-12 text-center">
                        <h4>You can quickly edit some course settings here, or click the individual course edit button to edit all options for that course.</h4>
                        <g:if test="${flash.message}">
                            <%-- display an info message to confirm --%>
                            <div class="col-xs-12 text-center">
                                <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    ${flash.message}
                                </div>
                            </div>
                        </g:if>
                        <g:if test="${flash.error}">
                            <%-- display an info message to confirm --%>
                            <div class="col-xs-12 text-center">
                                <div class="alert alert-danger alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    ${flash.error}
                                </div>
                            </div>
                        </g:if>
                        <div class="col-md-12">
                            <table class="table table-hover table-bordered">
                                <thead class="th-green">
                                    <tr>
                                        <th class="text-center">Country</th>
                                        <th class="text-center">Name</th>
                                        <th class="text-center">Moodle ID</th>
                                        <th class="text-center">Accepting <br />Applications</th>
                                        <th class="text-center">Applicant Cap</th>
                                        <th class="text-center">Rec. Letter</th>
                                        <th class="text-center">Interview</th>
                                        <th class="text-center">Reference</th>
                                        <th class="text-center">Transcript</th>
                                        <th colspan="4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each var="course" in="${allCourses}" status="i">
                                        <div id="course${i}">
                                            <g:hiddenField name="courses[${i}].id" value="${course.id}"/>
                                            <tr>
                                                <td>${course.location.name}</td>
                                                <td><g:textField class="form-control required" name="courses[${i}].name" value="${course.name}" /></td>
                                                <td><g:textField class="form-control required" name="courses[${i}].syllabusId" value="${course.syllabusId}" /></td>
                                                <td><g:checkBox name="courses[${i}].acceptingApplications" value="${course.acceptingApplications}" /></td>
                                                <td><g:textField class="form-control required digits" name="courses[${i}].applicantCap" value="${course.applicantCap}" /></td>
                                                <td><g:checkBox name="courses[${i}].recommendationRequired" value="${course.recommendationRequired}" /></td>
                                                <td><g:checkBox name="courses[${i}].interviewRequired" value="${course.interviewRequired}" /></td>
                                                <td><g:checkBox name="courses[${i}].referenceRequired" value="${course.referenceRequired}" /></td>
                                                <td><g:checkBox name="courses[${i}].transcriptRequired" value="${course.transcriptRequired}" /></td>
                                                <td><a class="btn btn-default btn-block" href="${createLink(action:'editSingle', id:course.id)}">Edit</a></td>
                                                <td><a class="btn btn-primary btn-block" href="${createLink(action:'create', params:[clone:course.id])}">Clone</a></td>
                                                <td><a class="btn btn-danger btn-block" href="${createLink(action:'delete', id:course.id)}" onclick="return confirm('Are you sure? Warning: this will also delete all applications made to this course.')">Delete</a></td>
                                                <td>
                                                    <g:if test="${course.isArchived == true}">
                                                        <a class="btn btn-default btn-block" href="${createLink(action:'unarchive', id:course.id)}">Unarchive</a>
                                                    </g:if>
                                                    <g:else>
                                                        <a class="btn btn-default btn-block" href="${createLink(action:'archive', id:course.id)}">Archive</a>
                                                    </g:else>
                                                </td>
                                            </tr>
                                        </div>
                                    </g:each>
                                    <g:unless test="${allCourses}">
                                        <tr>
                                            <td colspan="12">No courses found</td>
                                        </tr>
                                    </g:unless>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </g:form>
    </body>
</html>