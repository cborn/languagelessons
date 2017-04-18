<br>${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)<br>
<g:set var="answerNum" value="${0}"/>
<g:radioGroup name="${question.questionNum}" labels="${question.answers}" values="${0..(question.answers.size()-1)}">
    <g:if test="${answer != null}">
        <g:if test="${question.correctAnswer == answerNum}">
            <div class="correct">${it.radio} ${it.label}</div>
        </g:if>
        <g:else>
            <g:if test="${Integer.parseInt(answer) == answerNum}">
                <div class="incorrect">${it.radio} ${it.label}</div>
            </g:if>
            <g:else>
                <div>${it.radio} ${it.label}</div>
            </g:else>
        </g:else>
    </g:if>
    <g:else>
        <div>${it.radio} ${it.label}</div>
    </g:else>
    <g:set var="answerNum" value="${answerNum + 1}"/>
    <br>
</g:radioGroup>
