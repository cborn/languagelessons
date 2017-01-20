<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - Request Password Reset</title>
    </head>
    <body>
        <div class="col-md-12 text-center">
            <h1>Request Password Reset</h1>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav"><a class="ifr-home-tab" href="${createLink(uri:'/')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            <li class="nav active"><a href="#content" data-toggle="tab">Request Password Reset</a></li>
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
                    <div class="col-md-12 text-center">
                        <h4>Please enter your email address and we will email you instructions on how to reset your password</h4>
                    </div>
                    <g:form name="requestResetPasswordForm">
                        <g:hiddenField name="type" value="selfRequest" />
                        <div class="col-md-8 col-md-offset-2">
                            <div class="panel panel-green-border">
                                <div class="panel-body">
                                    <div class="col-xs-8 col-xs-offset-2">
                                        <label for="username">Email</label>
                                        <div id="username">
                                            <div class="form-group">
                                                <g:textField class="form-control required email" name="email" placeholder="Email Address" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-xs-12">
                            <g:actionSubmit class="btn btn-default btn-lg center-block submit-button-green" name="resetPassword" value="Send Password Reset" action="sendEmailReset" />
                        </div>
                        <div class="form-group col-xs-12 text-center">
                            <small class="text-danger">Still having problems? Email us: <a href="***">***</a></small>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </body>
</html>