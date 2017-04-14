<div class="input-group">
    <span class="input-group-addon" id="basic-addon1">Question:</span>
    <input type="text" id="question" class="form-control" placeholder="Question?" aria-describedby="basic-addon1"></input>
    <span class="input-group-addon" id="basic-addon1">Point Value:</span>
    <input type="text" id="pointval" class="form-control" placeholder="0" aria-describedby="basic-addon1"></input>
</div>
    <table id="answers" class="table table-striped">
        <tr>
            <th>Possible Answer</th>
            <th>Correct?</th>
            <th>Delete Answer</th>
        </tr>
        <tr class="entry" id="0">
            <td>
                <input type="text" class="form-control" id="answer" placeholder="Answer."></input>
            </td>
            <td>
                <label class="custom-control custom-checkbox">
                    <input type="checkbox" id="correct" class="custom-control-input">
                    <span class="custom-control-indicator"></span>
                    <span class="custom-control-description">Is this answer correct?</span>
                </label>
            </td>
            <td>
                <button class="btn btn-danger delete" id="0">Delete Answer</delete>
            </td>
        </tr>
        <tfoot>
            <tr>
                <td><button class="btn btn-primary" id="add">Add Answer</button></td>
            </tr>
        </tfoot>
    </table>
    <button class="btn btn-primary" id="submit">Insert Question Into Page</button> 
    <script id="row-template" type="text/html">
        <tr class="entry" id="{row-id}">
            <td>
                <input type="text" class="form-control" id="answer" placeholder="Answer."></input>
            </td>
            <td>
                <label class="custom-control custom-checkbox">
                    <input type="checkbox" id="correct" class="custom-control-input">
                    <span class="custom-control-indicator"></span>
                    <span class="custom-control-description">Is this answer correct?</span>
                </label>
            </td>
            <td>
                <button class="btn btn-danger delete" id="{row-id}">Delete Answer</delete>
            </td>
        </tr>
    </script>
    <script>
        $(document).on("click", "#submit", submit);
        $(document).on("click", "#add", addRow);
        $(document).on("click", ".delete", function() {
                deleteRow($( this )[0].id);
        });
        var curId = 1;
        function addRow() {
            var html = $('#row-template').html();
            //Why do I have to call replace twice?
            //because javascript  is really dumb and doesn't have a thing to replace them all.
            var outdumb = html.replace("{row-id}", curId);
            var out = outdumb.replace("{row-id}", curId);
            $( "#answers" ).append(out);
            curId = curId + 1;
        }
        function deleteRow(rowId) {
            $( "#" + rowId ).remove();
        }
        function submit() {
            questionData = {};
            var question = $( "#question" ).val();
            var pointVal = $( "#pointval" ).val();
            var answers = [];
            var corrects = [];
            $( ".entry" ).each(function(index, obj) {
                //needs to go through each element
                var answer = $( this ).find(" #answer ").val();
                var correct = $( this ).find(" #correct ").is(':checked');
                answers.push(answer);
                corrects.push(correct);
            });
            questionData.type = "multipleChoice";
            questionData.question = question;
            questionData.pointVal = pointVal;
            questionData.answers = answers;
            questionData.corrects = corrects;
            createQuestion(questionData);
        }
    </script>

    