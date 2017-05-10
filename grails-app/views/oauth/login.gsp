<html>
<head>
    <asset:javascript src="application.js"/>
</head>
<body>
    <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform form">
        <input type="hidden" class="text_ form-control" value=${user} name="${usernameParameter ?: 'username'}" id="username"/>
        
        <input type="hidden" class="text_ form-control" value=${pword} name="${passwordParameter ?: 'password'}" id="password"/>
    </form>
    
    <script>
        $(document).ready(function() {
            $('#loginForm').submit();
        });
    </script>
</body>
</html>