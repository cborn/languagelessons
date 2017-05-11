<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<div class="panel panel-warning">
    <div class="panel-body">
        <g:if test="${!comments}">
            <p>No comments yet, sorry!</p>
        </g:if>
        <g:else>
            <g:each in="${comments.sort{it.posted}}" var="comment">
                <g:render template="comment/commentTemplate" model="['comment':comment]"/>
            </g:each>
        </g:else>
        <div id="${qResult.id}-thread-main"></div>
        <button id="${qResult.id}-thread-toggle" class="btn btn-default" onclick="toggle('${qResult.id}','thread')">Post a Comment</button>
    </div>
</div>
<script type="text/html" id="commentBoxSource">
    <div class="input-group">
        <div class="input-group-addon">
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                    <span id="{RESULT_ID}-{COMMENT_ID}-curSel">${Comment.types[0].displayName}</span>
                    <span class="caret"></span>
                </button>
                <div class="dropdown-menu">
                    <g:each in="${Comment.types}" var="type">
                        <li class="dropdown-item">
                            <button class="btn btn-link" onclick="select('${type.displayName}','${type.view}', '${type.buildView}','{RESULT_ID}', '{COMMENT_ID}')">
                                ${type.displayName}
                            </button>
                        </li>
                    </g:each>
                </div>
            </div>
        </div>
        <span id="{RESULT_ID}-{COMMENT_ID}-buildArea">
            <g:render template="comment/${Comment.types[0].buildView}"/>
        </span>
        <span class="input-group-addon">
            <button class="btn btn-primary" onclick="post('{RESULT_ID}', '{COMMENT_ID}')">Post</button>
        </span>
    </div>
</script>
<g:each in="${Comment.types}" var="type">
    <script id="${type.buildView}" type="text/html">
        <g:render template="comment/${type.buildView}"/>
    </script>
</g:each>
<asset:javascript src="comments.js"/>