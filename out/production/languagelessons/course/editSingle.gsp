<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
         <g:set var="config" bean="configurationService"/>
        <meta name="layout" content="main"/>
        <title>LL - Course Edit</title>
        <script><g:tabSave /></script>
    </head>
    <body>
        <div class="col-md-12 text-center">
            <h1>${course.getCourseName()} <br/><small>(${course.syllabusId})</small></h1>
            <g:if test="${course.isArchived}">
                <h4 class="text-center text-danger">This course has been archived</h4>
            </g:if>
        </div>
        <g:form name="courseEditForm" action="processEditCourse">
            <g:hiddenField name="id" value="${course.id}" />
            <ul class="nav nav-tabs">
                <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
                <li class="nav active"><a href="#content" data-toggle="tab">Course</a></li>
                <li class="nav"><a href="#content2" data-toggle="tab">Faculty</a></li>
                <li class="nav"><a href="#content3" data-toggle="tab">Lessons</a></li>
                <li class="nav"><a class="ll-save-tab"><span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span> <g:actionSubmit class="btn-masking-as-tab" name="editCourse" value="Save Changes" action="processEditCourse" onclick="return confirm('Are you sure?')" /></a></li>
                <%-- SPLIT --%>
                <li class="nav pull-right"><a class="ll-save-tab" href="${createLink(controller:"course", action:"editAll")}"><span class="glyphicon glyphicon-book" aria-hidden="true"></span> All Courses</a></li>
            </ul>
            <div class="tab-content">
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
<%-- HOME --%>
<%-- CONTENT --%>
                <div class="tab-pane fade in active" id="content">
                    <br />
                    <div class="col-md-12">
                        <h3>Course Information</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <div class="col-xs-4">
                                    <label for="name">Name</label>
                                    <div id="name">
                                        <div class="form-group">
                                            <g:textField class="form-control required" name="courseName" placeholder="Name" value="${course.name}" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12"></div><%-- SPACER --%>
                                <%--<div class="col-xs-12">
                                    <label for="description">Description</label>
                                    <div id="description">
                                        <div class="form-group">
                                            <g:textArea class="form-control required" name="courseDescription" placeholder="Describe the course briefly; this will be seen by prospective applicants browsing courses on the main site." value="${course.description}" rows="3" />
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="col-xs-6">
                                    <label for="type">Moodle ID</label><label class="check-group pull-right"><g:checkBox name='generateNewSyllabusId' /> Tick to Automatically Generate New ID</label>
                                    <div id="type">
                                        <div class="form-group">
                                            <g:textField class="form-control required" name="courseSyllabusId" placeholder="For connection to Moodle, edit with caution" value="${course.syllabusId}" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label for="cap">Applicant Cap</label>
                                    <div id="cap">
                                        <div class="form-group">
                                            <g:textField class="form-control required digits" name="courseCap" value="${course.applicantCap}" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12"></div><%-- SPACER --%>
                                <div class="col-xs-3">
                                    <label for="startDate">Start Date</label>
                                    <div id="startDate">
                                        <g:if test="${course.startDate}">
                                            <div class="form-group">
                                                <div class='input-group date' id='datetimepicker1'>
                                                    <input type='text' class="form-control required date" name="courseStartDate" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <g:hiddenField name="start" value="${course.startDate}" />
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#datetimepicker1').datetimepicker({
                                                        defaultDate: moment(document.getElementById("start").value),
                                                        viewMode: 'years',
                                                        format: 'L'
                                                    });
                                                });
                                            </script>
                                        </g:if>
                                        <g:else> 
                                            <div class="form-group">
                                                <div class='input-group date' id='datetimepicker1'>
                                                    <input type='text' class="form-control required date" name="courseStartDate" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#datetimepicker1').datetimepicker({
                                                        viewMode: 'years',
                                                        format: 'L',
                                                        minDate: moment()
                                                    });
                                                });
                                            </script>
                                        </g:else>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <label for="endDate">End Date</label>
                                    <div id="endDate">
                                        <g:if test="${course.endDate}">
                                            <div class="form-group">
                                                <div class='input-group date' id='datetimepicker2'>
                                                    <input type='text' class="form-control required date" name="courseEndDate" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <g:hiddenField name="end" value="${course.endDate}" />
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#datetimepicker2').datetimepicker({
                                                        defaultDate: moment(document.getElementById("end").value),
                                                        viewMode: 'years',
                                                        format: 'L'
                                                    });
                                                });
                                            </script>
                                        </g:if>
                                        <g:else> 
                                            <div class="form-group">
                                                <div class='input-group date' id='datetimepicker2'>
                                                    <input type='text' class="form-control required date" name="courseEndDate" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#datetimepicker2').datetimepicker({
                                                        viewMode: 'years',
                                                        format: 'L',
                                                        minDate: moment()
                                                    });
                                                });
                                            </script>
                                        </g:else>
                                    </div>
                                </div>
                                
                                <div class="col-md-12 site-separator-outer">
                                    <hr class="site-separator">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade in" id="content2">
                    <br />
                    <div class="col-md-12">
                        <h3>Faculty</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <div class="col-xs-12">
                                    <label for="f">Which manager members would you like to add to this course? (Scroll down for more)</label>
                                    <div id="f">
                                        <div class="form-group">
                                            <g:select class="form-control" id="faculty" name="facultySelect" from="${facultyList}" value="${course.faculty}" multiple="true" optionKey="id" optionValue="${{it.title + " " + it.firstName + " " + it.surname}}" aria-describedby="helpBlock" />
                                            <script>
                                           
                                               $("#faculty").multiSelect();
                                           
                                           
                                           </script>
                                            
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade in" id="content3">
                    <br />
                    <div class="col-md-12">
                        <h3>Lessons</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <div class="col-xs-12">
                                    <label for="q">Which Lesson would you like to add to this course? (Scroll down for more)</label>
                                    <div id="q">
                                        <div class="form-group">
                                            <g:select id="lessons" name="lessonSelect" from="${lessonList}"  value="${course.lessons}" multiple="true" optionKey="id" optionValue="lesson" aria-describedby="helpBlock" />
                                           <script>
                                           
                                               $("#lesson").multiSelect();
                                           
                                           
                                           </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </g:form>
    </body>
</html>