/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	config.filebrowserUploadUrl = '/boffice/bbs/fileUploadCKEditor.do';
	config.extraPlugins = 'youtube';
    config.toolbar =[

                     ['-','Cut','Copy','Paste','PasteText','PasteFromWord','Undo','Redo','SelectAll','RemoveFormat'],

                     ['Styles','Format','Font','FontSize','TextColor'],

                     '/',

                     ['Bold','Italic','Underline','Strike', 'Subscript','Superscript'],

                     ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],

                     ['NumberedList','BulletedList','Outdent','Indent','Blockquote','CreateDiv'],

                     ['Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Youtube'],

                     ['BGColor','Maximize', 'ShowBlocks'],
                     
                     ['Link', 'Unlink', 'Anchor']

                 ];
    
};
