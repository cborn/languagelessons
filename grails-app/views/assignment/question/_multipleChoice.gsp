<div class="panel panel-default" id="${question.id}panel">
    <div class="panel-heading">
        ${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)<span id="${question.id}reqReview"></span>
    </div>
    <div class="panel-body">
        <g:set var="answerNum" value="${0}"/>
        <g:radioGroup name="${question.id}radioGroup" labels="${question.answers}" values="${0..(question.answers.size()-1)}">
            <div>${answerNum + 1}: ${it.radio} ${it.label}</div>
            <g:set var="answerNum" value="${answerNum + 1}"/>
            <br>
        </g:radioGroup>
        <div id="${question.id}studentAnswer"></div>
        <div id="${question.id}changeGrade">
        </div>
        <script id="${question.id}changeGradeSource" type="text/html">
            <div class="input-group">
                <input type="text" class="form-control" id="${question.id}newPoints" placeholder="0 - ${question.pointValue}" aria-describedby="basic-addon1"></input>
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" onclick="prepChangeGrade${question.id}()">Change Grade</button>
                </span>
                <span class="input-group-btn">
                    <button class="btn btn-warning" type="button" onclick="flagForReview(${question.id})">Flag For Review</button>
                </span>
            </div>
        </script>
        <script id="${question.id}reqReviewSource" type="text/html">
            <span class="alert alert-warning">Requires Review</span>
        </script>
        <script>
            function prepChangeGrade${question.id}() {
                var newPoints = $( "#${question.id}newPoints" ).val();
                console.log(newPoints);
                changeGrade(${question.id}, newPoints);
            }
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
                $( "#${question.id}changeGrade" ).html("");
                $( "#${question.id}reqReview" ).html("");
            }
            clearRegistry.push(clearResult);
            function displayResult(answer, points, status) {
                $( "#${question.id}panel" ).removeClass("panel-default");
                if (status == 'graded') {
                    if (points == ${question.pointValue}) {
                        $( "#${question.id}panel" ).addClass("panel-success");
                    } else if (points == 0) {
                        $( "#${question.id}panel" ).addClass("panel-danger");
                    } else {
                        $( "#${question.id}panel" ).addClass("panel-warning");
                    }
                } else if (status == 'awaitReview') {
                    $( "#${question.id}panel" ).addClass("panel-warning");
                    $( "#${question.id}reqReview" ).html( $( "#${question.id}reqReviewSource" ).html());
                }
                var text = "Student answered " + (answer + 1);
                var text = text + ", was rewarded " + points + " points";
                $( "#${question.id}studentAnswer" ).html(text);
                var changeGradeSource = $( "#${question.id}changeGradeSource" ).html();
                $( "#${question.id}changeGrade" ).html(changeGradeSource);
            }
            displayRegistry[${question.oldId}] = displayResult
        </script>
    </div>
</div>
