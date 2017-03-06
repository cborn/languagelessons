<br>${question.question}<br>
<g:each status="i" in="${question.answers}" var="answer">
    ${i + 1}: <g:radio name="${question.id}" value="${i}"/>&nbsp ${answer}<br>
</g:each>
