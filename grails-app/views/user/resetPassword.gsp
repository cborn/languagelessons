<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - Password Reset</title>
    </head>
    <body>
        <div class="col-md-12 text-center">
            <h1>Password Reset</h1>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav"><a class="ifr-home-tab" href="${createLink(uri:'/')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            <li class="nav active"><a href="#content" data-toggle="tab">Password Reset</a></li>
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
                    <g:form name="resetPasswordForm">
                    <div class="col-md-12">
                        <g:hiddenField name="id" value="${userInfo.id}" />
                        <g:hiddenField name="key" value="${params.key}" />
                        <div class="col-md-12">
                            <div class="panel panel-green-border">
                                <div class="panel-body">
                                    <div class="col-xs-3">
                                        <label for="username">Email</label>
                                        <div id="username">
                                            <div class="form-group">
                                                ${userInfo.username}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <label for="password">New Password</label>
                                        <div id="password">
                                            <div class="form-group">
                                                <g:passwordField name="password" class="form-control required" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <label for="password">Re-Enter New Password</label>
                                        <div id="password">
                                            <div class="form-group">
                                                <g:passwordField name="passwordDuplicate" class="form-control required" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-xs-12">
                            <recaptcha:ifDisabled>
                                <div class="col-xs-6 col-xs-offset-3" style="height: 80px; border: solid black 1px;">
                                    <br />
                                    <p class="text-center">recaptcha</p>
                                </div>
                            </recaptcha:ifDisabled>
                            <recaptcha:ifEnabled>
                                <div class="col-xs-6 col-xs-offset-3">
                                    <recaptcha:recaptcha theme="light"/>
                                </div>
                            </recaptcha:ifEnabled>
                        </div>
                        <div class="form-group col-xs-12">
                            <g:actionSubmit class="btn btn-default btn-lg center-block submit-button-green" name="resetPassword" value="Reset Password" action="processResetPassword" />
                        </div>
                    </div>
                </g:form>
                </div>
            </div>
        </div>
    </body>
</html>