            <ul class="nav nav-tabs">
                <li class="nav"><a class="ifr-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
                <li class="nav active"><a href="#content" data-toggle="tab">Content</a></li>
            </ul>
            <div class="tab-content">
<%-- HOME --%>
<%-- CONTENT --%>
                <div class="tab-pane fade in active" id="content">
                    <br />
                    <div class="col-md-12">
                        
                    </div>
                </div>
            </div>
            
            
                <li class="nav">
                    <sec:access expression="hasRole('ROLE_STANDARD')">
                        <a class="ifr-home-tab" href="${createLink(controller:'student', action:'index')}">
                    </sec:access>
                    <sec:access expression="hasRole('ROLE_FACULTY')">
                        <a class="ifr-home-tab" href="${createLink(controller:'admin', action:'index')}">
                    </sec:access>
                    <sec:access expression="hasRole('ROLE_ADMIN')">
                        <a class="ifr-home-tab" href="${createLink(controller:'admin', action:'index')}">
                    </sec:access>
                        <span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home
                    </a>
                </li>
            

<%--SPRING LOGIN PAGE--%>
<html>
    <head>
        <meta name='layout' content='main'/>
        <title><g:message code="springSecurity.login.title"/></title>
        <style type='text/css' media='screen'>
            #login {
            margin: 15px 0px;
            padding: 0px;
            text-align: center;
            }
            #login .inner {
            width: 340px;
            padding-bottom: 6px;
            margin: 60px auto;
            text-align: left;
            border: 1px solid #aab;
            background-color: #f0f0fa;
            -moz-box-shadow: 2px 2px 2px #eee;
            -webkit-box-shadow: 2px 2px 2px #eee;
            -khtml-box-shadow: 2px 2px 2px #eee;
            box-shadow: 2px 2px 2px #eee;
            }
            #login .inner .fheader {
            padding: 18px 26px 14px 26px;
            background-color: #f7f7ff;
            margin: 0px 0 14px 0;
            color: #2e3741;
            font-size: 18px;
            font-weight: bold;
            }
            #login .inner .cssform p {
            clear: left;
            margin: 0;
            padding: 4px 0 3px 0;
            padding-left: 105px;
            margin-bottom: 20px;
            height: 1%;
            }
            #login .inner .cssform input[type='text'] {
            width: 120px;
            }
            #login .inner .cssform label {
            font-weight: bold;
            float: left;
            text-align: right;
            margin-left: -105px;
            width: 110px;
            padding-top: 3px;
            padding-right: 10px;
            }
            #login #remember_me_holder {
            padding-left: 120px;
            }
            #login #submit {
            margin-left: 15px;
            }
            #login #remember_me_holder label {
            float: none;
            margin-left: 0;
            text-align: left;
            width: 200px
            }
            #login .inner .login_message {
            padding: 6px 25px 20px 25px;
            color: #c33;
            }
            #login .inner .text_ {
            width: 120px;
            }
            #login .inner .chk {
            height: 12px;
            }
        </style>
    </head>

    <body>
        <div id='login'>
            <div class='inner'>
                <div class='fheader'><g:message code="springSecurity.login.header"/></div>

                <g:if test='${flash.message}'>
                    <div class='login_message'>${flash.message}</div>
                </g:if>

                <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                    <p>
                        <label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
                        <input type='text' class='text_' name='j_username' id='username'/>
                    </p>

                    <p>
                        <label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
                        <input type='password' class='text_' name='j_password' id='password'/>
                    </p>

                    <p id="remember_me_holder">
                        <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                        <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
                    </p>

                    <p>
                        <input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
                    </p>
                </form>
            </div>
        </div>
        <script type='text/javascript'>
            (function() {
            document.forms['loginForm'].elements['j_username'].focus();
            })();
        </script>
    </body>
</html>
            
<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>LL - Login</title>
    </head>
    <body>
        <div class="form-body">
            <div class="col-xs-12 text-center">
                <h1>Please Login</h1>
            </div>
            <div class="col-xs-10 col-xs-offset-1">
                <div class="panel panel-green-border">
                    <div class="panel-body">
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
                        <form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
                            <div class="col-xs-12 form-group">
                                <label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
                                <input type='text' class='text_' name='${usernameParameter}' id='username'/>
                            </div>
                            <div class="col-xs-12 form-group">
                                <label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
                                <input type='password' class='text_' name='${passwordParameter}' id='password'/>
                            </div>
                            <div class="col-xs-12 form-group" id="remember_me_holder">
                                <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                                <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
                            </div>
                            <div class="col-xs-12 form-group">
                                <input type='submit' id="submit" class="btn btn-default btn-lg center-block submit-button-green" value='${message(code: "springSecurity.login.button")}'/>
                            </div>
                        </form>
                    </div>
                </div>
                <script type='text/javascript'>
                    (function() {
                        document.forms['loginForm'].elements['${usernameParameter}'].focus();
                    })();
                </script>
            </div>
        </div>
    </body>
</html>
