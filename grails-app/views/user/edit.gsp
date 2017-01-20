<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - Edit User</title>
    </head>
    <body>
        <g:form name="editUserForm">
            <div class="col-xs-12 text-center">
                <h1>Edit User</h1>
            </div>
            <ul class="nav nav-tabs">
                <li class="nav">
                    <sec:access expression="hasRole('ROLE_STUDENT')">
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
                <li class="nav active"><a href="#content" data-toggle="tab">Edit User</a></li>
                <li class="nav"><a class="ifr-save-tab"><span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span> <g:actionSubmit class="btn-masking-as-tab" name="updateUser" value="Save Changes" action="processEditUser" onclick="return confirm('Are you sure?')" /></a></li>
                <%-- SPLIT --%>
                <g:if test="${userInfo.isFaculty}"><li class="nav pull-right"><a class="ifr-save-tab" href="${createLink(controller:"faculty",action:"index")}"><span class="glyphicon glyphicon-education" aria-hidden="true"></span> All Faculty</a></li></g:if>
            </ul>
            <div class="tab-content">
                <g:if test="${flash.message}">
                    <%-- display an info message to confirm --%>
                    <div class="col-xs-12 text-center">
                        <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
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
                            ${flash.error}
                        </div>
                    </div>
                </g:if>
