<table class="table">
    <tr>
        <th>Lesson Name</th>
        <th>Open Date</th>
        <th>Due Date</th>
        <th>Push to Calendar</th>
        <th>Duplicate</th>
        <th>Delete</th>
        <th>Edit</th>
    </tr>
    <g:each in="${lessons}" var="lesson">
        <tr>
            <td>${lesson.name}</td>
            <td><input type="date" name="bday" min="2016-12-31" id="openDate${lesson.id}"><br></td>
            <td><input type="date" name="bday" min="2016-12-31" id="dueDate${lesson.id}"></td>
            <td>
                <g:if test="${!(pushed.find{pushedLesson -> pushedLesson.template.id == lesson.id})}">
                    <button class="btn btn-primary" onclick="sendToCalendar(${lesson.id})">Push to Calendar</button>
                </g:if>
                <g:else>
                    Lesson already in Calendar
                </g:else>
            </td>
            <td>
                TBD
            </td>
            <td>
                <button class="btn btn-warning" onclick="destroy(${lesson.id})">Delete</button>
            </td>
            <td>
                <g:link role="button" class="btn btn-primary" controller="lesson" action="builderCreateEditHandler" params="[syllabusId: course.syllabusId, edit: true, lessonId: lesson.id]">Edit Lesson</g:link>
            </td>
        </tr>
    </g:each>
</table>