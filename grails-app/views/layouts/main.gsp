<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta charset="utf-8">
   	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title><g:layoutTitle default="IFR"/></title>
        <asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
        <asset:stylesheet src="application.css"/>
        <asset:stylesheet src="ll.css"/>
       
       <style rel="stylesheet">

           #results { 
           overflow:auto;
                height: 250px;
                background-color: #F5F5F5;
                position: absolute;
                left: 70px;
                top: 47px;
                z-index: 1;
           
           }
           
           .search-row { 
           
                border-bottom : 1px solid #dddddd;
                padding:10px;
           
            }
           
           
           .search-row > a {
           color:black;
           text-decoration: none;
            
           }
           
           
           .search-row > a > h6{
           
               float: left;
                margin-top: 4px;
           
           }
           
           .search-row > a > span{
           
                font-size: 11px;
                padding: 11px;
           
           }
           
           
           
             .search-row > a:hover { 
           
              text-decoration: none;
              
              color:#8C8C8C;
              
           }
           
         
           
           
           
           
           
           </style>
           

        <asset:javascript src="moment.js"/>
        <!-- these include the others, hence we had duplicate loading before -->
        <asset:javascript src="application.js"/>
        <asset:stylesheet src="application.css"/>
        <asset:javascript src="jquery.validate.js"/>
        <asset:javascript src="validation.js"/>
        
        
        
        <script>
            
            
            
            
            function checkSession()
            {
            
            res = $.ajax({
              url: window.location.href,
               
              complete: function(xhr, textStatus) {
                    
                       
                     if(xhr.status == 401)
                    {
                         $("#sessionNotice").show();
                    }
                    else
                    {
                     $("#sessionNotice").hide();
                     }
               } 
              
              
              });
                
                 
                
                
                
                  setTimeout(checkSession,15000);
                
            }
            
            
$(window).load(function(){
 $("#sessionNotice").hide();

 setTimeout(checkSession,1000);

var isLoading = false;
var shouldDoSearch = false;

        
 $('#results').hide();

        function searchUrl(query)
        {
        
            return window.location.origin + "/user/search?query="+query;
        
        
        }





        $('#search').keyup(search);
        
        
        function search(){
        
            var searchField = $('#search').val();
            
            
            if(searchField.length > 0 && !isLoading)
            {
                
                
                isLoading = true;
                
                
                
        
             $('#results').show();
    
            
            
            var regex = new RegExp(searchField, "i");
             var count = 1;
             var output = "";
            $.getJSON(searchUrl(searchField), function(data) {
            
            $.each(data, function(key, val){
                
                
               
                if(val.title != undefined)
                {
                  output += "<div class='search-row'>";                    
                       output += "<a href='"+window.location.origin + val.url+"'>";
                            output += "<h6>"+val.title+"</h6>";
                            output += "<span>"+val.subtitle+"</span>";
                       output += "</a>";
                  output +="</div>";
                }
                
                
                
                
                
                
              });
              $('#results').html(output);
              
              
                isLoading = false;
              
              
              if(shouldDoSearch)
              {
              shouldDoSearch = false;
              search();
              
              }
              
              
            });

            }
            else if(isLoading)
            {
            	shouldDoSearch = true;
            
            
            }else
            {
            
        
 $('#results').hide();
}
        }
        
        
        
      });

            <g:tabSave />
            </script>
        

