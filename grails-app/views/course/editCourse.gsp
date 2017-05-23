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
        <g:set var="x" value="100" />
        <g:javascript>
            var rowNum = 1;
            function update() {
                rowNum += 1;
                
                document.getElementById("updatebutton").innerHTML =
                    document.getElementById("courseEditor").innerHTML;
            }
        </g:javascript>
        <div class="col-xs-12">
            <div class="jumbotron">
                <h4>Edit Course: ${course.name}</h4>
                <br/>
                <div class="row">
                    <div class="col-md-6">
                        <p id="updatebutton">${x}</p>
                    </div>
                    <div class="col-md-6">
                        <table id="categoryTable">
                            <thead class="th-green">
                                <tr>
                                    <th class="text-center" rowspan="2">Category Name</th>
                                    <th class="text-center" rowspan="2">Percentage of Grade</th>
                                    <th class="text-center" rowspan="2"></th>
                                </tr>
                            </thead>
                            <tbody class="text-center" id="categoryBody">
                                <g:each var="category" in="${categoryList}">
                                    <g:form name="courseEditor" action="courseEditor">
                                        <tr>
                                            <g:hiddenField name="syllabusId" value="${course.syllabusId}" />
                                            <td><g:textField name="categoryName" style="box-sizing: border-box; width: 100%" /></td>
                                            <td><g:textField name="categoryPercentage" style="box-sizing: border-box; width: 100%" /></td>
                                            <td><g:actionSubmit action="courseEditor" value="Edit" style="box-sizing: border-box; width: 100px" /></td>
                                        </tr>
                                    </g:form>
                                </g:each>
                                <g:form name="courseEditor" action="courseEditor">
                                    <tr>
                                        <g:hiddenField name="syllabusId" value="${course.syllabusId}" />
                                        <td><g:textField name="categoryName" style="box-sizing: border-box; width: 100%" /></td>
                                        <td><g:textField name="categoryPercentage" style="box-sizing: border-box; width: 100%" /></td>
                                        <td><g:actionSubmit action="courseEditor" value="Edit" style="box-sizing: border-box; width: 100px" /></td>
                                    </tr>
                                </g:form>
                                <tr>
                                    <td colspan="3"><button onClick="update()" style="width: 100%">Add a Row!</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
