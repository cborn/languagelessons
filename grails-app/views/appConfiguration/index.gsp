<!doctype html>
<html lang="en" class="no-js">
    <head>
        <title>JAS - Application Setup</title>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <g:set var="config" bean="configurationService"/>


    <script>
        // read the image
        function readFile(input)
        {
        // unhide the save changes button
        $('#submit_button').show();

        if (input.files && input.files[0])
        {
        var reader = new FileReader();

        // load a prompt to ask for a new picture
        reader.onload = function (e) {
            
            if($("#appPicture").length == 0)
            {
                // its not there because theres no image. 
                $("#emptyPhoto").html("<img class='img-responsive center-block' style='height: 100%; width: 100%; object-fit: contain' id='appPicture'>");
            }
            // set the profile picture to the new page
            $('#appPicture').attr('src', e.target.result)
        };

        // read the image selected from the prompt 
        reader.readAsDataURL(input.files[0]);
        }
        }
    </script>
    
    <script>
        
        $(document).ready(function(){
            $("#usingMoodle").click(function(){
                console.log($(this));
                
                
                if($("#usingMoodle:checked").length > 0){
                     $("#moodleHost").removeAttr('disabled');
                     $("#moodlePort").removeAttr('disabled');
                     $("#moodleDatabaseName").removeAttr('disabled');
                     $("#moodleDBName").removeAttr('disabled');
                     $("#moodleDBPassword").removeAttr('disabled');
                }
                else
                {
                   $("#moodleHost").attr('disabled','disabled');
                     $("#moodlePort").attr('disabled','disabled');
                     $("#moodleDatabaseName").attr('disabled','disabled');
                     $("#moodleDBName").attr('disabled','disabled');
                     $("#moodleDBPassword").attr('disabled','disabled');
                }
            });
        });
        
        
    </script>

