<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="input-group">
    <span class="input-group-addon" id="basic-addon1">Question:</span>
    <input type="text" id="question" class="form-control" placeholder="Question?" aria-describedby="basic-addon1"/>
    <span class="input-group-addon" id="basic-addon1">Point Value:</span>
    <input type="text" id="pointval" class="form-control" placeholder="0" aria-describedby="basic-addon1"/>
</div>
<button class="btn btn-primary" id="submit">Insert Question Into Page</button>
<script>
    $(document).on("click", "#submit", submit);
    function submit() {
        questionData = {};
        var question = $( "#question" ).val();
        var pointVal = $( "#pointval" ).val();
        questionData.type = "shortAnswer";
        questionData.question = question;
        questionData.pointVal = pointVal;
        createQuestion(questionData);
    }
</script>
