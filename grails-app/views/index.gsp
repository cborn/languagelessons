<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Welcome to Language Lessons</title>
        <asset:javascript src="application.js"/>
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
        <div class="col-xs-12">
            <div class="jumbotron">
                <img src="" class="img-responsive"/>
                <p>Welcome to Language Lessons. Please login or signup to begin.</p>
                <p>
                    <g:link role="button" controller="student" class="btn btn-primary btn-lg" id="loginBtn" action="index">Login</g:link>
                    <g:link role="button" controller="user" class="btn btn-success btn-lg" action="index">Apply Now</g:link>
                    <g:link role="button" class="btn btn-success btn-lg" uri="/faq" >FAQ</g:link>
                
                </p>
                <small>
                    <g:link controller="user" class="btn btn-warning btn-lg" action="requestResetPassword">Help! I have forgotten my password</g:link>
                </small>
            </div>
        </div>
        
        <script>
            <sec:ifLoggedIn>
                $('body').html(" ")
                window.location.replace("${createLink(controller: "student", action:"index")}");
            </sec:ifLoggedIn>
        </script>
    </body>
</html>
