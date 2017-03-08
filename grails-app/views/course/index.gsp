<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="main"/>
        <style>
             .nav-tabs > li > a {
                    max-width: 160px !important;
                    }
            </style>
        <title>LL - Courses</title>
        <script><g:tabSave /></script>
    </head>
     <body>
        <div class="col-md-12 text-center">
            <h1>${title}</h1>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            <li class="nav active"><a href="#content" data-toggle="tab">Courses</a></li>
            <li class="nav"><a href="${createLink(action:'editAll', params:[status:params.status])}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit Courses</a></li>
            <li class="nav"><a href="${createLink(action:'create')}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add New Course</a></li>
            <%-- SPLIT --%>
            <li class="nav pull-right"><a class="ll-save-tab" href="${createLink(action:'archiveAll', params:[status:params.status])}"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Archive Previous Seasons</a></li>
            <g:if test="${params.status == "archive"}">
                <li class="nav pull-right"><a class="ll-save-tab" href="${createLink(action:'index', params:[status:"all"])}"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Show Non-Archived Courses</a></li>
            </g:if>
            <g:else>
                <li class="nav pull-right"><a class="ll-save-tab" href="${createLink(action:'index', params:[status:"archive"])}"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Show Archived Courses</a></li>
            </g:else>
                <li class="nav pull-right"><a class="ll-save-tab" href="${createLink(controller:"questions", action:"index")}"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> Application Questions</a></li>
        </ul>
        <div class="tab-content">
<%-- HOME --%>
<%-- CONTENT --%>
            <div class="tab-pane fade in active" id="content">
                <br />
                <div class="col-md-12">
                    <g:if test="${flash.message}">
                        <%-- display an info message to confirm --%>
                        <div class="col-xs-12 text-center">
                            <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                ${flash.message}
                            </div>
                        </div>
                    </g:if>
                    <div class="col-xs-12">
                        <table id="sortableTable">
                            <thead class="th-green">
                                <tr>
                                    <th class="text-center" rowspan="2">Name</th>
                                    <g:if test="${params.status == "all"}"><th class="text-center" rowspan="2">Term</th></g:if>
                                    <th class="text-center" rowspan="2">Moodle ID</th>
                                    <th class="text-center" rowspan="2">Director</th>
                                    <th class="text-center {sorter: false}" colspan="2">Date</th>
                                    <th class="text-center" rowspan="2">Student Cap</th>
                                </tr>
                                <tr>
                                    <th class="text-center">Start</th>
                                    <th class="text-center">End</th>
                                </tr>
                            </thead>
                            <tbody class="text-center">
                                <g:each var="course" in="${courseList}" status="i">
                                    <tr>
                                        <td><g:link controller="course" action="show" id="${course.id}">${course.name}</g:link></td>
                                        <g:if test="${params.status == "all"}"><td>${course.getTermFull()}</td></g:if>
                                        <%--<td>${course.type}</td>--%>
                                        <td>${course.syllabusId}</td>
                                        <td>
                                            <g:each var="faculty" in="${course.faculty}">
                                                <p><g:link controller="manager" action="show" id="${faculty.id}">${faculty.firstName[0] + " " + faculty.surname}</g:link></p>
                                            </g:each>
                                            <g:unless test="${course.faculty}">
                                                <p class="form-control-static">Not yet assigned</p>
                                            </g:unless>
                                        </td>
                                        <td><g:formatDate format="MM/dd/yyyy" date="${course.startDate}"/></td>
                                        <td><g:formatDate format="MM/dd/yyyy" date="${course.endDate}"/></td>
                                        <td>${course.applicantCap}</td>

                                    </tr>
                                </g:each>
                                <g:unless test="${courseList}">
                                    <tr>
                                        <td colspan="15">No courses found</td>
                                    </tr>
                                </g:unless>
                            </tbody>
                            <!-- pager --> 
                            <tfoot>
                                <tr>
                                    <g:if test="${params.status == "all"}"><th colspan="15" class="ts-pager form-horizontal"></g:if>
                                    <g:else><th colspan="14" class="ts-pager form-horizontal"></g:else>
                                        <div class="col-md-4">
                                            <button type="button" class="btn first"><i class="icon-step-backward glyphicon glyphicon-step-backward"></i></button>
                                            <button type="button" class="btn prev"><i class="icon-arrow-left glyphicon glyphicon-backward"></i></button>
                                            <span class="pagedisplay"></span> <!-- this can be any element, including an input -->
                                            <button type="button" class="btn next"><i class="icon-arrow-right glyphicon glyphicon-forward"></i></button>
                                            <button type="button" class="btn last"><i class="icon-step-forward glyphicon glyphicon-step-forward"></i></button>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="col-md-8">
                                                <p class="form-control-static">Results per page:</p>
                                            </div>
                                            <div class="col-md-4">
                                                <select class="pagesize input-mini form-control" title="Select page size">
                                                    <option selected="selected" value="10">10</option>
                                                    <option value="20">20</option>
                                                    <option value="30">30</option>
                                                    <option value="40">40</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="col-md-8">
                                                <p class="form-control-static">Page Number:</p>
                                            </div>
                                            <div class="col-md-4">
                                                <select class="pagenum input-mini form-control" title="Select page number"></select>
                                            </div>
                                        </div>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>         
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>