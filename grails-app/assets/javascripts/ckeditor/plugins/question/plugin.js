/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


CKEDITOR.plugins.add( 'question',
{
	init: function( editor ) {
		editor.addCommand( 'insertQuestion', new CKEDITOR.dialogCommand('insertQuestion'));
                editor.ui.addButton( 'Question',
                    {
                    label: 'Insert Question',
                    command: 'insertQuestion',
                    icon: this.path + 'images/q.png'
                } );
            CKEDITOR.dialog.add( 'insertQuestion', function ( editor ) {
                return {
		title : 'Question Insertion',
		minWidth : 400,
		minHeight : 200,
		contents :
		[
                    {
			id : 'general',
			label : 'Settings',
			elements :
			[
                            {
                                type: 'text',
                                id: 'abbr',
                                label: 'Question ID',
                                validate: CKEDITOR.dialog.validate.notEmpty( "Abbreviation field cannot be empty." )
                            }
			]
                    }
		]
                };
            });
	}
        
        
} );
