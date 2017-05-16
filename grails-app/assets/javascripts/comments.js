/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};
var buildOn = {};
var commentEntryRegistry = {};
var selectedType = {};
function toggle(resultId, commentId) {
    selectedType[getUid(resultId, commentId, 'view')] = 'stringCommentDisplay';
    if (!buildOn[getUid(resultId, commentId, "main")]) {
        $( getUid(resultId, commentId, "main")  ).html( substitute($( "#commentBoxSource" ).html(), resultId, commentId) );
        $( getUid(resultId, commentId, "toggle") ).html("Close Comment Editor");
    } else {
        $( getUid(resultId, commentId, "main") ).html( "" );
        $( getUid(resultId, commentId, "toggle") ).html( "Post a Comment" );
    }
    buildOn[getUid(resultId, commentId, "main")] = !buildOn[getUid(resultId, commentId, "main")];
}
function select(displayName, view, buildView, resultId, commentId) {
    selectedType[getUid(resultId, commentId, "view")] = view;
    $( getUid(resultId, commentId, "curSel") ).html(displayName);
    $( getUid(resultId, commentId, "buildArea") ).html( substitute($( "#" + buildView ).html(), resultId, commentId));
}
function getUid(resultId, commentId, identifier) {
    return "#" + resultId + "-" + commentId + "-" + identifier;
}
function substitute(html, resultId, commentId) {
    html = html.replaceAll("{RESULT_ID}", resultId)
               .replaceAll("{COMMENT_ID}", commentId)
               .replaceAll("{SCRIPT_OPEN}", "<script>")
               .replaceAll("{SCRIPT_CLOSE}","</script>")
               .replaceAll("{ASSET_OPEN}","<script src='")
               .replaceAll("{ASSET_CLOSE}","' type='text/javascript'>");
    return html;
}
function post(resultId, commentId) {
    var type = selectedType[getUid(resultId, commentId,"view")];
    var comment = commentEntryRegistry[getUid(resultId,commentId,'comment')]();
    jQuery.ajax({
        type: "POST", 
        url: "/assignment/postComment",
        data: {comment: comment, resultId: resultId, commentId: commentId, type: type},
        success: function (data) {
            refreshComments();
        },
        error: function (xhr, status, error) {
            alert("Something went wrong!!!");
        }
    });
    toggle(resultId, commentId);
}