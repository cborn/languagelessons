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
        <g:if test="${faculty}">
            <div class="dropdown">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    View Student Results <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <g:each in="${assignment.results}" var="result">
                        <li class="dropdown-item"><button class="btn btn-link" onclick="view(${result.id}, '${result.student.getName()}')">${result.student.getName()}</button></li>
                    </g:each>
                    <li class="divider"></li>
                    <li class="dropdown-item"><button class="btn btn-link" onclick="clearValue()">No Selection</button></li>
                </ul>
            </div>
        </g:if>
        ${raw(assignment.html)}
        <g:if test="${student}">
            <button id="submit" class="btn btn-primary">Submit Assignment for Grading</button>
        </g:if>
        <script>
            var valueRegistry = {};
            var displayRegistry = {};
            var clearRegistry = [];
            var currentResultId = -1;
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
                data['out'] = out;
                console.log(JSON.stringify(data));
                jQuery.ajax({
                    type: "POST", 
                    url: "${createLink(action: 'submitAssignment')}",
                    data: {data: JSON.stringify(data)},
                    success: function (data) {
                        window.location.href = "/lesson/viewLesson?syllabusId=${syllabusId}&lessonId=${assignment.lesson.id}";
                    },
                });
            }
            function view(resultId, name) {
                currentResultId = resultId;
                jQuery.ajax({
                    type: "POST",
                    url: "${createLink(action: 'getResults')}",
                    data: {resultId: resultId},
                    success: function (data) {
                        data = JSON.parse(data);
                        keys = data.keys;
                        values = data.values;
                        var keysLength = keys.length;
                        var key;
                        for (var i = 0; i < keysLength; i++) {
                            key = keys[i];
                            displayRegistry[key](values.answers[key], values.points[key], values.stati[key]);
                        }
                        setSelectedValue(name);
                    },
                });
            }
            function clearValue() {
                setSelectedValue("View Student Results");
                currentResultId = -1;
                clear()
            }
            function clear() {
                for (var i = 0; i < clearRegistry.length; i++) {
                    clearRegistry[i]();
                }
            }
            function setSelectedValue(value) {
                $( '#dropdownMenuButton' ).html(value + "<span class='caret'></span>");
            }
            function changeGrade(id, amount) {
                jQuery.ajax({
                    type: "POST",
                    url: "${createLink(action: 'changeGrade')}",
                    data: {resultId: currentResultId, questionId: id, amount: amount},
                    success: function (data) {
                        clear();
                        data = JSON.parse(data);
                        keys = data.keys;
                        values = data.values;
                        var keysLength = keys.length;
                        var key;
                        for (var i = 0; i < keysLength; i++) {
                            key = keys[i];
                            displayRegistry[key](values.answers[key], values.points[key], values.stati[key]);
                        }
                    },
                });
            }
            function flagForReview(id) {
                jQuery.ajax({
                    type: "POST",
                    url: "${createLink(action: 'flagForReview')}",
                    data: {resultId: currentResultId, questionId: id},
                    success: function (data) {
                        clear();
                        data = JSON.parse(data);
                        keys = data.keys;
                        values = data.values;
                        var keysLength = keys.length;
                        var key;
                        for (var i = 0; i < keysLength; i++) {
                            key = keys[i];
                            displayRegistry[key](values.answers[key], values.points[key], values.stati[key]);
                        }
                    },
                });
            }
        </script>
    </body>
</html>
