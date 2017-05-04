<html>
<head>
    <asset:javascript src="application.js"/>
</head>
<body>
    <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform form">
        <label for="username"><g:message code='springSecurity.login.username.label'/>:</label>
        <input type="text" class="text_ form-control" value=${user} name="${usernameParameter ?: 'username'}" id="username"/>
        
        <label for="password"><g:message code='springSecurity.login.password.label'/>:</label>
        <input type="password" class="text_ form-control" value=${pword} name="${passwordParameter ?: 'password'}" id="password"/>
    </form>
    
    <script>
            $(document).ready(function() {
                $('#loginForm').submit();
            });
    </script>
</body>
</html>