<!doctype html>
<html lang="en" class="no-js">
    <head>
        <g:set var="config" bean="configurationService"/>
        <meta name="layout" content="main"/>
        <title>Language Lessons - Administrator Homepage</title>
        <script src="http://jqueryvalidation.org/files/dist/additional-methods.min.js"></script>
        <script>
            function appForm() {
                if(document.getElementById("appFieldSelect").value == "sn") {
                    $('#appQuerySel').show();
                    $('#appStatusSel').hide();
                    $('#intStatusSel').hide();
                    $('#appSearchField').show();
                }
                else if(document.getElementById("appFieldSelect").value == "as") {
                    $('#appQuerySel').hide();
                    $('#appStatusSel').show();
                    $('#intStatusSel').hide();
                    $('#appSearchField').hide();
                }
                else if(document.getElementById("appFieldSelect").value == "is") {
                    $('#appQuerySel').hide();
                    $('#appStatusSel').hide();
                    $('#intStatusSel').show();
                    $('#appSearchField').hide();
                }
            }
            <g:tabSave />
        </script>
        
        <style>
        
        .new a { 

            color: green !important;
        }

        .new.active a{


            border-color: green !important;
            border-bottom-color: transparent !important;
        }

        .new a:before {
               font-size: 9px;
    content: "NEW";
    position: absolute;
    top: 4px;
    right: 2px;
    color: #921F1F;
        }
        
        
        
        </style>
        
    </head>
    <body>
        <div class="col-xs-12 text-center">
            <sec:access expression="hasRole('ROLE_ADMIN')">
                <h1>Administrator Homepage: ${userInfo.manager.name}</h1>
            </sec:access>
            <sec:access expression="hasRole('ROLE_MANAGER')">
                <h1>Manager Homepage: ${userInfo.manager.title} ${userInfo.manager.name}</h1>
            </sec:access>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav active"><a class="ll-home-tab" href="#overview" data-toggle="tab"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            <li class="nav"><a href="#applicants" data-toggle="tab">Applicants</a></li>
            <li class="nav"><a href="#applications" data-toggle="tab">Applications</a></li>
            <li class="nav"><a href="#fieldSchool" data-toggle="tab">Courses</a></li>
            <sec:ifAnyGranted roles="ROLE_ADMIN">
                
                <g:if test="${seasonScholarshipApplications.totalCount > 0}">
                    <li class="nav"><a href="#scholarships" data-toggle="tab">Scholarships</a></li>
                </g:if>
                <g:else>
                    
                   
                 <li class="nav new"><a href="#scholarships" data-toggle="tab">Scholarships</a></li>
                </g:else>
                
                
                </sec:ifAnyGranted>
                  <sec:ifAnyGranted roles="ROLE_MANAGER">
                
                       <g:if test="${hasScholarship}">
                           <g:if test="${seasonScholarshipApplications.totalCount > 0}">
                    <li class="nav"><a href="#scholarships" data-toggle="tab">Scholarships</a></li>
                </g:if>
                <g:else>
                    
                   
                    <li class="nav new"><a href="#scholarships" data-toggle="tab">Scholarships</a></li>
                </g:else>
                </g:if>
                      
                      
                 </sec:ifAnyGranted>
                 <sec:access expression="hasRole('ROLE_ADMIN')">
                
                    <g:if test="${feedbackCount > 0}">
                    <li class="nav"><a href="#feedback" data-toggle="tab">Feedback</a></li>
                    </g:if>
                    <g:else>
                      <li class="nav new"><a href="#feedback" data-toggle="tab">Feedback</a></li>
                     </g:else>
                
                </sec:access>
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
<%-- OVERVIEW --%>
            <div class="tab-pane fade in active" id="overview">
                <br />
                <div class="row">
                    <div class="col-md-10">
                        <sec:access expression="hasRole('ROLE_MANAGER')"    >
                            <div class="col-md-12">
                                <g:if test="${userInfo.manager.title == 'None'}">
                                    <p>Welcome,</p>
                                </g:if>
                                <g:elseif test="${userInfo.manager.title != 'None'}">
                                       <p>Welcome ${userInfo.manager.title} ${userInfo.manager.surname},</p> 
                                </g:elseif>
                                <p>You can look up enrollment data for the ${config.getInstance().courseNamePlural} you are currently assigned to as an instructor here. You will only be able to access the data for applicants applying to or currently enrolled in your program.</p>
                                <p>If you have any questions or concerns, contact us by email <a href="mailto:***">***</a>, or by phone at +1 424.226.6130.</p>
                            </div>
                            <div class="col-md-12" style="padding-top: 20px">
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Accepted Applications:</h4>
                                            <h3>${acceptedApplications.totalCount}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"accepted"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Pending Applications:</h4>
                                            <h3>${pendingApplications.totalCount}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"pending"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Rejected Applications:</h4>
                                            <h3>${rejectedApplications.totalCount}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"rejected"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <!--  scholarship overview -->
                            <g:if test="${hasScholarship}">
                             <div class="col-md-12">
                               	<h3>Scholarship Information</h3>
                                <p>You can look up enrollment data for scholarships you are currently assigned to as a board member here. You will only be able to access the data for applicants applying to your scholarships.</p>
                             </div>
                            
                            <div class="col-md-12" style="padding-top: 20px">
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Accepted Applications:</h4>
                                            <h3>${acceptedScholarships.size()}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"accepted"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Pending Applications:</h4>
                                            <h3>${pendingScholarships.size()}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"pending"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Rejected Applications:</h4>
                                            <h3>${rejectedScholarships.size()}</h3>
                                            <g:link controller="ScholarshipApplication" action="list" params="[status:"rejected"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            </g:if>
                            
                            
                            
                            
                        </sec:access>
                        <sec:access expression="hasRole('ROLE_ADMIN')">
                            <%-- <div class="col-md-12">
                                TODO: add a welcome message? 
                                <p>Welcome ${userInfo.manager.title} ${userInfo.manager.surname}.</p>
                                <br />
                            </div>--%>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All Applications:</h4>
                                            <h3>${allApplications.totalCount}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"all"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>This Season's Applications:</h4>
                                            <h3>${seasonApplications.totalCount}</h3>
                                            <g:link controller="GenericApplication" action="list" params="[status:"season"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All Users:</h4>
                                            <h3>${allUsers.totalCount}</h3>
                                            <g:link controller="user" action="list">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All ${config.getInstance().courseNamePlural}:</h4>
                                            <h3>${allCourses.totalCount}</h3>
                                            <g:link controller="course" action="index" params="[status:"all"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>This Season's Schools:</h4>
                                            <h3>${seasonCourses.totalCount}</h3>
                                            <g:link controller="course" action="index" params="[status:"season"]">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All Manager:</h4>
                                            <h3>${allManager.size()}</h3>
                                            <g:link controller="manager" action="index">
                                                Show all &raquo;
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          
                        </sec:access>
                    </div>
                    <div class="col-md-2">
                        <div class="col-md-12">
                            <g:form name="accountSettingsForm" controller="user">
                                <div class="row form-group">
                                    <g:hiddenField name="id" value="${userInfo.id}" />
                                    <g:actionSubmit class="btn btn-default btn-block submit-button-green pull-right" name="accountSettings" value="Account Settings" action="edit" />
                                </div>
                            </g:form>
                             <sec:access expression="hasRole('ROLE_ADMIN')">
                                <g:form name="systemSettingsForm" controller="appConfiguration">
                                    <div class="row form-group">
                                        <g:actionSubmit class="btn btn-default btn-block submit-button-green pull-right" name="systemSettings" value="System Settings" action="index" />
                                    </div>
                                </g:form>
                            </sec:access>
                            <sec:access expression="hasRole('ROLE_ADMIN')">
                                <g:form name="courseSettingsForm" controller="course">
                                    <div class="row form-group">
                                        <g:actionSubmit class="btn btn-default btn-block submit-button-green pull-right" name="courseSettings" value="${config.getInstance().courseName} Settings" action="editAll" />
                                    </div>
                                </g:form>
                            </sec:access>
                           
                            <g:form name="logoutForm" controller="logout">
                                <div class="row form-group">
                                    <g:actionSubmit class="btn btn-default btn-block submit-button-green pull-right" name="logout" value="Log Out" action="index" />
                                </div>
                            </g:form>
                        </div>
                    </div>
                </div>
                <sec:access expression="hasRole('ROLE_ADMIN')">
                  <div class="col-md-11">
                       <div class="col-md-12 panel panel-green-border">
                       
                       <%-- table --%>
                       <div class="col-md-9">
                        
                        <table class="table">
                        <tbody>
                        <tr>
                        <td>Applications</td>
                        <td>${adminData.ALL.size()}</td>
                         <td><g:link id="ALL" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                               <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                   
                            <td><g:link id="ALL" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                      </tr>
 						<tr>
                        <td>Accepted</td>
                        <td>${adminData.ACCEPTED.size()}</td>
                            <td><g:link id="ACCEPTED" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                               <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                   
                            <td><g:link id="ACCEPTED" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                       <tr>
                        <td>Pending</td>
                        <td>${adminData.PENDING.size()}</td>
                            <td><g:link id="PENDING" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                               <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                   
                            <td><g:link id="PENDING" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                       </tr>
                        <tr>
                        <td>Rejected</td>
                        <td>${adminData.REJECTED.size()}</td>
                            <td><g:link id="REJECTED" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                               <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                   
                            <td><g:link id="REJECTED" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                       </tr>
                        <tr>
                        <td>Withdrawn</td>
                        <td>${adminData.WITHDRAWN.size()}</td>
                            <td><g:link id="WITHDRAWN" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                               <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                   
                            <td><g:link id="WITHDRAWN" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                      <tr>
                        <td>Deposit Paid</td>
                        <td>${adminData.DEPOSIT.size()}</td>
                           <td><g:link id="DEPOSIT" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                               <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                   
                            <td><g:link id="DEPOSIT" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                        </tr>
                       
                        <tr>
                        <td>Tuition Paid</td>
                        <td>${adminData.TUITION.size()}</td>
                         <td><g:link id="TUITION" controller="applicant" action="specificReport"><input type="button" class="btn btn-success" value="Generate Report"/></g:link></td>
                          <td><g:link controller="visualization" action="histAppsVis"><input type="button" class="btn btn-success" value="Historical Chart"/></g:link></td>
                            <td><g:link id="TUITION" controller="applicant" action="specificReportDownload"><input type="button" class="btn btn-success" value="Download Report"/></g:link></td>
                        </tr>
                        
                        
                        
                        </tbody>
                        
                        
                        
                        </table>
                       </div>
                       
                  <br/>
                  <br/>
                  <br/>
                  <br/><br/>
                  <br/>
                       
                       
                       <div class="col-md-3">
						 <g:link   controller="visualization" action="admissionsVis"> 
						<input type="button" class="btn btn-success btn-lg" value="Admission Chart" />                       
                       </g:link>
                       
                       
                       
                       </div>
                       
                       <div class="col-md-3">
						
						  
						 <g:link   controller="visualization" action="paymentVis"> 
						<input type="button" style="margin-top:10px;" class="btn btn-success btn-lg" value=" Payment Chart"/>
						 </g:link>                    
                       
                       
                       
                       
                       </div>
                       
                       
                       
                       
                       </div>
                       
                       
                       
                </div>
                </sec:access>
                
                
                
                
            </div>
