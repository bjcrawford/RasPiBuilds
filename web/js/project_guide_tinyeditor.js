/* 
 *  Author: Michael <http://www.scriptiny.com/author/michael/>
 *          Brett Crawford <brett.crawford@temple.edu>
 *  File:   project_guide_tinyeditor.js
 *  Date:   Mar 18, 2015
 *  Desc:   This file was retrieved from:  http://www.scriptiny.com/2010/02/javascript-wysiwyg-editor/
 *          The original author, Michael, has allowed for sharing and adpating this file under the
 *          Creative Common License, http://creativecommons.org/licenses/by/3.0/us/
 *          This file has been modified by me, Brett Crawford, with some slight formatting changes
 *          and the addition of a function for inserting content into the editor.
 */

var pgTinyEditor = new TINY.editor.edit('editor',{
	id:'inputProjectGuide',
	height:175,
	cssclass:'te',
	controlclass:'tecontrol',
	rowclass:'teheader',
        bodyclass:'tebody',
	dividerclass:'tedivider',
	controls:['bold','italic','underline','strikethrough','|','subscript','superscript','|',
			  'orderedlist','unorderedlist','|','outdent','indent','|','leftalign',
			  'centeralign','rightalign','blockjustify','|','unformat','|','undo','redo','n',
			  'font','size','style','|','image','hr','link','unlink','|','cut','copy','paste','print'],
	footer:true,
	fonts:['Verdana','Arial','Georgia','Trebuchet MS'],
	xhtml:true,
	cssfile:'css/tinyeditor.css',
	bodyid:'editor',
	footerclass:'tefooter',
	toggle:{text:'source',activetext:'wysiwyg',cssclass:'toggle'},
	resize:{cssclass:'resize'}
});