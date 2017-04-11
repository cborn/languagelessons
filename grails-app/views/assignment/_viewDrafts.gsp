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
                Lesson Dropdown Goes Here
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