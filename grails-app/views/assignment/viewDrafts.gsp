<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>${course.name}</title>
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
                <p>${course.name}<p>
                <g:link controller="course" action="show" params="[syllabusId: course.syllabusId]" class="btn btn-primary">Return to Course</g:link>
                <span id='warning' style="visibility:hidden" class="alert alert-danger">One or more fields is not filled out!</span>
                <div id="drafts">
                    <g:render template="viewDrafts" model="${pageScope.variables}"/>
                </div>
            </div>
        </div>
        <script>
            var warning = document.getElementById("warning");
            warning.style.visibility="visible";
            $( "#warning" ).hide()
            function sendToCalendar(lessonId) {
                var openDateString = "#openDate" + lessonId;
                var dueDateString = "#dueDate" + lessonId;
                var openDate = $( openDateString ).val();
                var dueDate = $( dueDateString ).val();
                var failure = false;
                if (openDate == '') {
                    //no, you can't not give me that
                    oCellString = "#oDateCell" + lessonId;
                    $( oCellString ).addClass('bg-danger');
                    var failure = true;
                    function reset() {
                        $( oCellString ).removeClass('bg-danger');
                    }
                    setTimeout(reset, 5000);
                }
                if (dueDate == '') {
                    //yeah, you gotta put this in too
                    dCellString = "#dDateCell" + lessonId;
                    $( dCellString ).addClass('bg-danger');
                    var failure = true;
                    function reset() {
                        $( dCellString ).removeClass('bg-danger');
                    }
                    setTimeout(reset, 5000);
                }
                if (failure) {
                    $( "#warning" ).show();
                    $( "#warning" ).fadeOut(4000)
                    return;
                }
                jQuery.ajax({
                        type: "POST",
                        url: "${createLink(action: 'pushLesson')}",
                        data: {openDate: openDate, dueDate: dueDate, lessonId: lessonId, syllabusId: ${params.syllabusId}},
                        success: function (data) {
                            $( "#drafts" ).html(data);
                        }
                });
            }
            function destroy(assignId) {
                if (confirm("Are you sure you want to delete this lesson? Your work will be lost forever.")) {
                    jQuery.ajax({
                        type: "POST",
                        url: "${createLink(action: 'deleteAssignment')}",
                        data: {assignId: assignId, syllabusId: ${syllabusId}},
                        success: function (data) {
                            $( "#drafts" ).html(data);
                        }
                    });
                }
            }
            function add(assignId, lessonId) {
                jQuery.ajax({
                    type: "POST",
                    url: "${createLink(action: 'addAssignmentToLesson')}",
                    data: {assignId: assignId, lessonId: lessonId, syllabusId: ${syllabusId}},
                    success: function (data) {
                        $( "#drafts" ).html(data);
                    }
                });
            }
        </script>
    </body>
</html>