<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Courses</title>
        <meta name="layout" content="main"/>
        <style type="text/css" media="screen">
            #status {
                background-color: #eee;
                border: .2em solid #fff;
                margin: 2em 2em 1em;
                padding: 1em;
                width: 12em;
                float: left;
                -moz-box-shadow: 0px 0px 1.25em #ccc;
                -webkit-box-shadow: 0px 0px 1.25em #ccc;
                box-shadow: 0px 0px 1.25em #ccc;
                -moz-border-radius: 0.6em;
                -webkit-border-radius: 0.6em;
                border-radius: 0.6em;
            }

            #status ul {
                font-size: 0.9em;
                list-style-type: none;
                margin-bottom: 0.6em;
                padding: 0;
            }

            #status li {
                line-height: 1.3;
            }

            #status h1 {
                text-transform: uppercase;
                font-size: 1.1em;
                margin: 0 0 0.3em;
            }

            #page-body {
                margin: 2em 1em 1.25em 18em;
            }

            h2 {
                margin-top: 1em;
                margin-bottom: 0.3em;
                font-size: 1em;
            }

            p {
                line-height: 1.5;
                margin: 0.25em 0;
            }

            #controller-list ul {
                list-style-position: inside;
            }

            #controller-list li {
                line-height: 1.3;
                list-style-position: inside;
                margin: 0.25em 0;
            }

            @media screen and (max-width: 480px) {
                #status {
                    display: none;
                }

                #page-body {
                    margin: 0 1em 1em;
                }

                #page-body h1 {
                    margin-top: 0;
                }
            }
        </style>
    </head>
    <body>
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
                    <h1>${flash.error}</h1>
                </div>
            </div>
        </g:if>
        <div class="col-xs-12">
            <div class="jumbotron">
                <img src="" class="img-responsive"/>
                <p>Courses</p>
                <p>
                    <table border="1">
            <tr>
                <th>Course Name</th>
                <th>Faculty</th>
                <th>Applicant Cap</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Term</th>
                <th>Capacity</th>
                <g:if test="${student}">
                    <th>Enroll</th>
                </g:if>
            </tr>
            <g:each in="${courses}" var="course">
                <tr>
                    <td>${course.name}</td>
                    <td><g:each in="${course.faculty}"var="faculty">${faculty.getName()}<br> </g:each></td>
                    <td>${course.applicantCap}</td>
                    <td>${course.startDate.getDateString()}</td>
                    <td>${course.endDate.getDateString()}</td>
                    <td>${course.getTermFull()}</td>
                    <td>${course.getCapacity()}</td>
                    <g:if test="${student}">
                        <g:if test="${!course.students.contains(student)}">
                            <td><a href="${createLink(controller: "student", action: "enroll", id: "${course.syllabusId}")}">Enroll</a></td>
                        </g:if>
                        <g:else>
                            <td>Already Enrolled</td>
                        </g:else>
                    </g:if>
                </tr>
            </g:each>
                </p>
            </div>
        </div>
        <!--<p><h2>Courses</h2></p>
        <table border="1">
            <tr>
                <th>Course Name</th>
                <th>Faculty</th>
                <th>Applicant Cap</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Term</th>
                <th>Capacity</th>
                <th>Enroll</th>
            </tr>
            <g:each in="${courses}" var="course">
                <tr>
                    <td>${course.name}</td>
                    <td><g:each in="${course.faculty}"var="faculty">${faculty.getName()}<br> </g:each></td>
                    <td>${course.applicantCap}</td>
                    <td>${course.startDate.getDateString()}</td>
                    <td>${course.endDate.getDateString()}</td>
                    <td>${course.getTermFull()}</td>
                    <td>${course.getCapacity()}</td>
                    <td><a href="${createLink(controller: "student", action: "enroll", id: "${course.syllabusId}")}">Enroll</a></td>
            </g:each>
            <g:if test="${enrollFail}">
                <br> You have already enrolled in this class!
            </g:if>
        </table>
        -->
    </body>
</html>
