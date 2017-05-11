<div class="panel panel-warning">
    <div class="panel-heading">${comment.author.username} at ${comment.posted}</div>
    <div class="panel-body">
        <g:render template="comment/${comment.view}" model="['params': params]"/>
        <g:if test="${comment.replies}">
            <g:each in="${comment.replies.sort{it.posted}}" var="reply">
                <g:render template="comment/commentTemplate" model="['comment': reply]"/>
            </g:each>
        </g:if>
        <div id="${qResult.id}-${comment.id}-main"></div>
        <button id="${qResult.id}-${comment.id}-toggle" class="btn btn-link" onclick="toggle('${qResult.id}','${comment.id}')">Reply</button>
    </div>
</div>
