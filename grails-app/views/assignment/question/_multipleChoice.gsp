<g:set var="answerNum" value="${0}"/>
<g:radioGroup name="${question.id}radioGroup" labels="${question.answers}" values="${0..(question.answers.size()-1)}">
    <div>${answerNum + 1}: ${it.radio} ${it.label}</div>
    <g:set var="answerNum" value="${answerNum + 1}"/>
    <br>
</g:radioGroup>
<script>
    function getValue() {
        var answer = $("input:radio[name ='${question.id}radioGroup']:checked").val();
        return answer;
    }
    valueRegistry[${question.oldId}] = getValue
    function finishDisplay${question.id}(answer, points) {
        var text = "Student answered " + (answer + 1);
        var text = text + ", was rewarded " + points + " points";
        $( "#${question.id}studentAnswer" ).html(text);
    }
</script>