<%-- STUDENTS --%>
            <div class="tab-pane fade" id="applicants">
                <br />
                <sec:access expression="hasRole('ROLE_ADMIN')">
                    <div class="col-md-12">
                        <h3>Applicant Search</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <g:form name="applicantSearchForm" controller="applicant">
                                    <div class="col-md-12">
                                        <label for="name">Search by:</label>
                                    </div>
                                    <div id="name">
                                        <div class="col-md-3 form-group">
                                            <g:select class="form-control" name="fieldSelect" from="${applicantSearchTermSelect}" optionKey="key" optionValue="value"/>
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:select class="form-control" name="querySelect" from="${applicantSearchQuerySelect}" optionKey="key" optionValue="value"/>
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:textField class="form-control required" name="searchTerms" placeholder="Search" />
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:hiddenField name="noDownload" value="${true}" />
                                            <g:actionSubmit class="btn btn-default submit-button-green pull-right" name="submitApplicantSearch" value="Search" action="list" />
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </sec:access>
                <div class="col-md-12">
                    <h3>Applicant Information Report</h3>
                    <div class="panel panel-green-border">
                        <div class="panel-body">
                            <div class="col-xs-12">
                                <g:form name="applicantInformationReportForm" controller="applicant">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label for="year">Select ${config.getInstance().courseName} :</label>
                                        </div>
                                        <div id="year" class="col-md-12">
                                            <div class="form-group">
                                                <g:select class="form-control required" name="fieldSchoolSelect" from="${fieldSchoolList}" optionKey="id" optionValue="${{it.getCourseName()}}" noSelection="['all':'All']" />
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <label for="fields">Select fields to include in report:</label>
                                        </div>
                                        <div id="fields">
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="selectAll" /> <b>Select All</b></label></div>
                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="IncludeFieldSchools" /> <b>Include ${config.getInstance().courseNamePlural} I don't direct</b></label></div>
                                            </div>
                                            <div class="col-md-3 col-xs-12">
                                                <div class="panel panel-green-border panel-sir-boxes">
                                                    <div class="panel-body">
                                                        <div class="col-xs-12">
                                                            <p>Personal:</p>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="fullName" /> Full Name</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="address" /> Address</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="email" /> Email</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="phoneNumber" /> Phone Number</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="age" /> Age</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="gender" /> Gender</label></div>
                                                            <sec:access expression="hasRole('ROLE_ADMIN')">
                                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="ethnicity" /> Ethnicity</label></div>
                                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="profileImage" /> Profile Image</label></div>
                                                            </sec:access>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-xs-12">
                                                <div class="panel panel-green-border panel-sir-boxes">
                                                    <div class="panel-body">
                                                        <div class="col-xs-12">
                                                            <p>Academic:</p>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="major" /> Major</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="standing" /> Standing</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="university" /> University</label></div>
                                                            <%--<div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="secondTranscript" /> Second Transcript</label></div>--%>
                                                            <sec:access expression="hasRole('ROLE_ADMIN')">
                                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="credits" /> Credits</label></div>
                                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="finAidAgreement" /> Financial Aid Agreement</label></div>
                                                            </sec:access>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-xs-12">
                                                <div class="panel panel-green-border panel-sir-boxes">
                                                    <div class="panel-body">
                                                        <div class="col-xs-12">
                                                            <p>Application:</p>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="applicationDate" /> Application Date</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="decision" /> Decision</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="deposit" /> Deposit</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="tuition" /> Tuition</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="finalGrade" /> Final Grade</label></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-xs-12">
                                                <div class="panel panel-green-border panel-sir-boxes">
                                                    <div class="panel-body">
                                                        <div class="col-xs-12">
                                                            <p>Additional:</p>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="liabilityWaiver" /> Liability Waiver</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="userPermission" /> User Permission</label></div>
                                                            <g:if test="${hasAmericanSchool}"><div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="insuranceProof" /> Proof of Insurance</label></div></g:if>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="emergencyContacts" /> Emergency Contacts</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="tshirtSize" /> T-Shirt Size</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="referralSource" /> Referral Source</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="sir-group" name="passportInfo" /> Passport Info</label></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                           
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <g:actionSubmit class="btn btn-default submit-button-green pull-right admin-pg-btn" name="submitApplicantInformationReportDownload" action="applicantInformationReportDownload" value="Download Report" />
                                        </div>
                                        <div class="form-group col-md-6">
                                            <g:actionSubmit class="btn btn-default submit-button-green pull-left admin-pg-btn" name="submitGenerateApplicantInformation" action="applicantInformationReport" value="Generate Report" />
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<%-- APPLICATIONS --%>
            <div class="tab-pane fade" id="applications">
                <br />
                <sec:access expression="hasRole('ROLE_ADMIN')">
                    <div class="col-md-12">
                        <h3>Application Search</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <g:form name="applicationSearchForm" controller="GenericApplication">
                                    <div class="col-md-12">
                                        <label for="name">Search by:</label>
                                    </div>
                                    <div id="name">
                                        <div class="col-md-3 form-group">
                                            <g:select class="form-control required" name="appFieldSelect" from="${applicationSearchTermSelect}" optionKey="key" optionValue="value" onchange="appForm()" />
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:select id="appQuerySel" class="form-control" name="appQuerySelect" from="${applicationSearchQuerySelect}" optionKey="key" optionValue="value"/>
                                            <g:select id="appStatusSel" class="form-control" name="appStatusSelect" from="${applicationStatusSelect}" optionKey="key" optionValue="value" style="display:none"/>
                                            <g:select id="intStatusSel" class="form-control" name="intStatusSelect" from="["contacted":"Contacted","notcontacted":"Not Contacted"]" optionKey="key" optionValue="value" style="display:none"/>
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:textField id="appSearchField" class="form-control" name="searchTerms" placeholder="Search" />
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:hiddenField name="noDownload" value="${true}" />
                                            <g:actionSubmit class="btn btn-default submit-button-green pull-right" name="submitApplicationSearch" value="Search" action="list" />
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </sec:access>
                <sec:access expression="hasRole('ROLE_ADMIN')">
                    <div class="col-md-12">
                        <h3>Recent Applications (Last 7 days) <span class="badge">${recentApplications.totalCount}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="recentTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                            <th class="text-center">Application Status</th>
                                            <sec:access expression="hasRole('ROLE_ADMIN')"><th class="text-center">Intake Status</th></sec:access>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${recentApplications}">
                                            <tr onclick='document.location = "<g:createLink controller="GenericApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.course.getCourseName()}</td>
                                                <td class="text-center">${application.applicantId.firstName  + " " + application.applicantId.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.applicationMade}"/></td>
                                                <td class="text-center">
                                                    <g:if test="${application.status.value == "Enrolled"}"><p class="bg-ll-success"><b>${application.status}</b></p></g:if>
                                                    <g:if test="${application.status.value == "Accepted"}"><p class="bg-ll-success">${application.status}</p></g:if>
                                                    <g:if test="${application.status.value == "Rejected"}"><p class="bg-ll-danger">${application.status}</p></g:if>
                                                    <g:if test="${application.status.value == "Withdrawn"}"><p class="bg-ll-danger">${application.status}</p></g:if>
                                                    <g:if test="${application.status.value == "Pending"}"><p class="bg-ll-warning">${application.status}</p></g:if>
                                                </td>
                                                <sec:access expression="hasRole('ROLE_ADMIN')">
                                                    <td class="text-center">
                                                        <g:if test="${application.contacted}"><p class="bg-ll-success">Contacted</p></g:if>
                                                        <g:else><p class="bg-ll-warning">Not Contacted</p></g:else>
                                                    </td>
                                                </sec:access>
                                            </tr>
                                        </g:each>
                                        <g:unless test="${recentApplications}">
                                            <tr>
                                                <td colspan="5" class="text-center">No new applications made in the last 7 days</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${recentApplications.totalCount > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="GenericApplication" action="list" params="[status:"recent"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function() {
                                $.tablesorter.themes.bootstrap = {
                                    table : 'table table-bordered table-condensed',
                                    iconSortNone : 'glyphicon glyphicon-chevron-down', // class name added to icon when column is not sorted
                                };

                                $('#recentTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });
                            });
                    </script>
                </sec:access>
                <sec:access expression="hasRole('ROLE_MANAGER')">
                    <div class="col-md-12">
                        <h3>Pending Applications <span class="badge">${pendingApplications.totalCount}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="pendingTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                            <th class="text-center">Rec. Letter</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${pendingApplications}">
                                            <tr onclick='document.location = "<g:createLink controller="GenericApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.course.getCourseName()}</td>
                                                <td class="text-center">${application.applicantId.firstName  + " " + application.applicantId.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.applicationMade}"/></td>
                                                <td class="text-center">
                                                    <g:if test="${application.course.recommendationRequired}">
                                                        <g:formatBoolean boolean="${application.recommendationReceived}" true="Yes" false="No" />
                                                    </g:if>
                                                    <g:else>N/A</g:else>
                                                </td>
                                            </tr>
                                        </g:each>
                                        <g:unless test="${pendingApplications}">
                                            <tr>
                                                <td colspan="4" class="text-center">No rejected applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${pendingApplications.totalCount > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="GenericApplication" action="list" params="[status:"pending"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <h3>Accepted Applications <span class="badge">${acceptedApplications.totalCount}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="acceptedTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                            <th class="text-center">Rec. Letter</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${acceptedApplications}">
                                            <tr onclick='document.location = "<g:createLink controller="GenericApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.course.getCourseName()}</td>
                                                <td class="text-center">${application.applicantId.firstName  + " " + application.applicantId.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.applicationMade}"/></td>
                                                <td class="text-center">
                                                    <g:if test="${application.course.recommendationRequired}">
                                                        <g:formatBoolean boolean="${application.recommendationReceived}" true="Yes" false="No" />
                                                    </g:if>
                                                    <g:else>N/A</g:else>
                                                </td>
                                            </tr>
                                        </g:each>
                                        <g:unless test="${acceptedApplications}">
                                            <tr>
                                                <td colspan="4" class="text-center">No accepted applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${acceptedApplications.totalCount > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="GenericApplication" action="list" params="[status:"accepted"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <h3>Rejected Applications <span class="badge">${rejectedApplications.totalCount}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="rejectedTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                            <th class="text-center">Rec. Letter</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${rejectedApplications}">
                                            <tr onclick='document.location = "<g:createLink controller="GenericApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.course.getCourseName()}</td>
                                                <td class="text-center">${application.applicantId.firstName  + " " + application.applicantId.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.applicationMade}"/></td>
                                                <td class="text-center">
                                                    <g:if test="${application.course.recommendationRequired}">
                                                        <g:formatBoolean boolean="${application.recommendationReceived}" true="Yes" false="No" />
                                                    </g:if>
                                                    <g:else>N/A</g:else>
                                                </td>
                                            </tr>
                                        </g:each>
                                        <g:unless test="${rejectedApplications}">
                                            <tr>
                                                <td colspan="4" class="text-center">No rejected applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${rejectedApplications.totalCount > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="GenericApplication" action="list" params="[status:"rejected"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-12">
                        <h3>Withdrawn Applications <span class="badge">${widthrawnApplications.totalCount}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="withdrawnTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                            <th class="text-center">Rec. Letter</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${widthrawnApplications}">
                                            <tr onclick='document.location = "<g:createLink controller="GenericApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.course.getCourseName()}</td>
                                                <td class="text-center">${application.applicantId.firstName  + " " + application.applicantId.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.applicationMade}"/></td>
                                                <td class="text-center">
                                                    <g:if test="${application.course.recommendationRequired}">
                                                        <g:formatBoolean boolean="${application.recommendationReceived}" true="Yes" false="No" />
                                                    </g:if>
                                                    <g:else>N/A</g:else>
                                                </td>
                                            </tr>
                                        </g:each>
                                        <g:unless test="${widthrawnApplications}">
                                            <tr>
                                                <td colspan="4" class="text-center">No rejected applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${widthrawnApplications.totalCount > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="GenericApplication" action="list" params="[status:"withdrawn"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    
                    
                    
                    <script>
                        $(document).ready(function() {
                                $.tablesorter.themes.bootstrap = {
                                    table : 'table table-bordered table-condensed',
                                    iconSortNone : 'glyphicon glyphicon-chevron-down', // class name added to icon when column is not sorted
                                };

                                $('#pendingTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });

                                $('#acceptedTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });

                                $('#rejectedTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });
                                 $('#withdrawnTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });
                            });
                    </script>
                </sec:access>
            </div>
            <div class="tab-pane fade" id="fieldSchool">
                <br />
                <sec:access expression="hasRole('ROLE_ADMIN')">
                    <div class="col-md-12">
                        <h3>${config.getInstance().courseName} Search</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <g:form name="courseSearchForm" controller="course">
                                    <div class="col-md-12">
                                        <label for="name">Search by:</label>
                                    </div>
                                    <div id="name">
                                        <div class="col-md-3 form-group">
                                            <g:select class="form-control" name="fieldSelect" from="${courseSearchTermSelect}" optionKey="key" optionValue="value"/>
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:select class="form-control" name="querySelect" from="${courseSearchQuerySelect}" optionKey="key" optionValue="value"/>
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:textField class="form-control required" name="searchTerms" placeholder="Search" />
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <g:hiddenField name="noDownload" value="${true}" />
                                            <g:actionSubmit class="btn btn-default submit-button-green pull-right" name="submitCourseSearch" value="Search" action="list" />
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </sec:access>
                <sec:access expression="hasRole('ROLE_ADMIN')"><div class="col-md-12"></sec:access>
                <sec:access expression="hasRole('ROLE_MANAGER')"><div class="col-md-8"></sec:access>
                    <h3>Overall Enrollment</h3>
                    <div class="panel panel-green-border">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-12">
                                    <g:form name="overallEnrollmentForm" controller="course">
                                        <div class="col-md-12">
                                            <label for="year">Select year:</label>
                                        </div>
                                        <div id="year" class="col-md-12">
                                            <div class="form-group">
                                                <g:select class="form-control" name="seasonSelect" from="${overallEnrollmentSelect}" optionKey="value" optionValue="${{it + "/" + ((it + 1) % 100) + " Season"}}"/>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <label for="fields">Select fields to include:</label>
                                        </div>
                                        <div id="fields">
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="selectAll" /> <b>Select All</b></label></div>
                                                    <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="allFieldSchools" /> <b>Include ${config.getInstance().courseNamePlural} I don't direct.</b></label></div>
                                       
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="panel panel-green-border panel-oe-boxes">
                                                    <div class="panel-body">
                                                        <div class="col-xs-12">
                                                            <p>Applicants:</p>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="applicants" /> Applicants</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="accepted" /> Accepted</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="pending" /> Pending</label></div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="rejected" /> Rejected</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="deposit" /> Deposit</label></div>
                                                            <div class="form-group checkbox"> <label class="check-group"><g:checkBox class="oe-group" name="tuition" /> Tuition</label></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="panel panel-green-border panel-oe-boxes">
                                                    <div class="panel-body">
                                                        <div class="col-xs-12">
                                                            <p>${config.getInstance().courseName}:</p>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="liabilityWaiver" /> Liability Waiver</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="userPermission" /> User Permission</label></div>
                                                            <g:if test="${hasAmericanSchool}"><div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="insuranceProof" /> Insurance Proof</label></div></g:if>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="capacity" /> Capacity</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="openSpots" /> Open spots</label></div>
                                                            <div class="form-group checkbox"><label class="check-group"><g:checkBox class="oe-group" name="graded" /> Graded</label></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <sec:access expression="hasRole('ROLE_ADMIN')">
                                            <div class="col-md-6 form-group">
                                                <g:actionSubmit class="btn btn-default submit-button-green pull-right admin-pg-btn" name="submitDownloadOverallEnrollment" value="Download Report" action="overallEnrollmentDownload" />
                                            </div>
                                            <div class="col-md-6 form-group">
                                                <g:actionSubmit class="btn btn-default submit-button-green pull-left admin-pg-btn" name="submitGenerateOverallEnrollment" value="Generate Report" action="overallEnrollment" />
                                            </div>
                                        </sec:access>
                                        <sec:access expression="hasRole('ROLE_MANAGER')">
                                            <div class="col-md-12 form-group text-center">
                                                <g:actionSubmit class="btn btn-default submit-button-green admin-pg-btn" name="submitGenerateOverallEnrollment" value="Generate Report" action="overallEnrollment" />
                                            </div>
                                        </sec:access>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <sec:access expression="hasRole('ROLE_MANAGER')">
                        <h3>Your ${config.getInstance().courseNamePlural}</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <div class="panel-field-schools">
                                    <div class="col-md-6">
                                        <label>Active:</label>
                                        <ul>
                                            <g:each var="course" in="${fieldSchoolList}">
                                                <li><g:link controller="course" action="show" id="${course.id}">${course.getCourseName()}</g:link></li>
                                            </g:each>
                                        </ul>
                                        <g:unless test="${fieldSchoolList}">
                                            <p>No courses assigned</p>
                                        </g:unless>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Archived:</label>
                                        <ul>
                                            <g:each var="course" in="${archivedFieldSchoolList}">
                                                <li><g:link controller="course" action="show" id="${course.id}">${course.getCourseName()}</g:link></li>
                                            </g:each>
                                        </ul>
                                        <g:unless test="${archivedFieldSchoolList}">
                                            <p>No archived courses</p>
                                        </g:unless>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </sec:access>
                </div>
                <sec:access expression="hasRole('ROLE_MANAGER')">
                    <script>
                        // get all the data from the controller
                        var applied = ${esAppliedApplicants};
                        var accepted = ${esAcceptedApplicants};
                        var pending = ${esPendingApplicants};
                        var rejected = ${esRejectedApplicants};
                        var withdrawn = ${esWithdrawnApplicants};
                        var male = ${esMales};
                        var female = ${esFemales};
                        var other = ${esOthers};
                        var deposit = ${esDeposit};
                        var tuition = ${esTuition};
                        var cap = ${esCourseCap};
                        var spaces = ${esRemainingSpaces};
                        var graded = ${esGraded};
                          
                        setTimeout(enrollmentSummary,2000);
                        
                        function enrollmentSummary() {
                            // get the index
                            var fs = document.getElementById("esFieldSchoolSelect");
                            var fsId = fs.options[fs.selectedIndex].value;

                            // put all the right numbers in
                            document.getElementById("esAppliedApplicants").innerHTML = applied[fsId];
                            document.getElementById("esAcceptedApplicants").innerHTML = accepted[fsId];
                            document.getElementById("esPendingApplicants").innerHTML = pending[fsId];
                            document.getElementById("esRejectedApplicants").innerHTML = rejected[fsId];
                            document.getElementById("esWithdrawnApplicants").innerHTML = withdrawn[fsId];
                            document.getElementById("esMaleApplicants").innerHTML = male[fsId];
                            document.getElementById("esFemaleApplicants").innerHTML = female[fsId];
                            document.getElementById("esOtherApplicants").innerHTML = other[fsId];
                            document.getElementById("esDepositsPaid").innerHTML = deposit[fsId];
                            document.getElementById("esTuitionsPaid").innerHTML = tuition[fsId];
                            document.getElementById("esCourseCap").innerHTML = cap[fsId];
                            document.getElementById("esCourseSpace").innerHTML = spaces[fsId];
                            document.getElementById("esGradedApplicants").innerHTML = graded[fsId];
                        }
                    </script>
                    <div class="col-md-4">
                        <h3>Enrollment Summary</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <div class="panel-enrollment-summary">
                                    <div class="col-md-12">
                                        <label for="course">Select ${config.getInstance().courseName}:</label>
                                    </div>
                                    <div id="course" class="col-md-12">
                                        <div class="form-group">
                                            <g:select class="form-control" name="esFieldSchoolSelect" from="${fieldSchoolList}" keys="${0..fieldSchoolList.size()-1}" optionKey="id" optionValue="${{it.getCourseName()}}" onchange="enrollmentSummary()"  />
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <table class="table table-hover table-condensed">
                                            <tbody>
                                                <tr>
                                                    <td>Applied</td>
                                                    <td id="esAppliedApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Approved</td>
                                                    <td id="esAcceptedApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Pending</td>
                                                    <td id="esPendingApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Rejected</td>
                                                    <td id="esRejectedApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Withdrawn</td>
                                                    <td id="esWithdrawnApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Males</td>
                                                    <td id="esMaleApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Females</td>
                                                    <td id="esFemaleApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Other</td>
                                                    <td id="esOtherApplicants"></td>
                                                </tr>
                                                <tr>
                                                    <td>Deposit</td>
                                                    <td id="esDepositsPaid"></td>
                                                </tr>
                                                <tr>
                                                    <td>Tuition</td>
                                                    <td id="esTuitionsPaid"></td>
                                                </tr>
                                                <tr>
                                                    <td>${config.getInstance().courseName} Capacity</td>
                                                    <td id="esCourseCap"></td>
                                                </tr>
                                                <tr>
                                                    <td>Remaining Spaces</td>
                                                    <td id="esCourseSpace"></td>
                                                </tr>
                                                <tr>
                                                    <td>Graded</td>
                                                    <td id="esGradedApplicants"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </sec:access>
            </div>
<%-- SCHOLARSHIPS --%>
            <sec:access expression="hasRole('ROLE_ADMIN')">
                <div class="tab-pane fade" id="scholarships">
                    <br />
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="panel panel-green-border admin-panel">
                                <div class="panel-body text-center">
                                    <h4>All Scholarship Applications:</h4>
                                    <h3>${allScholarshipApplications.totalCount}</h3>
                                    <g:link controller="scholarshipApplication" action="list" params="[status:"all"]">
                                        Show all &raquo;
                                    </g:link>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-green-border admin-panel">
                                <div class="panel-body text-center">
                                    <h4>This Season's Scholarship Applications:</h4>
                                    <h3>${seasonScholarshipApplications.totalCount}</h3>
                                    <%--<g:link controller="scholarshipApplication" action="list" params="[status:"season"]">
                                        Show all &raquo;
                                    </g:link>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-green-border admin-panel">
                                <div class="panel-body text-center">
                                    <h4>All Scholarships:</h4>
                                    <h3>${allScholarships.totalCount}</h3>
                                    <g:link controller="scholarship" action="index" params="[status:"all"]">
                                        Show all &raquo;
                                    </g:link>
                                </div>
                            </div>
                        </div>
                    </div>
                    <g:if test="${allScholarships.totalCount > 0}">
                    <div class="col-md-12">
                        <div class="col-md-4 col-md-offset-4">
                            <div class="panel panel-green-border">
                                <div class="panel-body text-center">
                                    <h4>Test Application Process:</h4>
                                    <g:link class="btn btn-lg submit-button-green" controller="scholarshipApplication" action="create" id="1">
                                        Apply Now
                                    </g:link>
                                </div>
                            </div>
                        </div>
                    </div>
                    </g:if>
                 
  
                   
                    
                </div>
            </sec:access>
            
            <%-- Manager Scholarship  --%>
            <sec:access expression="hasRole('ROLE_MANAGER')">
             
                <div class="tab-pane fade" id="scholarships">
                   
                    
            <div class="col-md-12">
                        <h3>Pending Applications <span class="badge">${pendingScholarships.size()}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="SpendingTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>Scholarship</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${pendingScholarships}">
                                            <tr onclick='document.location = "<g:createLink controller="scholarshipApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.scholarship.name}</td>
                                                <td class="text-center">${application.applicant.firstName  + " " + application.applicant.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.scholarshipMade}"/></td>
                                               
                                            </tr>
                                        </g:each>
                                        <g:unless test="${pendingScholarships}">
                                            <tr>
                                                <td colspan="4" class="text-center">No pending applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${pendingScholarships.size() > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="scholarshipApplication" action="list" params="[status:"pending"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <h3>Accepted Applications <span class="badge">${acceptedScholarships.size()}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="SacceptedTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                           
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${acceptedScholarships}">
                                            <tr onclick='document.location = "<g:createLink controller="scholarshipApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.scholarship.name}</td>
                                                <td class="text-center">${application.applicant.firstName  + " " + application.applicant.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.scholarshipMade}"/></td>
                                               
                                            </tr>
                                        </g:each>
                                        <g:unless test="${acceptedScholarships}">
                                            <tr>
                                                <td colspan="4" class="text-center">No accepted applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${acceptedScholarships.size() > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="scholarshipApplication" action="list" params="[status:"accepted"]"> 
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <h3>Rejected Applications <span class="badge">${rejectedScholarships.size()}</span></h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <table id="SrejectedTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th>${config.getInstance().courseName}</th>
                                            <th class="text-center">Name</th>
                                            <th class="text-center">Application Date</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each var="application" in="${rejectedScholarships}">
                                            <tr onclick='document.location = "<g:createLink controller="scholarshipApplication" action="show" id="${application.id}"></g:createLink>"'>
                                                <td>${application.scholarship.name}</td>
                                                <td class="text-center">${application.applicant.firstName  + " " + application.applicant.surname}</td>
                                                <td class="text-center"><g:formatDate format="MM/dd/yyyy" date="${application.scholarshipMade}"/></td>
                                                
                                            </tr>
                                        </g:each>
                                        <g:unless test="${rejectedScholarships}">
                                            <tr>
                                                <td colspan="4" class="text-center">No rejected applications</td>
                                            </tr>
                                        </g:unless>
                                    </tbody>
                                </table>
                                <g:if test="${rejectedScholarships.size() > maxShownOnIndex}">
                                    <p class="pull-right">
                                        <g:link controller="scholarshipApplication" action="list" params="[status:"rejected"]">
                                            Show all &raquo;
                                        </g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function() {
                                $.tablesorter.themes.bootstrap = {
                                    table : 'table table-bordered table-condensed',
                                    iconSortNone : 'glyphicon glyphicon-chevron-down', // class name added to icon when column is not sorted
                                };

                                $('#SpendingTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });

                                $('#SacceptedTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });

                                $('#SrejectedTable').tablesorter({
                                    dateFormat : "mmddyyyy",
                                    ignoreCase : true,
                                    theme : "bootstrap",
                                    widthFixed: true,
                                    showProcessing: true,
                                    headerTemplate : '{content} {icon}',
                                    widgets : [ "uitheme", "staticRow" ],
                                });
                            });
                    </script>
                     
                    
                   
                </div>
            
            
           
            
            
            
            </sec:access>
            
            
            
            
            
            
            
            
<%-- FEEDBACK --%>
            <div class="tab-pane fade" id="feedback">
                <br />
                <sec:access expression="hasRole('ROLE_ADMIN')">
                    <div class="col-md-12">
                        <h3>${config.getInstance().courseName} Feedback</h3>
                        <div class="panel panel-green-border">
                            <div class="panel-body">
                                <gvisualization:apiImport/>
                                <gvisualization:columnCoreChart elementId="ratingchart" title="Feedback" width="${900}" height="${300}" columns="${ratingColumns}" data="${ratingData}" />
                                <div class="col-md-10 col-md-offset-1" id="ratingchart"></div>
                                <table id="feedbackTable">
                                    <thead class="th-green">
                                        <tr>
                                            <th class="text-center" rowspan="2" style="width: 22%">Season</th>
                                            <th class="text-center" colspan="6">Average Ratings</th>
                                        </tr>
                                        <tr>
                                            <th class="text-center" style="width: 13%">Academic Challenge</th>
                                            <th class="text-center" style="width: 13%">Support</th>
                                            <th class="text-center" style="width: 13%">Housing</th>
                                            <th class="text-center" style="width: 13%">Fun</th>
                                            <th class="text-center" style="width: 13%">Safety</th>
                                            <th class="text-center" style="width: 13%">Overall</th>
                                        </tr>
                                    </thead>
                                    <tbody class="text-center">
                                        <g:each var="season" in="${courseYears}" status="i">
                                            <tr>
                                                <td>${season.key}</td>
                                                <td>${seasonAcademicsRating[i]}</td>
                                                <td>${seasonSupportRating[i]}</td>
                                                <td>${seasonHousingRating[i]}</td>
                                                <td>${seasonFunRating[i]}</td>
                                                <td>${seasonSafetyRating[i]}</td>
                                                <td>${seasonOverallRating[i]}</td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                    <!-- pager --> 
                                    <tfoot>
                                        <tr>
                                            <th colspan="9" class="ts-pager form-horizontal">
                                                <div class="col-md-4">
                                                    <button type="button" class="btn first"><i class="icon-step-backward glyphicon glyphicon-step-backward"></i></button>
                                                    <button type="button" class="btn prev"><i class="icon-arrow-left glyphicon glyphicon-backward"></i></button>
                                                    <span class="pagedisplay"></span> <!-- this can be any element, including an input -->
                                                    <button type="button" class="btn next"><i class="icon-arrow-right glyphicon glyphicon-forward"></i></button>
                                                    <button type="button" class="btn last"><i class="icon-step-forward glyphicon glyphicon-step-forward"></i></button>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="col-md-8">
                                                        <p class="form-control-static">Results per page:</p>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <select class="pagesize input-mini form-control" title="Select page size">
                                                            <option selected="selected" value="10">10</option>
                                                            <option value="20">20</option>
                                                            <option value="30">30</option>
                                                            <option value="40">40</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="col-md-8">
                                                        <p class="form-control-static">Page Number:</p>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <select class="pagenum input-mini form-control" title="Select page number"></select>
                                                    </div>
                                                </div>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                                <script>
                                    $(document).ready(function() {
                                        $.tablesorter.themes.bootstrap = {
                                            table : 'table table-bordered table-condensed',
                                            iconSortNone : 'glyphicon glyphicon-sort',
                                            iconSortAsc  : 'glyphicon glyphicon-sort-by-alphabet',
                                            iconSortDesc : 'glyphicon glyphicon-sort-by-alphabet-alt'
                                        };
                                        $("#feedbackTable").tablesorter({
                                            dateFormat : "mmddyyyy",
                                            ignoreCase : true,
                                            theme : "bootstrap",
                                            widthFixed: true,
                                            showProcessing: true,
                                            headerTemplate : '{content} {icon}',
                                            widgets : [ "uitheme", "staticRow" ],
                                        }).tablesorterPager({
                                            container: $(".ts-pager"),
                                            cssGoto  : ".pagenum",
                                            removeRows: false,
                                            output: '{startRow} - {endRow} of {totalRows}'
                                        });
                                    });
                                </script>
                                <div class="col-md-12">
                                    <g:link class="btn pull-right submit-button-green" controller="visualization" action="feedbackVis">View Feedback by ${config.getInstance().courseName}</g:link>
                                </div>
                            </div>
                        </div>
                    </div>
                </sec:access>
            </div>
    </body>
</html>