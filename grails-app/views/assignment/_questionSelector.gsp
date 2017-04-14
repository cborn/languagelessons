<table class="table table-striped">
    <tr>
        <th>
            <center><div class="btn-group btn-toolbar" role="group" aria-label="toolbar">
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
    