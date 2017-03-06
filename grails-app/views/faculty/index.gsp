<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>LL - Faculty</title>
    </head>
    <body>
        <div class="col-xs-12 text-center">
            <h1>Faculty</h1>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            <li class="nav active"><a href="#content" data-toggle="tab">Manager</a></li>
            <li class="nav"><a href="${createLink(controller:"user",action:"create")}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add New Faculty User</a></li>
        </ul>
        <div class="tab-content">
<%-- HOME --%>
<%-- CONTENT --%>
            <div class="tab-pane fade in active" id="content">
                <br />
                <div class="col-md-12">
                    <table id="sortableTable">
                        <thead class="th-green">
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Affiliation</th>
                                <th>Courses</th>
                                <th>Impersonate</th>
                                <th class="{sorter: false}"></th>
                                <th class="{sorter: false}">Reset Password</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each var="user" in="${allFaculty}" status="i">
                                <tr>
                                    <td><g:link action="show" id="${user.faculty.id}">${user.faculty.title + " " + user.faculty.firstName + " " + user.faculty.surname}</g:link></td>
                                    <td>${user.username}</td>
                                    <td>${user.faculty.university}</td>
                                    <td>
                                        <ul><%-- TODO SHOW ONLY ACTIVE COURSES?  --%>
                                            <g:each var="course" in="${user.faculty.courses}">
                                                <li><g:link controller="course" action="show" id="${course.id}">${course.getCourseName()}</g:link></li>
                                            </g:each>
                                        </ul>
                                        <g:unless test="${user.faculty.courses}">
                                            <p>No courses assigned</p>
                                        </g:unless>
                                    </td>
                                    <td>
                                    <form action='${request.contextPath}/login/impersonate' method='POST'> 
            							<input type='hidden' value="${user.username}"  name='username'/> 
            							<input type='submit' class="btn btn-success btn-block" value='Impersonate'/> 
        							</form>
                                    
                                    </td>
                                    <td><a class="btn btn-default btn-block" href="${createLink(controller:"user",action:"edit", id:user.id)}">Edit</a></td>
                                    <td>
                                    <g:form name="emailUserForm" controller="user">
                                         <g:hiddenField name="page" value="faculty" />
                                             
                                        <g:hiddenField name="id" value="${user.id}" />
                                            <g:hiddenField name="email" value="${user.username}" />
                                               <g:actionSubmit class="btn btn-primary btn-block" name="emailUser"  value="Email" action="sendEmailReset" />
                                          
                                        </g:form>
                                    
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                        <!-- pager --> 
                        <tfoot>
                            <tr>
                                <th colspan="5" class="ts-pager form-horizontal">
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
    </body>
</html>