<!--        <asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
        <asset:javascript src="jquery.validate.js"/>
        <asset:stylesheet src="application.css"/>
        <asset:stylesheet src="ll.css"/>
        <asset:javascript src="jquery.tablesorter.min.js" />
        <asset:javascript src="jquery.tablesorter.staticrow.min.js" />
        <asset:javascript src="jquery.tablesorter.pager.min.js" />
        <asset:javascript src="jquery.tablesorter.widgets.js" />-->
        <!-- CSS not loading; might be ok in production -->
        <asset:stylesheet src="ll.css"/>
        <asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
        

        <g:layoutHead/>
    </head>
    <body>
        <noscript id="noscript-warning" class="col-md-12">
            Lanague Lessons works best with JavaScript enabled 
        </noscript>
        <div id="sessionNotice" style="display:none;position: fixed;width: 100%;top: 6%;height: 100%;z-index: 9;background-color: rgba(0, 0, 0, 0.22);">
            <div id="sessionDied" style="position: fixed;top: 50%;left: 38%;z-index: 10;">
                <div class="alert alert-danger alert-dismissible" role="alert" style="display: block; margin-top: 5px;">

                        <h1>Your session has expired</h1>

                </div>

            </div>
        </div>
        
        
        <nav class="navbar navbar-inverse" id="menu-bar">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                     <sec:access expression="hasRole('ROLE_STANDARD')">
                                    <g:link  class="navbar-brand" controller="student" action="index">LL</g:link>
                                </sec:access>
                                <sec:access expression="hasRole('ROLE_FACULTY')">
                                    <g:link  class="navbar-brand" controller="admin" action="index">LL</g:link>
                                </sec:access>
                                <sec:access expression="hasRole('ROLE_ADMIN')">
                                    <g:link  class="navbar-brand" controller="admin" action="index">LL</g:link>
                                </sec:access>
                    
                    
                    
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <div class="center-block">
                        <ul class="nav navbar-nav"><%--
                            <li> 
                                <sec:access expression="hasRole('ROLE_STANDARD')">
                                    <g:link controller="student" action="index">Home</g:link>
                                </sec:access>
                                <sec:access expression="hasRole('ROLE_FACULTY')">
                                    <g:link controller="admin" action="index">Home</g:link>
                                </sec:access>
                                <sec:access expression="hasRole('ROLE_ADMIN')">
                                    <g:link controller="admin" action="index">Home</g:link>
                                </sec:access>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Programs <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><g:link uri="">Link</g:link></li>
                                </ul>
                            </li>
                            
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Students <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <g:link controller="student" action="index">
                                            <sec:ifNotLoggedIn>Student Log In</sec:ifNotLoggedIn>
                                            <sec:ifLoggedIn>
                                                <sec:access expression="hasRole('ROLE_STANDARD')">Student Homepage</sec:access>
                                                <sec:access expression="hasRole('ROLE_FACULTY')">Student Log In</sec:access>
                                                <sec:access expression="hasRole('ROLE_ADMIN')">Student Log In</sec:access>
                                            </sec:ifLoggedIn>
                                        </g:link>
                                    </li>
                                </ul>
                            </li>
                            --%><%--<li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Parents <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><g:link uri="">Link</g:link></li>
                                </ul>
                            </li>
                            --%><%--<li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Academics <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <g:link controller="admin" action="index">
                                            <sec:ifNotLoggedIn>Faculty Log In</sec:ifNotLoggedIn>
                                            <sec:ifLoggedIn>
                                                <sec:access expression="hasRole('ROLE_STANDARD')">Faculty Log In</sec:access>
                                                <sec:access expression="hasRole('ROLE_FACULTY')">Faculty Homepage</sec:access>
                                                <sec:access expression="hasRole('ROLE_ADMIN')">Faculty Homepage</sec:access>
                                            </sec:ifLoggedIn>
                                        </g:link>
                                    </li>
                                </ul>
                            </li>
                            
                            
                            
                            --%>
                            
                               <sec:access expression="hasRole('ROLE_ADMIN')">
                            
                        <g:form class="navbar-form navbar-left" role="search" action="searchResults" controller="User">
                            <div class="form-group">
                              
                                <input type="text" class="form-control" name="query" id="search" placeholder="Search" autocomplete="off"/>
                                    <div id="results">
            
                                    </div>
                                    
                           
                            </div>
                        </g:form>
                         </sec:access>
                            <li>
                                <sec:ifNotLoggedIn><g:link controller="user" action="index">Apply Now</g:link></sec:ifNotLoggedIn>
                                <sec:ifLoggedIn><g:link controller="studentApplication" action="index">Apply Now</g:link></sec:ifLoggedIn>
                            </li>
                            <li>
                                <g:link uri="/faq">FAQs</g:link>
                            </li>
                            <li>
	                            <sec:ifSwitched> 
	    							<a href='${request.contextPath}/logout/impersonate'> 
	        							Resume as <sec:switchedUserOriginalUsername/> 
	    							</a> 
								</sec:ifSwitched>
                            </li>
                        </ul>
                        
                     
        
                       
                        <ul class="nav navbar-nav navbar-right">
                            <form class="navbar-form" role="search">
                                <a href="#" id="beta-button" class="btn btn-sm btn-custom disabled">

                                    <i class="glyphicon glyphicon-wrench"></i> v0.1

                                </a>
                            </form>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <sec:ifLoggedIn>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <sec:loggedInUserInfo field="username"/> <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <sec:access expression="hasRole('ROLE_STUDENT')">
                                                <g:link controller="student" action="index">Homepage</g:link>
                                            </sec:access>
                                            <sec:access expression="hasRole('ROLE_FACULTY')">
                                                <g:link controller="admin" action="index">Homepage</g:link>
                                            </sec:access>
                                            <sec:access expression="hasRole('ROLE_ADMIN')">
                                                <g:link controller="admin" action="index">Homepage</g:link>
                                            </sec:access>
                                        </li>
                                        <li><g:link controller="logout">Log Out</g:link></li>
                                    </ul>
                                </li>
                            </sec:ifLoggedIn>
                        </ul>
                    </div>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

        <%--<sec:access expression="hasRole('ROLE_ADMIN')">
            <div class="col-md-2 side-menu-bar">
                <%-- side menu -- %>
                <h3>Quick Menu</h3>
                <ul class="list-unstyled">
                    <li>Home</li>
                    <li>All Applications</li>
                    <li>All Field Schools</li>
                    <li>All Users</li>
                    <ul>
                        <li>All Faculty</li>
                        <li>All Students</li>
                    </ul>
                </ul>
            </div>
            <div class="col-md-10">
                <!-- main body --> 
                <div class="container-fluid">
                    <g:layoutBody/>
                    <div class="footer" role="contentinfo"></div>
                    <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
                </div>
            </div>
        </sec:access>
        <sec:ifNotGranted roles='ROLE_ADMIN'>
            <div class="col-md-12">--%>
                <!-- main body --> 
                <div class="container-fluid">
                    <g:layoutBody/>
                    <div class="footer" role="contentinfo"></div>
                    <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
                </div>
            </div>
        <%--</sec:ifNotGranted>--%>
        <!-- inlcude these here to make sure they run after page loaded --> 
        <asset:javascript src="validation.js"/>
<!--        <asset:javascript src="tablesorter.js"/>-->

    </body>
</html>
