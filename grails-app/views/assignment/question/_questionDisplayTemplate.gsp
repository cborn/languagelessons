<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<div class="panel panel-default" id="${question.id}panel">
    <div class="panel-heading">
        ${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)<span id="${question.id}reqReview"></span>
    </div>
    <div class="panel-body">
        <!--this is where the actual question goes-->
        <g:render template="question/${question.view}" model="['params': params]"/>
        <!--done-->
        <div id="${question.id}studentAnswer"></div>
        <div id="${question.id}changeGrade"></div>
        <div id="${question.id}commentSection"></div>
    </div>
</div>
<!--The HTML used for the comment section.-->
<script id="${question.id}commentSectionSource" type="text/html">
    <button class="btn btn-default" onclick="openComments${question.id}()">View Comment Thread<span class="caret"></span></button>
    <div id="${question.id}comments"></div>
</script>
<!--The HTML used for changing grades. Common to all questions.-->
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
<!--The HTML used for alerting the grader that this requires review. Common to all questions.-->
<script id="${question.id}reqReviewSource" type="text/html">
    <span class="alert alert-warning">Requires Review</span>
</script>
<!--Javascripts for all questions-->
<script type="text/javascript">
    function prepChangeGrade${question.id}() {
        var newPoints = $( "#${question.id}newPoints" ).val();
        console.log(newPoints);
        changeGrade(${question.id}, newPoints);
    }
    function clearResult() {
        $( "#${question.id}panel" ).removeClass("panel-success");
        $( "#${question.id}panel" ).removeClass("panel-danger");
        $( "#${question.id}panel" ).removeClass("panel-warning");
        $( "#${question.id}panel" ).addClass("panel-default");
        $( "#${question.id}studentAnswer" ).html("");
        $( "#${question.id}changeGrade" ).html("");
        $( "#${question.id}reqReview" ).html("");
        $( "#${question.id}commentSection" ).html("");
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
        var changeGradeSource = $( "#${question.id}changeGradeSource" ).html();
        $( "#${question.id}changeGrade" ).html(changeGradeSource);
        var commentSectionSource = $( "#${question.id}commentSectionSource" ).html();
        $( "#${question.id}commentSection" ).html(commentSectionSource);
        finishDisplay${question.id}(answer, points);
    }
    commentsOpen[${question.id}] = false;
    function openComments${question.id}() {
        if (commentsOpen[${question.id}]) {
            $( "#${question.id}comments" ).html("");
            commentsOpen[${question.id}] = false;
            return;
        }
        jQuery.ajax({
            type: "POST",
            url: "${createLink(action: 'getComments')}",
            data: {resultId: currentResultId, questionId: ${question.oldId}},
            success: function (data) {
                commentsOpen[${question.id}] = true;
                $( "#${question.id}comments" ).html(data);
            },
        });
    }
    function refreshComments${question.id}() {
        jQuery.ajax({
            type: "POST",
            url: "${createLink(action: 'getComments')}",
            data: {resultId: currentResultId, questionId: ${question.oldId}},
            success: function (data) {
                commentsOpen[${question.id}] = true;
                $( "#${question.id}comments" ).html(data);
            },
        });
    }
    refreshCommentsRegistry[${question.id}] = refreshComments${question.id};
    displayRegistry[${question.oldId}] = displayResult
</script>