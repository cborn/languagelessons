<div id="viz">
    <canvas id="analyser" width="500" height="250" style="background: #000;"></canvas>
    <div id="controls">
        <asset:image id="record" src="recordingButton.png" onclick="toggleRecording(this, ${question.id});"/>
    </div>
    <div id="waveform${question.id}"></div>
    <div style="align-content: center">
        <asset:image onclick="waveSurferRegistry[${question.id}].play()" src="playButton.jpg"/>
        <asset:image onclick="waveSurferRegistry[${question.id}].pause()" src="pauseButton.jpg"/>
    </div>
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
<asset:javascript src="wavesurfer.js"/>
<asset:javascript src="main.js"/>
<asset:javascript src="recorder.js"/>
<asset:javascript src="lame.min.js"/>
<script>
    initAudio()
    function getValue() {
        return recorderDataRegistry[${question.id}];
    }
    valueRegistry[${question.oldId}] = getValue
    function finishDisplay${question.id}(answer, points) {
        var html = $( "#${question.id}studentAnswerSource" ).html().replace('AUDIO_HERE', answer);
        $( "#${question.id}studentAnswer" ).html(html);
    }
    var wavesurfer = WaveSurfer.create({
        container: '#waveform${question.id}',
        interact: true
    });
    waveSurferRegistry[${question.id}] = wavesurfer;
</script>