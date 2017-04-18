<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <title>Language Lessons - Users</title>
    </head>
    <body>
        <div class="col-md-12 text-center">
            <h1>Search</h1>
        </div>
        <ul class="nav nav-tabs">
            <li class="nav"><a class="ll-home-tab" href="${createLink(controller:'admin', action:'index')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
            
            <li class="nav active"><a href="#content" data-toggle="tab">Users</a></li>
       
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
                    
                    <table id="sortableTable">
                        <thead class="th-green">
                            <tr>
                                <%--<g:sortableColumn params="${params}" class="text-center" property="username" defaultOrder="desc" title="Email &#9650;&#9660;" />--%>
                                <th class="text-center">Name</th>
                                <th class="text-center">Type</th>
                                <th class="text-center">Go</th>
                                
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <g:each var="res" in="${results}" status="i">
                             
                                <tr onclick="window.location.href='${res.url}'">
                                    
                                    <td class="user-col">
                                     <a href="${res.url}">  ${res.title}   
                                    </td>
                                    <td class="user-col">
                                          <a href="${res.url}">  ${res.subtitle}  </a>  
                                    </td>
                                    <td class="user-col">
                                   
                                        <input type="button" class="btn btn-success" value="Go" onclick="window.location.href='${res.url}'"/>
                                    
                                    </td> 
                                 
                                </tr>
                              
                            </g:each>
                            <g:unless test="${results}">
                                <tr>
                                    <td colspan="9">No Results found</td>
                                </tr>
                            </g:unless>
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
                </div>
            </div>
        </div>
    </body>
</html>