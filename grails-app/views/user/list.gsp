<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - Users</title>
    </head>
    <body>
        <div class="col-md-12 text-center">
            <h1>All Users</h1>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            
            <li class="nav active"><a href="#content" data-toggle="tab">Users</a></li>
            <li class="nav"><a href="${createLink(action:'create')}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add New User</a></li>
        </ul>
        <div class="tab-content">
            <g:if test="${flash.message}">
                <%-- display an info message to confirm --%>
                <div class="col-xs-12 text-center">
                    <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        ${raw(flash.message)}
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
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Filter Users
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <g:form name="userSearchForm">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <g:select class="form-control" name="accountTypeSelect" from="${accountTypeList}" optionKey="key" optionValue="value" noSelection="['': 'Select an Account Type (optional)']" />
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <g:textField class="form-control" name="userSearch" placeholder="Email or Real Name (optional)" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <g:actionSubmit class="btn btn-default submit-button-green" name="filterUsers" value="Filter Users" action="list" />
                                            </div>
                                        </div>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table id="sortableTable">
                        <thead class="th-green">
                            <tr>
                                <%--<g:sortableColumn params="${params}" class="text-center" property="username" defaultOrder="desc" title="Email &#9650;&#9660;" />--%>
                                <th class="text-center">Email</th>
                                <th class="text-center">First Name</th>
                                <th class="text-center">Surname</th>
                                <th class="text-center">Type</th>
                                <th class="text-center">Account Enabled</th>
                                <th class="text-center {sorter: false}">Email Reset Password</th>
                                <th class="text-center {sorter: false}" colspan="3">Options</th>
                                <th class="text-center {sorter: false}">Impersonate</th>
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <g:each var="user" in="${results}" status="i">
                                <g:if test="${user.student}">
                                    <tr onclick='document.location = "<g:createLink controller="student" action="edit" id="${user.student.id}"></g:createLink>"'>
                                </g:if>
                                <g:elseif test="${user.faculty}">
                                    <tr onclick='document.location = "<g:createLink controller="faculty" action="show" id="${user.faculty.id}"></g:createLink>"'>
                                </g:elseif>
                                <g:else><tr></g:else>
                                    <td>
                                        <g:if test="${user.username == thisUser.username}"><em>${user.username}</em></g:if>
                                        <g:else>${user.username}</g:else>
                                    </td>
                                    <td>${user.getFirstName()}</td>
                                    <td>${user.getSurname()}</td>
                                    <td>
                                        <g:if test="${resultsRoles[i].toString() == "ROLE_STUDENT"}">Student</g:if>
                                        <g:elseif test="${resultsRoles[i].toString() == "ROLE_FACULTY"}">Faculty</g:elseif>
                                        <g:elseif test="${resultsRoles[i].toString() == "ROLE_ADMIN"}">Administrator</g:elseif>
                                        <g:else>-</g:else>
                                    </td>
                                    <td>
                                        <g:if test="${user.enabled}"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span><span class="sr-only">true</span></g:if>
                                        <g:else><span class="glyphicon glyphicon-remove" aria-hidden="true"></span><span class="sr-only">false</span></g:else>
                                    </td>
                                    <td class="user-col">
                                        <g:form name="emailUserForm">
                                            <g:hiddenField name="page" value="faculty" />
                                            <g:hiddenField name="id" value="${user.id}" />
                                            <g:hiddenField name="email" value="${user.username}" />
                                            <g:if test="${user.id != thisUser.id}">
                                                <g:actionSubmit class="btn btn-primary btn-block" name="emailUser" value="Email" action="sendEmailReset" />
                                            </g:if>
                                        </g:form>
                                    </td>
                                    <td class="user-col">
                                        <g:form name="editUserForm">
                                            <g:hiddenField name="id" value="${user.id}" />
                                            <g:actionSubmit class="btn btn-block" name="editUser" value="Edit" action="edit" />
                                        </g:form>
                                    </td>
                                    <td class="user-col">
                                        <g:form name="disableUserForm">
                                            <g:if test="${user.id != thisUser.id}">
                                                <g:hiddenField name="id" value="${user.id}" />
                                                <g:if test="${user.enabled}">
                                                    <g:actionSubmit class="btn btn-warning btn-block" name="disableUser" value="Disable" action="toggleUserEnabled" />
                                                </g:if>
                                                <g:else>
                                                    <g:actionSubmit class="btn btn-success btn-block" name="enableUser" value="Enable" action="toggleUserEnabled" />
                                                </g:else>
                                            </g:if>
                                        </g:form>
                                    </td>
                                    <td class="user-col">
                                        <g:form name="deleteUserForm">
                                            <g:hiddenField name="id" value="${user.id}" />
                                            <g:if test="${user.id != thisUser.id}">
                                                <g:actionSubmit class="btn btn-danger btn-block" name="deleteUser" value="Delete" action="delete" onclick="return confirm('Are you sure?')" />
                                            </g:if>
                                        </g:form>
                                    </td>
                                    <td class="user-col">
                                    
                                    <form action='${request.contextPath}/login/impersonate' method='POST'> 
            							<input type='hidden' value="${user.username}"  name='username'/> 
            							<input type='submit' class="btn btn-success btn-block" value='Impersonate'/> 
        							</form>
                                    
                                    </td>
                                </tr>
                            </g:each>
                            <g:unless test="${results}">
                                <tr>
                                    <td colspan="9">No users found</td>
                                </tr>
                            </g:unless>
                        </tbody>
                        <!-- pager --> 
                        <tfoot>
                            <tr>
                                <th colspan="9" class="ts-pager form-horizontal">
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