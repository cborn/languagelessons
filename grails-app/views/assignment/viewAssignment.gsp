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
            canvas { 
		display: inline-block; 
		background: #202020; 
		width: 90%;
		height: 20%;
		box-shadow: 0px 0px 10px blue;
            }
            #controls {
                    display: flex;
                    flex-direction: row;
                    align-items: center;
                    justify-content: space-around;
                    height: 10%;
                    width: 100%;
            }
            #record { height: 10vh; }
            #record.recording { 
                    background: red;
                    background: -webkit-radial-gradient(center, ellipse cover, #ff0000 0%,lightgrey 75%,lightgrey 100%,#7db9e8 100%); 
                    background: -moz-radial-gradient(center, ellipse cover, #ff0000 0%,lightgrey 75%,lightgrey 100%,#7db9e8 100%); 
                    background: radial-gradient(center, ellipse cover, #ff0000 0%,lightgrey 75%,lightgrey 100%,#7db9e8 100%); 
            }
            #save, #save img { height: 10vh; }
            #save { opacity: 0.25;}
            #save[download] { opacity: 1;}
            #viz {
                    height: 60%;
                    width: 100%;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-around;
                    align-items: center;
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
                <p>${course.name}: ${assignment.name}</p>
                <p>Due: <g:formatDate date="${assignment.dueDate}" type="datetime" style="SHORT"/></p>
                ${assignment.introText}
                <br>
                <g:if test="${result != null}">
                    You scored: ${result.score}/${result.maxScore}
                    <g:each in="${assignment.questions.sort{it.questionNum}}" var="question">
                        <g:render template="question/${question.view}" model="${[question: question, answer: result.getAnswer(question.questionNum)]}"/>
                    </g:each>
                </g:if>
                <g:else>
                    <g:form name="assign" action="gradeAssignment">
                        <g:hiddenField name="assignmentId" value="${assignment.id}"/>
                        <g:each in="${assignment.questions.sort{it.questionNum}}" var="question">
                            <g:render template="question/${question.view}" model="${[question: question]}"/>
                        </g:each>
                        <g:actionSubmit value="gradeAssignment"/>
                    </g:form>
                </g:else>
            </div>
        </div>
    </body>
</html>
