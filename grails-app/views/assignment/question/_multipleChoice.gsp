<br>${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)<br>
<g:set var="answerNum" value="${0}"/>
<g:radioGroup name="${question.id}radioGroup" labels="${question.answers}" values="${0..(question.answers.size()-1)}">
    <div>${it.radio} ${it.label}</div>
    <g:set var="answerNum" value="${answerNum + 1}"/>
    <br>
</g:radioGroup>
<script>
    function getValue() {
        var answer = $("input:radio[name ='${question.id}radioGroup']:checked").val();
        return answer;
    }
    valueRegistry[${question.oldId}] = getValue
</script>
