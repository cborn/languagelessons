<input id="${question.id}answer" type="text" class="form-control"></input>

<script>
    function getValue() {
        var answer = $( "#${question.id}answer" ).val();
        return answer;
    }
    valueRegistry[${question.oldId}] = getValue
    function finishDisplay${question.id}(answer, points, status) {
        var text = "Student answered " + (answer);
        var text = text + ", was rewarded " + points + " points";
        $( "#${question.id}studentAnswer" ).html(text);
    }
</script>