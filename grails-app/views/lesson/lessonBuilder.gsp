<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sample title</title>
        <asset:javascript src="ckeditor/ckeditor.js"/>
        <style> #preview { outline: 2px dashed red; padding: 2em; margin: 2em 0; } </style>
    </head>
    <body>
        <h1>Sample line</h1>
        
            <textarea id="editor" >
                <p>Hello world! <a href="http://google.com">This is some link</a>.</p>
                <p>And there is some <s>deleted</s>&nbsp;text.</p>
            </textarea>   
            
            <div id="preview"></div>
            
    </body> 
    
        <script>
            var preview = CKEDITOR.document.getById( 'preview' );

                function syncPreview() {
                    preview.setHtml( editor.getData() );
                }

                var editor = CKEDITOR.replace( 'editor', {
                    on: {
                        // Synchronize the preview on user action that changes the content.
                        change: syncPreview,

                        // Synchronize the preview when the new data is set.
                        contentDom: syncPreview
                    }
                } );
                
        </script>
</html>
