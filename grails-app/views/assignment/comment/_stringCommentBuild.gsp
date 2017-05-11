<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<textarea class="form-control custom-control" rows="2" id="{RESULT_ID}-{COMMENT_ID}-comment"></textarea>
{SCRIPT_OPEN}
    commentEntryRegistry[getUid('{RESULT_ID}','{COMMENT_ID}','comment')] = function() {
        return $( getUid('{RESULT_ID}','{COMMENT_ID}','comment') ).val();
    }
{SCRIPT_CLOSE}