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
<script id="${question.id}studentAnswerSource" type="text/html">
    <audio controls>
        <source src="AUDIO_HERE"/>
    </audio>
</script>
<asset:javascript src="main.js"/>
<asset:javascript src="recorder.js"/>
<asset:javascript src="audiodisplay.js"/>
<script>
    initAudio()
    function getValue() {
        return recorderData;
    }
    valueRegistry[${question.oldId}] = getValue
    function finishDisplay${question.id}(answer, points) {
        var html = $( "#${question.id}studentAnswerSource" ).html().replace('AUDIO_HERE', answer);
        $( "#${question.id}studentAnswer" ).html(html);
    }
</script>