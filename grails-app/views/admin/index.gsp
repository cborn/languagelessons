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
                <h1>Administrator Homepage: ${userInfo.faculty.name}</h1>
            </sec:access>
            <sec:access expression="hasRole('ROLE_FACULTY')">
                <h1>Faculty Homepage: ${userInfo.faculty.title} ${userInfo.faculty.name}</h1>
            </sec:access>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav active"><a class="ll-home-tab" href="#overview" data-toggle="tab"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            <li class="nav"><a href="#applicants" data-toggle="tab">Applicants</a></li>
            <li class="nav"><a href="#applications" data-toggle="tab">Applications</a></li>
            <li class="nav"><a href="#fieldSchool" data-toggle="tab">Courses</a></li>
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
                        <sec:access expression="hasRole('FACULTY')"    >
                            <div class="col-md-12">
                                <g:if test="${userInfo.faculty.title == 'None'}">
                                    <p>Welcome,</p>
                                </g:if>
                                <g:elseif test="${userInfo.faculty.title != 'None'}">
                                       <p>Welcome ${userInfo.faculty.title} ${userInfo.faculty.surname},</p> 
                                </g:elseif>
                                <p>You can look up enrollment data for the **** you are currently assigned to as an instructor here. You will only be able to access the data for applicants applying to or currently enrolled in your program.</p>
                                <p>If you have any questions or concerns, contact us by email <a href="mailto:****">****</a>, or by phone at ****.</p>
                            </div>
                            <div class="col-md-12" style="padding-top: 20px">
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Accepted Applications:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Pending Applications:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Rejected Applications:</h4>
                                                Show all &raquo;
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
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Pending Applications:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>Rejected Applications:</h4>
                                                Show all &raquo;
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
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>This Season's Applications:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All Users:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All Courses:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>This Season's Schools:</h4>
                                                Show all &raquo;
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-green-border admin-panel">
                                        <div class="panel-body text-center">
                                            <h4>All Faculty:</h4>
                                                Show all &raquo;
                                        </div>
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

                            </div>
                        </div>
                    </div>
                </sec:access>
                <div class="col-md-12">
                    <h3>Applicant Information Report</h3>
                    <div class="panel panel-green-border">
                        <div class="panel-body">
                            <div class="col-xs-12">
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>           
        </div>             
    </body>
</html>