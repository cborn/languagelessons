<table class="table">
    <tr>
        <th>Assignment Name</th>
        <th>Attach to Lesson</th>
        <th>Duplicate</th>
        <th>Delete</th>
        <th>Edit</th>
    </tr>
    <g:each in="${assignments}" var="assignment">
        <tr>
            <td>${assignment.name}</td>
            <td>
                <g:if test="${!assignment.lesson}">
                    <div class="dropdown">
                        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Add to Lesson
                        <span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <g:each in="${course.lessons}" var="lesson">
                                <li><button class="btn btn-link" onclick="add(${assignment.id}, ${lesson.id})">${lesson.name}</button></li>
                            </g:each>
                        </ul>
                    </div>
                </g:if>
                <g:else>
                    Belongs to <g:link controller="lesson" action="viewLesson" params="[lessonId: assignment.lesson.id, syllabusId: course.syllabusId]">Lesson "${assignment.lesson.name}"</g:link>
                </g:else>
            </td>
            <td>
                TBD
            </td>
            <td>
                <button class="btn btn-warning" onclick="destroy(${assignment.id})">Delete</button>
            </td>
            <td>
                <g:link role="button" class="btn btn-primary" controller="assignment" action="builderCreateEditHandler" params="[syllabusId: course.syllabusId, edit: true, assignId: assignment.id]">Edit Lesson</g:link>
            </td>
        </tr>
    </g:each>
</table>