<%-- HOME --%>
<%-- CONTENT --%>
                <div class="tab-pane fade in active" id="content">
                    <br />
                    <div class="col-md-12">
                        <g:hiddenField name="id" value="${userInfo.id}" />
                        <div class="col-md-12">
                            <h3>User Information</h3>
                            <div class="panel panel-green-border">
                                <div class="panel-body">
                                    <div class="col-xs-3">
                                        <label for="username">Email</label>
                                        <div id="username">
                                            <div class="form-group">
                                                <g:textField class="form-control required" name="username" placeholder="Email Address" value="${userInfo.username}" />
                                            </div>
                                        </div>
                                    </div>
                                    <g:if test="${userLoggedIn == userInfo}">
                                        <div class="col-xs-3">
                                            <label for="password">New Password</label>
                                            <div id="password">
                                                <div class="form-group">
                                                    <g:passwordField name="password" class="form-control" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <label for="password">Re-Enter New Password</label>
                                            <div id="password">
                                                <div class="form-group">
                                                    <g:passwordField name="passwordDuplicate" class="form-control" />
                                                </div>
                                            </div>
                                        </div>
                                    </g:if>
                                    <sec:access expression="hasRole('ROLE_ADMIN')">
                                        <div class="col-xs-3">
                                            <label for="accountType">Account Type</label>
                                            <div id="accountType">
                                                <div class="form-group">
                                                    <g:select class="form-control required" name="accountTypeSelect" from="${accountTypeList}"
                                                            optionKey="key" optionValue="value" onchange="userAccountForm()" value="${currentAccountType}" />
                                                </div>
                                            </div>
                                        </div>
                                    </sec:access>
                                </div>
                            </div>
                        </div>
                        <%-- FACULTY PANEL --%>
                        <g:if test="${userInfo.faculty}">
                            <div id="facultyPanel" class="col-md-12">
                                <h3>Faculty Information</h3>
                                <div class="panel panel-green-border">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="col-md-12">
                                                    <label for="facultyName">Name</label>
                                                </div>
                                                <div id="facultyName">
                                                    <div class="col-md-4 form-group">
                                                        <g:select class="form-control required" name="title" from="${titleList}"
                                                        optionKey="key" optionValue="value" value="${userInfo.faculty.title}" />
                                                    </div>
                                                    <div class="col-md-4 form-group">
                                                        <g:textField class="form-control required" name="firstName" placeholder="First Name" value="${userInfo.faculty.firstName}" />
                                                    </div>
                                                    <div class="col-md-4 form-group">
                                                        <g:textField class="form-control required" name="surname" placeholder="Last Name" value="${userInfo.faculty.surname}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-md-12">
                                                    <label for="facultyUniversity">Institute</label>
                                                </div>
                                                <div id="facultyUniversity">
                                                    <div class="col-md-12 form-group">
                                                        <g:textField class="form-control required" name="university" placeholder="University or College" value="${userInfo.faculty.university}" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="col-md-12">
                                                    <label>Personal Phone Number</label>
                                                </div>
                                                <div>
                                                    <div class="form-group col-md-6">
                                                        <g:select class="form-control" name="personalPhoneCode" from="${countryList}" optionKey="name" optionValue="${{it.name + " +" + it.phoneCode}}" value="${userInfo.faculty.personalTelNumberCountry?.name}" noSelection="['': 'Select Country']" />
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <g:textField class="form-control" name="personalPhone" placeholder="Phone" value="${userInfo.faculty.personalTelNumber}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-md-12">
                                                    <label>Work Phone Number</label>
                                                </div>
                                                <div>
                                                    <div class="form-group col-md-6">
                                                        <g:select class="form-control" name="workPhoneCode" from="${countryList}" optionKey="name" optionValue="${{it.name + " +" + it.phoneCode}}" value="${userInfo.faculty.workTelNumberCountry?.name}" noSelection="['': 'Select Country']" />
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <g:textField class="form-control" name="workPhone" placeholder="Phone" value="${userInfo.faculty.workTelNumber}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="col-md-12">
                                                    <label>Phone Number in the Field</label>
                                                </div>
                                                <div>
                                                    <div class="form-group col-md-6">
                                                        <g:select class="form-control" name="fieldPhoneCode" from="${countryList}" optionKey="name" optionValue="${{it.name + " +" + it.phoneCode}}" value="${userInfo.faculty.fieldTelNumberCountry?.name}" noSelection="['': 'Select Country']" />
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <g:textField class="form-control" name="fieldPhone" placeholder="Phone" value="${userInfo.faculty.fieldTelNumber}" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <label>Address</label>
                                            </div>
                                            <div>
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <g:textField class="form-control" name="address1" placeholder="Address 1" value="${userInfo.faculty.address?.address1}" />
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <g:textField class="form-control" name="address2" placeholder="Address 2" value="${userInfo.faculty.address?.address2}" />
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <g:textField class="form-control" name="city" placeholder="City" value="${userInfo.faculty.address?.city}" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <g:textField class="form-control" name="state" placeholder="State" value="${userInfo.faculty.address?.state}" />
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <g:textField class="form-control" name="zip" placeholder="Zip or Pin Code" value="${userInfo.faculty.address?.zip}" />
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <g:select class="form-control" name="countrySelect" from="${countryList}" optionKey="id" optionValue="name" value="${userInfo.faculty.address?.country?.id}" noSelection="['': 'Select Country']" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <h3>Emergency Contact</h3>
                                <div class="panel panel-green-border">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="form-group col-md-2">
                                                <g:textField class="form-control" name="primaryContactName" placeholder="Name" value="${userInfo.faculty.primaryContact?.name}" />
                                            </div>
                                            <div class="form-group col-md-2">
                                                <g:textField class="form-control" name="primaryContactRelationship" placeholder="Relationship" value="${userInfo.faculty.primaryContact?.relationship}" />
                                            </div>
                                            <div class="form-group col-md-2">
                                                <g:textField class="form-control email" name="primaryContactEmail" placeholder="Email" value="${userInfo.faculty.primaryContact?.email}" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <div class="form-group col-md-6">
                                                    <g:select class="form-control" name="primaryContactPhoneCode" from="${countryList}" optionKey="name" optionValue="${{it.name + " +" + it.phoneCode}}" value="${userInfo.faculty.primaryContact?.telNumberCountry?.name}" noSelection="['': 'Select Country']" />
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <g:textField class="form-control" name="primaryContactPhone" placeholder="Phone" value="${userInfo.faculty.primaryContact?.telNumber}" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-4">
                                                <g:textField class="form-control" name="primaryContactAddress1" placeholder="Address 1" value="${userInfo.faculty.primaryContact?.address?.address1}" />
                                            </div>
                                            <div class="form-group col-md-4">
                                                <g:textField class="form-control" name="primaryContactAddress2" placeholder="Address 2" value="${userInfo.faculty.primaryContact?.address?.address2}" />
                                            </div>
                                            <div class="form-group col-md-4">
                                                <g:textField class="form-control" name="primaryContactCity" placeholder="City" value="${userInfo.faculty.primaryContact?.address?.city}" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-4">
                                                <g:textField class="form-control" name="primaryContactState" placeholder="State" value="${userInfo.faculty.primaryContact?.address?.state}" />
                                            </div>
                                            <div class="form-group col-md-4">
                                                <g:textField class="form-control" name="primaryContactZip" placeholder="Zip or Pin Code" value="${userInfo.faculty.primaryContact?.address?.zip}" />
                                            </div>
                                            <div class="form-group col-md-4">
                                                <g:select class="form-control" name="primaryContactCountry" from="${countryList}" optionKey="id" optionValue="name" value="${userInfo.faculty.primaryContact?.address?.country?.id}" noSelection="['': 'Select Country']" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                    </div>
                </div>
            </div>
        </g:form>
    </body>
</html>