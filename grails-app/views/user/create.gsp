<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - New User</title>
        <script>
            function userAccountForm() {
                if(document.getElementById("accountTypeSelect").value == "Student") {
                    $('#facultyPanel').hide();
                    $('#studentPanel').show();
                }
                else {
                    $('#facultyPanel').show();
                    $('#studentPanel').hide();
                }
            }
            <g:tabSave />
        </script>
    </head>
    <body>
        <g:form name="createUserForm">
            <div class="col-xs-12 text-center">
                <h1>Add New User</h1>
            </div>
            <ul class="nav nav-tabs">
                <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
                <li class="nav active"><a href="#content" data-toggle="tab">User Information</a></li>
                <li class="nav"><a class="ll-save-tab"><span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span> <g:actionSubmit class="btn-masking-as-tab" name="createUser" value="Save User" action="processAddUser" /></a></li>
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
                        <g:hiddenField name="courseWorkflow" value="${params.courseWorkflow}" /><%-- are they doing this while setting up a course? --%>
                            <h3>User Information</h3>
                            <div class="panel panel-green-border">
                                <div class="panel-body">
                                    <div class="col-xs-4">
                                        <label for="username">Email (*)</label>
                                        <div id="username">
                                            <div class="form-group">
                                                <g:textField class="form-control required email" name="username" placeholder="Email Address" value="${params.username}" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <label for="password">Password</label>
                                        <div id="password">
                                            <div class="form-group text-info">
                                                Password is automatically generated
                                                <%--<g:passwordField name="password" class="form-control required" />--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <label for="accountType">Account Type (*)</label>
                                        <div id="accountType">
                                            <div class="form-group">
                                                <g:select class="form-control required" name="accountTypeSelect" from="${accountTypeList}" noSelection="['': 'Select Type']" 
                                                    optionKey="key" optionValue="value" onchange="userAccountForm()" value="${params.accountTypeSelect}" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- STUDENT PANEL --%>
                            <g:if test="${params.accountTypeSelect == "Student"}"><div id="studentPanel" class="col-md-12"></g:if>
                            <g:else><div id="studentPanel" class="col-md-12" style="display:none"></g:else>
                                <h3>Student Information</h3>
                                <div class="panel panel-green-border">
                                    <div class="panel-body">
                                        <div class="col-md-8">
                                            <div class="col-md-12">
                                                <label for="studentName">Name (*)</label>
                                            </div>
                                            <div id="studentName">
                                                <div class="col-md-6 form-group">
                                                    <g:textField class="form-control required" name="studentFirstName" placeholder="First Name" value="${params.studentFirstName}" />
                                                </div>
                                                <div class="col-md-6 form-group">
                                                    <g:textField class="form-control required" name="studentSurname" placeholder="Last Name" value="${params.studentSurname}" />
                                                </div>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                            <%-- FACULTY PANEL --%>
                            <g:if test="${params.courseWorkflow}"><div id="facultyPanel" class="col-md-12"></g:if>
                            <g:else>
                                <g:if test="${params.accountTypeSelect != "Student"}"><div id="facultyPanel" class="col-md-12" style="display:none"></g:if>
                                <g:else><div id="facultyPanel" class="col-md-12"></g:else>
                            </g:else>
                                <h3>Faculty Information</h3>
                                <div class="panel panel-green-border">
                                    <div class="panel-body">
                                        <div class="col-md-8">
                                            <div class="col-md-12">
                                                <label for="facultyName">Name (*)</label>
                                            </div>
                                            <div id="facultyName">
                                                <div class="col-md-4 form-group">
                                                    <g:select class="form-control " name="facultyTitle" from="${titleList}"
                                                        optionKey="key" optionValue="value" noSelection="['': 'Select Title']" value="${params.facultyTitle}" />
                                                </div>
                                                <div class="col-md-4 form-group">
                                                    <g:textField class="form-control required" name="facultyFirstName" placeholder="First Name" value="${params.facultyFirstName}" />
                                                </div>
                                                <div class="col-md-4 form-group">
                                                    <g:textField class="form-control required" name="facultySurname" placeholder="Last Name" value="${params.facultySurname}" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="col-md-12">
                                                <label for="facultyUniversity">Institute</label>
                                            </div>
                                            <div id="facultyUniversity">
                                                <div class="col-md-12 form-group">
                                                    <g:textField class="form-control " name="facultyUniversity" placeholder="University or College"value="${params.facultyUniversity}" />
                                                </div>
                                            </div>
                                        </div>       
                                    </div>
                                </div>
                              
                                
                            </div>
                        </div>
                    </div>
                </div>
                  <g:actionSubmit class="btn btn-success pull-right" name="createUser" value="Save User" action="processAddUser" />
            </g:form>
        </div>
    </body>
</html>