<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"name="layout" content="main"/>
        <title>New Assignment</title>
        <asset:javascript src="ckeditor/ckeditor.js"/>
        <asset:javascript src="application.js"/>
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
            #preview { outline: 2px dashed red; padding: 2em; margin: 2em 0; }
        </style>
    </head>
    <body>
        <!--<g:if test="${faculty}">-->
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Add to Lesson
                    <span class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <li><button class="btn btn-link">please work</button></li>
                    </ul>
                </div>
        <!--</g:if>-->
        ${raw(assignment.html)}
        <g:if test="${student}">
            <button id="submit" class="btn btn-primary">Submit Assignment for Grading</button>
        </g:if>
        <script>
            var valueRegistry = {};
            $( "#submit" ).on("click", processAndSubmit);
            $( ".question" ).each(function( index ) {
                var id = $( this ).attr("id");
                var assignId = ${assignment.id};
                jQuery.ajax({
                    type: "POST", 
                    url: "${createLink(action: 'loadQuestion')}",
                    data: {qid: id, assignId: assignId},
                    success: function (data) {
                        $( "#" + id ).html(data);
                    },
                });
            });
            function processAndSubmit() {
                var out = {};
                $( ".question" ).each(function( index ) {
                    var id = $( this ).attr("id");
                    var val = valueRegistry[id]();
                    out[id] = val;
                });
                var data = {};
                data['assignment'] = ${assignment.id};
                data['contents'] = out;
                jQuery.ajax({
                    type: "POST", 
                    url: "${createLink(action: 'submitAssignment')}",
                    data: {data: JSON.stringify(data)},
                    success: function (data) {
                        window.location.href = "/lesson/viewLesson?syllabusId=${syllabusId}&lessonId=${assignment.lesson.id}";
                    },
                });
            }
        </script>
    </body>
</html>
