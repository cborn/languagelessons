<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"name="layout" content="main"/>
        <title>New Assignment</title>
        <asset:javascript src="ckeditor/ckeditor.js"/>
        <asset:javascript src="application.js"/>
        <style type="text/css" media="screen">
            #status {
                background-color: #eee;
                border: .2em solid #fff;
                margin: 2em 2em 1em;
                padding: 1em;
                width: 12em;
                float: left;
                -moz-box-shadow: 0px 0px 1.25em #ccc;
                -webkit-box-shadow: 0px 0px 1.25em #ccc;
                box-shadow: 0px 0px 1.25em #ccc;
                -moz-border-radius: 0.6em;
                -webkit-border-radius: 0.6em;
                border-radius: 0.6em;
            }

            #status ul {
                font-size: 0.9em;
                list-style-type: none;
                margin-bottom: 0.6em;
                padding: 0;
            }

            #status li {
                line-height: 1.3;
            }

            #status h1 {
                text-transform: uppercase;
                font-size: 1.1em;
                margin: 0 0 0.3em;
            }

            #page-body {
                margin: 2em 1em 1.25em 18em;
            }

            h2 {
                margin-top: 1em;
                margin-bottom: 0.3em;
                font-size: 1em;
            }

            p {
                line-height: 1.5;
                margin: 0.25em 0;
            }

            #controller-list ul {
                list-style-position: inside;
            }

            #controller-list li {
                line-height: 1.3;
                list-style-position: inside;
                margin: 0.25em 0;
            }

            @media screen and (max-width: 480px) {
                #status {
                    display: none;
                }

                #page-body {
                    margin: 0 1em 1em;
                }

                #page-body h1 {
                    margin-top: 0;
                }
            }
            #preview { outline: 2px dashed red; padding: 2em; margin: 2em 0; }
            .question { 
                background-color: lightgreen; 
                outline: 4px solid green;
                padding: 2em;
                margin: 2em 0;
            }
        </style>
    </head>
    <body>
        <!--<g:if test="${flash.message}">
            <%-- display an info message to confirm --%>
            <div class="col-xs-12 text-center">
                <div class="alert alert-info alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    ${flash.message}
                </div>
            </div>
        </g:if>
        <g:if test="${flash.error}">
            <%-- display an info message to confirm --%>
            <div class="col-xs-12 text-center">
                <div class="alert alert-danger alert-dismissible" role="alert" style="display: block; margin-top: 5px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h1>${flash.error}</h1>
                </div>
            </div>
        </g:if>-->
        <div class="editable-filename" id="filename" contenteditable="true">${filename}</div>
        <button id="save-exit-btn" class="btn btn-primary" onclick="saveAndExit()">Save and Exit</button>
        <button id="discard-exit-btn" class="btn btn-warning" onclick="discardAndExit()">Discard and Exit</button>
        <button id="save-btn" class="btn btn-primary" onclick="save()">Save</button>
        <button id="question-btn" class="btn btn-primary" onclick="questionBuilder()">Add Question</button>
        <i><span style="visibility:hidden" id="successAlert">success message goes here</span></i>
        <i><span style="visibility:hidden" id="failAlert">fail message goes here</span></i>
            <textarea id="editor" >
                ${html}
            </textarea>
            <p>Live Preview:</p>
            <div id="preview"></div> 
        <script>
            CKEDITOR.disableAutoInline = true;
            var currentfilename = "untitled lesson"
            CKEDITOR.addCss(
            ".question { " + 
                "background-color: lightgreen; " +
                "outline: 4px solid green; " +
                "padding: 2em; " +
                "margin: 2em 0; " +
            "}"
            );
            var preview = CKEDITOR.document.getById( 'preview' );
                function resetBindings() {
                    $(document).off();
                    createBindings();
                }
                function createBindings() {
                    $(document).on("click",".selector",function() {
                        getQuestionBuild($( this )[0].id);
                    });
                }
                createBindings();
                function saveAndExit() {
                    syncFilename();
                    syncPreview();
                    jQuery.ajax({
                        type: "POST",
                        url: "${createLink(action: 'saveAssignment')}",
                        data: {discard: false, syllabusId: ${syllabusId}},
                        success: function (data) {
                            window.location.href = "${createLink(controller: "course", action: "show", params: [syllabusId: syllabusId])}";
                        }
                    });
                }
                function save() {
                    syncFilename();
                    syncPreview();
                    jQuery.ajax({
                        type: "POST",
                        url: "${createLink(action: 'saveAssignment')}",
                        data: {discard: false, syllabusId: ${syllabusId}},
                        success: function (data) {
                            successAlert('Successfully saved.');
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            failAlert('Error while saving');
                        }
                    });
                }
                function discardAndExit() {
                    jQuery.ajax({
                        type: "POST",
                        url: "${createLink(action: 'saveAssignment')}",
                        data: {discard: true, syllabusId: ${syllabusId}},
                        success: function (data) {
                            window.location.href = "${createLink(controller: "course", action: "show", params: [syllabusId: syllabusId])}";
                        }
                    });
                }
                function syncPreview() {
                    var html = encodeURIComponent(editor.getData());
                    jQuery.ajax({
                        type: "POST", 
                        url: "${createLink(action: 'syncPreview')}",
                        data: {html: html, filename: currentfilename},
                        success: function (data) {
                            preview.setHtml(data);
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            preview.setHtml("<div class='alert alert-danger'>Connection lost.</div>");
                        }
                    });
                }
                function syncFilename() {
                    var filename_text = filename.getData().replace(/<(?:.|\n)*?>/gm, ''); //removes html since we just want the filename
                    if (filename_text == '') {
                       filename_text = 'untitled assignment';
                    }
                    filename.setData(filename_text);
                    currentfilename = filename_text;
                }
                var editor = CKEDITOR.replace( 'editor', {
                    on: {
                        // Synchronize the preview on user action that changes the content.
                        change: syncPreview,

                        // Synchronize the preview when the new data is set.
                        contentDom: syncPreview
                    }
                } );
                var filename = CKEDITOR.inline( 'filename', {
                                            removePlugins: 'toolbar',
                                            allowedContent: '',
                                            on: {
                                                blur: syncFilename,
                                            }
                });

                function closeSuccessAlert() {
                    document.getElementById("successAlert").style.visibility="hidden";
                }
                function closeFailAlert() {
                    document.getElementById("failAlert").style.visibility="hidden";
                }
                function successAlert(text) {
                    $( "#successAlert" ).show();
                    var successAlert = document.getElementById("successAlert");
                    successAlert.style.visibility="visible";
                    successAlert.innerHTML = text;
                    $( "#successAlert" ).stop(true, true).fadeOut(2000, closeSuccessAlert);
                }
                function failAlert(text) {
                    $( "#failAlert" ).show();
                    var failAlert = document.getElementById("failAlert");
                    failAlert.style.visibility="visible";
                    failAlert.innerHTML = text;
                    $( "#failAlert" ).stop(true, true).fadeOut(2000, closeFailAlert);
                }
                
                function questionBuilder() {
                    jQuery.ajax({
                        type: "POST", 
                        url: "${createLink(action: 'questionSelector')}",
                        data: {select: "yes"},
                        success: function (data) {
                            preview.setHtml(data);
                        },
                    });
                }
                function getQuestionBuild(templateName) {
                    jQuery.ajax({
                        type: "POST", 
                        url: "${createLink(action: 'getQuestionBuild')}",
                        data: {templateName: templateName},
                        success: function (data) {
                            resetBindings();
                            $( "#questionBuild" ).html(data);
                        },
                    });
                }
                function createQuestion(questionData) {
                    jQuery.ajax({
                        type: "POST", 
                        url: "${createLink(action: 'createQuestion')}",
                        data: {questionData: JSON.stringify(questionData)},
                        success: function (data) {
                            CKEDITOR.instances.editor.insertHtml('<div contenteditable="false" class="question" id="' + data + '">Question with id: ' + data + '</div>');
                        },
                    });
                }
        </script>
    </body>    
</html>
