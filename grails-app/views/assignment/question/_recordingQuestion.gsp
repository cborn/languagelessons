<div class="panel panel-default" id="${question.id}panel">
    <div class="panel-heading">
        ${question.question} (${question.pointValue} point<g:if test="${question.pointValue > 1}">s</g:if>)<span id="${question.id}reqReview"></span>
    </div>
    <div class="panel-body">
        <div id="viz">
            <canvas id="analyser" width="1024" height="500"></canvas>
            <canvas id="wavedisplay" width="1024" height="500"></canvas>
	</div>
	<div id="controls">
            <asset:image id="record" src="mic128.png" onclick="toggleRecording(this);"/>
            <!--<g:link role="button" controller="recording" action="play">Play Audio</g:link>-->
	</div>
        
        <h3>Recordings</h3>
        <div id="recording-list"></div>
        <div id="modal-progress" class="modal fade">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
                        <div class="progress">
                            <div style="width: 0%;" class="progress-bar"></div>
                        </div>
                        <div class="text-center">0%</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" data-dismiss="modal" class="btn">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="${question.id}studentAnswer"></div>
        <div id="${question.id}changeGrade">
        </div>
        <script id="${question.id}changeGradeSource" type="text/html">
            <div class="input-group">
                <input type="text" class="form-control" id="${question.id}newPoints" placeholder="0 - ${question.pointValue}" aria-describedby="basic-addon1"></input>
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="button" onclick="prepChangeGrade${question.id}()">Change Grade</button>
                </span>
            </div>
        </script>
        <script id="${question.id}reqReviewSource" type="text/html">
            <span class="alert alert-warning">Requires Review</span>
        </script>
        <asset:javascript src="main.js"/>
        <asset:javascript src="recorder.js"/>
        <asset:javascript src="audiodisplay.js"/>
        <script>
            initAudio()
            function prepChangeGrade${question.id}() {
                console.log("#${question.id}newPoints");
                var newPoints = $( "#${question.id}newPoints" ).val();
                console.log(newPoints);
                changeGrade(${question.id}, newPoints);
            }
            function getValue() {
                var answer = $( "#${question.id}answer" ).val();
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
                var text = "Student answered " + (answer);
                var text = text + ", was rewarded " + points + " points";
                $( "#${question.id}studentAnswer" ).html(text);
                var changeGradeSource = $( "#${question.id}changeGradeSource" ).html();
                $( "#${question.id}changeGrade" ).html(changeGradeSource);
            }
            displayRegistry[${question.oldId}] = displayResult
        </script>
    </div>
</div>