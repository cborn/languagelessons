<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<div id="controls">
    <asset:image id="record" src="mic128.png" onclick="toggleRecording(this,'{COMMENT_ID}');"/>
</div>
{ASSET_OPEN}/assets/main.js{ASSET_CLOSE}
{ASSET_OPEN}/assets/recorder.js{ASSET_CLOSE}
{ASSET_OPEN}/assets/audiodisplay.js{ASSET_CLOSE}
{ASSET_OPEN}/assets/lame.min.js{ASSET_CLOSE}
{SCRIPT_OPEN}
    console.log("I work");
    initAudio()
    commentEntryRegistry[getUid('{RESULT_ID}','{COMMENT_ID}','comment')] = function() {
        console.log(recorderDataRegistry['{COMMENT_ID}']);
        return recorderDataRegistry['{COMMENT_ID}'];
    }
{SCRIPT_CLOSE}