</head>
<body>

    <div class="jumbotron jumbotron-fluid">
        <div class="container">
            <h1 class="display-3">First Time Setup!</h1>
            <p class="lead">Welcome to JAS the Job Application System. Here you need to configure your application settings to get going! 
                Don't make this public yet because anyone will be able to access it.</p>
        </div>
    </div>
    <g:if test="${flash.message}">
          <%-- display an info message to confirm --%>
        <div class="col-xs-12 text-center">
            <div class="alert alert-success alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
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
                ${raw(flash.error)}
            </div>
        </div>
    </g:if>
    <g:uploadForm name="AppImageForm" action="finishConfiguration">
        <div class="container">
            <div class="form-group row">
            <div class="form-group col-md-4">

                     <label  class="col-2 col-form-label">Application Image</label>
                    <div class="panel" style="border-color:#999;">
                        <div class="panel-body">

                            <div class="row">
                                <g:if test="${config.hasImage()}">
                                    <%-- show the photo --%>
                                    <div class="col-xs-10 col-xs-offset-1">
                                        <img class="img-responsive center-block"  style="width: 100%;height: 100%;object-fit: contain;" id="appPicture" src="${createLink(controller:'AppConfiguration', action:'getAppImage')}" alt="Application Image">
                                    </div>
                                </g:if>
                                <g:else>
                                    <div id="emptyPhoto" class="col-xs-10 col-xs-offset-1 photo-empty">
                                        <br /><br />
                                        <p class="text-center">Upload an application image</p>
                                    </div>
                                </g:else>
                            </div>
                            <div class="row">
                                <div class="form-group col-xs-10 col-xs-offset-1">
                                    <br />
                                    <div class="row center-block">
                                        <input id="image" type="file" name="image" onchange="readFile(this);">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                

            </div>
            <div class="form-group col-md-8">
                <label for="appName" class="col-2 col-form-label" required>App Name</label>
                <div class="col-10">
                    <input class="form-control" type="text" id="appName" name="appName" value="${config.getName()}">
                </div>
            </div>
            <div class="form-group col-md-8">
               <label for="appDescription" class="col-2 col-form-label">App Description</label>
                <div class="col-10">
                    <textarea class="form-control" id="appDescription" name="appDescription" style="height:200px;">${config.getDescription()}</textarea>
                </div>
            </div>
            </div>
            <div class="form-group row">
                <label for="emailToSendAs" class="col-2 col-form-label">Address to send Email from</label>
                <div class="col-10">
                    <input class="form-control" type="email" value="${config.getEmailToSendAs()}" name="emailToSendAs" id="emailToSendAs">
                </div>
            </div>
            <div class="form-group row ">
                <label for="SMTPAddress" class="col-2 col-form-label">SMTP Server Address</label>
                <div class="col-10">
                    <input class="form-control" type="text" value="${config.getSMTPAddress()}" id="SMTPAddress" name="SMTPAddress">
                </div>
            </div>
            <div class="form-group row">
                <label for="SMTPPort" class="col-2 col-form-label">SMTP Port</label>
                <div class="col-10">
                    <input class="form-control" type="number" value="${config.getEmailPort()}" id="SMTPPort" name="SMTPPort">
                </div>
            </div>
            <div class="form-group row">
                <label for="SMTPUsername" class="col-2 col-form-label">SMTP Username</label>
                <div class="col-10">
                    <input class="form-control" type="text" value="${config.getEmailUsername()}" id="SMTPUsername" name="SMTPUsername">
                </div>
            </div>
            <div class="form-group row">
                <label for="SMTPPassword" class="col-2 col-form-label">SMTP Password</label>
                <div class="col-10">
                    <input class="form-control" type="text" value="${config.getEmailPassword()}" id="SMTPPassword" name="SMTPPassword">
                </div>
            </div>
            
            <div class="form-group row">
               <div class="checkbox">
                  <label>
                        <g:checkBox id="usingMoodle" name="usingMoodle" value="${config.getUsingMoodle()}"/> Using Moodle?
                    </label>
                </div>
            </div>
            
            
            
            
             <div class="form-group row">
                <label for="moodleHost" class="col-2 col-form-label">Moodle Host</label>
                <div class="col-10">
                    <g:field class="form-control" type="text" value="${config.getMoodleHost()}" id="moodleHost" name="moodleHost" disabled="${!config.getUsingMoodle()}"/>
                </div>
            </div>
             <div class="form-group row">
                 <label for="moodlePort" class="col-2 col-form-label">Moodle Port</label>
                <div class="col-10">
                    <g:field class="form-control" type="text" value="${config.getMoodlePort()}" id="moodlePort" name="moodlePort" disabled="${!config.getUsingMoodle()}"/>
                </div>
            </div>
             <div class="form-group row">
                 <label for="moodleDatabaseName" class="col-2 col-form-label">Moodle Database Name</label>
                <div class="col-10">
                    <g:field class="form-control" type="text" value="${config.getMoodleDatabaseName()}" id="moodleDatabaseName" name="moodleDatabaseName" disabled="${!config.getUsingMoodle()}"/>
                </div>
            </div>
             <div class="form-group row">
                <label for="moodleDBName" class="col-2 col-form-label">Moodle Database Username</label>
                <div class="col-10">
                    <g:field class="form-control" type="text" value="${config.getMoodleDBUsername()}" id="moodleDBName" name="moodleDBName" disabled="${!config.getUsingMoodle()}"/>
                </div>
            </div>
             <div class="form-group row">
                <label for="moodleDBPassword" class="col-2 col-form-label">Moodle Database Password</label>
                <div class="col-10">
                    <g:field class="form-control" type="text" value="${config.getMoodleDBPassword()}" id="moodleDBPassword" name="moodleDBPassword" disabled="${!config.getUsingMoodle()}"/>
                </div>
            </div>
            
            
            <div class="form-group row">
                <div class="col-12">
                    <br />
                    <div class="row">
                        <input class="btn btn-success btn-block pull-right" type="submit" id="submit_button" value="Save"/>
                    </div>
                </div>
            </div>
        </div>
    </g:uploadForm>

</body>
</html>