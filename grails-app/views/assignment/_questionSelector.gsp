<table class="table table-striped">
    <tr>
        <th>
            <div class="page-header">
                <h3>Question Editor</h3>
                <small><h3>Begin typing in the editor window to cancel question creation and return to preview mode.</h3></small>
            </div>
            <center>
                <div class="btn-group btn-toolbar" role="group" aria-label="toolbar">
                <g:each in="${options}" var="questionClass">
                    <button type="button" class="btn btn-success selector" id="${questionClass.buildView}">
                        ${questionClass.displayName}
                    </button>
                </g:each>
            </div></center>
        </th>
    </tr>
    <tr>
        <td>
            <div class="container-fluid" id="questionBuild"></div>
        </td>
    </tr>
</table>
    