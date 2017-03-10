<br>${(question.questionNum)}: ${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)<br>
<g:radioGroup name="${question.questionNum}" labels="${question.answers}" values="${0..(question.answers.size()-1)}">
    ${it.radio} ${it.label} <br>
</g:radioGroup>
