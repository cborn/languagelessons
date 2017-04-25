<div class="panel panel-default" id="${question.id}panel">
    <div class="panel-heading">
        ${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)
    </div>
    <div class="panel-body">
        <g:set var="answerNum" value="${0}"/>
        <g:radioGroup name="${question.id}radioGroup" labels="${question.answers}" values="${0..(question.answers.size()-1)}">
            <div>${answerNum + 1}: ${it.radio} ${it.label}</div>
            <g:set var="answerNum" value="${answerNum + 1}"/>
            <br>
        </g:radioGroup>
        <div id="${question.id}studentAnswer"></div>
        <script>
            function getValue() {
                var answer = $("input:radio[name ='${question.id}radioGroup']:checked").val();
                return answer;
            }
            valueRegistry[${question.oldId}] = getValue
            function clearResult() {
                $( "#${question.id}panel" ).removeClass("panel-success");
                $( "#${question.id}panel" ).removeClass("panel-danger");
                $( "#${question.id}panel" ).removeClass("panel-warning");
                $( "#${question.id}panel" ).addClass("panel-default");
                $( "#${question.id}studentAnswer" ).html("");
            }
            clearRegistry.push(clearResult);
            function displayResult(answer, points, status) {
                $( "#${question.id}panel" ).removeClass("panel-default");
                if (status == 'graded') {
                    if (points != 0) {
                        $( "#${question.id}panel" ).addClass("panel-success");
                    } else {
                        $( "#${question.id}panel" ).addClass("panel-danger");
                    }
                } else if (status == 'awaitReview') {
                    $( "#${question.id}panel" ).addClass("panel-warning");
                }
                var text = "Student answered " + (answer + 1);
                var text = text + ", was rewarded " + points + " points";
                $( "#${question.id}studentAnswer" ).html(text);
            }
            displayRegistry[${question.oldId}] = displayResult
        </script>
    </div>
</div>
