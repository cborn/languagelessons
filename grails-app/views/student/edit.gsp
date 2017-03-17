<!doctype html>
<html lang="en" class="no-js">
<head>
    <g:set var="config" bean="configurationService"/>
  
<meta name="layout" content="main" />
<title>LL - Student Information</title>
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
                        // set the profile picture to the new page
                        $('#profilePicture').attr('src', e.target.result)
                    };

                    // read the image selected from the prompt 
                    reader.readAsDataURL(input.files[0]);
                }
            }
            <g:tabSave />
        </script>
        
</head>
<body>
	<div class="col-md-12 text-center">
		<h1>
			Student Information
			<sec:access expression="hasRole('ROLE_ADMIN')">: ${studentInfo.firstName + " " + studentInfo.surname} (${studentUserInfo.id})
			</sec:access>
		</h1>
	</div>
	<ul class="nav nav-tabs">
		<li class="nav"><sec:access expression="hasRole('ROLE_STUDENT')">
				<a class="ll-home-tab"
					href="${createLink(controller:'applicant', action:'index')}">
			</sec:access> <sec:access expression="hasRole('ROLE_ADMIN')">
				<a class="ll-home-tab"
					href="${createLink(controller:'admin', action:'index')}">
			</sec:access> <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
			Home </a></li>
		<li class="nav active"><a href="#personalinfo" data-toggle="tab">Personal</a></li>
		<li class="nav"><a href="#identification" data-toggle="tab">Identification</a></li>
                

		<li class="nav"><a href="#courses" data-toggle="tab">Courses</a></li>
		<%-- SPLIT --%>
		<sec:access expression="hasRole('ROLE_ADMIN')">			
			<li class="nav pull-right">
                            <a class="ll-save-tab">
                            <form action='${request.contextPath}/login/impersonate' class="ll-save-tab" method='POST'> 
            							<input type='hidden' value="${studentUserInfo.username}"  name='username'/> 
            							<input type='submit' style=" background: none;border: none;padding: 0;-webkit-appearance: inherit;box-shadow: none;" value='Impersonate'/> 
        							</form>
                            </a>    
                        </li> 
		</sec:access>
	</ul>
	
	
	<div class="tab-content">
		<g:if test="${flash.message}">
			<%-- display an info message to confirm --%>
			<div class="col-xs-12 text-center">
				<div class="alert alert-info alert-dismissible" role="alert"
					style="display: block; margin-top: 5px;">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					${raw(flash.message)}
				</div>
			</div>
		</g:if>
		<g:if test="${flash.error}">
			<%-- display an info message to confirm --%>
			<div class="col-xs-12 text-center">
				<div class="alert alert-danger alert-dismissible" role="alert"
					style="display: block; margin-top: 5px;">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					${flash.error}
                    </div>
                </div>
            </g:if>
<%-- PERSONAL INFORMATION --%>
            <div class="tab-pane fade in active" id="personalinfo">
                <br />
                <div class="col-md-12">
                    <g:form name="personalInformationForm">
                        <div class="col-md-6">
                            <div class="col-md-12">
                                <h3>Basic</h3>
                                <div class="panel panel-green-border">
                                    <div class="panel-body">
                                        <div class="col-md-12">
                                            <label for="fullname">Full Name</label>
                                            <div id="fullname">
                                                <div class="form-group row">
                                                    <div class="col-md-4 form-group name-group">
                                                        <g:textField class="form-control required" name="firstName" placeholder="First Name" value="${studentInfo.firstName}" />
                                                    </div>
                                                    <div class="col-md-4 form-group name-group">
                                                        <g:textField class="form-control" name="middleName" placeholder="Middle Name" value="${studentInfo.middleName}" />
                                                    </div>
                                                    <div class="col-md-4 form-group name-group">
                                                        <g:textField class="form-control required" name="surname" placeholder="Last Name" value="${studentInfo.surname}" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h3>Contact</h3>
                            <div class="panel panel-green-border">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <label for="email">Email</label>
                                        <div id="email">
                                            <div class="form-group row">
                                                <div class="col-md-6 form-group">
                                                  <sec:access expression="hasRole('ROLE_ADMIN')">
                                                            <input id="didChangeEmail" name="didChangeEmail" type="hidden"/>
                                                    <g:textField class="form-control required" name="email" placeholder="email" onchange="changed()" value="${studentUserInfo.username}" />
                                                  </sec:access>
                                                   <sec:access expression="hasRole('ROLE_STUDENT')">
                                                    
                                                            ${studentUserInfo.username}
                                                    </sec:access>
                                                </div>
                                                 <div class="col-md-6 form-group">
                                                
                                                 
                                                 <sec:access expression="hasRole('ROLE_ADMIN')">
                                                 	<a class="btn btn-primary btn-block"  name="emailUserForm" href="${createLink(action:'sendEmailReset', controller:'user', id='studentUserInfo.id', params:[page:'student',email:studentUserInfo.username])  }"> Reset Password</a>
                                                 </sec:access>
                                                  
                                                
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12 form-group">
                                <g:hiddenField name="studentId" value="${studentInfo.id}" />
                                <g:actionSubmit class="btn btn-lg submit-button-green center-block" value="Save Changes" action="updatePersonalInformationForm" onclick="return confirm('Are you sure?')" />
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
    </body>
</html>