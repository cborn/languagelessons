<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="input-group">
    <span class="input-group-addon" id="basic-addon1">Question:</span>
    <input type="text" id="question" class="form-control" placeholder="Question?" aria-describedby="basic-addon1"></input>
    <span class="input-group-addon" id="basic-addon1">Point Value:</span>
    <input type="text" id="pointval" class="form-control" placeholder="0" aria-describedby="basic-addon1"></input>
</div>
<script>
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