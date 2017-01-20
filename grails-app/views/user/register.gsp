<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - New User</title>
    </head>
    <body>
        <div class="form-body">
            <div class="col-xs-12 text-center">
                <h1>New Application</h1>
            </div>
            <div class="col-xs-12 text-center">
                <h3>Please Complete the Following to Begin an Application</h3>
            </div>
            <div class="col-xs-8 col-xs-offset-2">
                <div class="panel panel-green-border">
                    <div class="panel-body">
                        <%-- if there's an error --%>
                        <g:if test="${flash.error}">
                            <div class="alert alert-danger alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                ${flash.error}
                            </div>
                        </g:if>
                        <g:if test="${flash.message}">
                            <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                ${flash.message}
                            </div>
                        </g:if>
                        <g:form name="registrationForm">
                            <div class="col-xs-6 form-group">
                                <label for="email">Please enter your email address:</label>
                                <div id="email">
                                    <g:textField class="form-control required email" name="email" placeholder="Email Address" />
                                </div>
                            </div>
                            <div class="col-xs-6 form-group">
                                <label for="dob">Date of Birth:</label>
                                <div id="dob">
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker1'>
                                            <input type='text' class="form-control required date" name="dateOfBirth" />
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                    <script type="text/javascript">
                                        $(function () {
                                            $('#datetimepicker1').datetimepicker({
                                                viewMode: 'years',                          // start with years
                                                format: 'L',                                // only show date, not time
                                                minDate: moment().subtract(100, 'years'),   // years must be in the last 17-100 years
                                                maxDate: moment().subtract(17, 'years')     // 17 in case they will be 18 by the time the school starts, not a formality, must still be verified by faculty
                                            });
                                        });
                                    </script>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label for="password">Password</label>
                                <div id="password">
                                    <div class="form-group">
                                        <g:passwordField name="password" class="form-control required" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label for="password">Re-Enter Password</label>
                                <div id="password">
                                    <div class="form-group">
                                        <g:passwordField name="passwordDuplicate" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
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
                            <div class="form-group col-md-12">
                                <br />
                                <g:actionSubmit class="btn btn-default btn-lg center-block submit-button-green" value="Submit" action="processRegistration" />
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>