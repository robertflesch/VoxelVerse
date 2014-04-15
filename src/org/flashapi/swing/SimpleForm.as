////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// SimpleForm.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 22:05
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.form.AFM;
	import org.flashapi.swing.form.FormObject;
	import org.flashapi.swing.form.SimpleFormContainer;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.plaf.libs.SimpleFormUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("SimpleForm.png")]
	
	/**
	 * 	<img src="SimpleForm.png" alt="SimpleForm" width="18" height="18"/>
	 * 
	 * 	The <code>SimpleForm</code> class lets you create and easily control a basic 
	 * 	extensible HTML-like form. You can add the number of fields you want to a 
	 * 	<code>SimpleForm</code> instance by passing a <code>FormItem</code> object
	 * 	(or a simple <code>Object</code>) as value parameter of the
	 * 	<code>SimpleForm.addItem()</code> method. Both codes bellow
	 * 	show how to add similar input fields within a SPAS 3.0 form:
	 * 
	 *  <listing version="3.0">
	 * 		var form:SimpleForm = new SimpleForm();
	 *  	form.addItem( { type:FormItemType.INPUT, label:"Nom :", variable:"fname" } );
	 * 		form.addItem( new FormItem("Nom :", "fname") );
	 *  </listing>
	 * 
	 * 	<p>SimpleForm objects can diplay items like: text inputs, buttons, text areas,
	 * 	separators, hidden fields and div containers. To implement more capabilities,
	 * 	use a <code>Form</code> instance.</p>
	 * 
	 * 	<p>The following table lists the type of field you use to create simple forms in
	 * 	SPAS 3.0:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Type</th>
	 * 			<th><code>FormItemType</code> constant</th>
	 * 			<th>Description</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Input control</td>
	 * 			<td><code>FormItemType.INPUT</code></td>
	 * 			<td>Specifies that the form item is a <code>TextInput</code> instance.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Password control</td>
	 * 			<td><code>FormItemType.PASSWORD</code></td>
	 * 			<td>Specifies that the form item is a <code>TextInput</code> instance
	 * 			which lets users type their passwords.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Title control</td>
	 * 			<td><code>FormItemType.TITLE</code></td>
	 * 			<td>Specifies that the form item is a <code>Label</code> instance
	 * 			used as title text.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Separator control</td>
	 * 			<td><code>FormItemType.SEPARATOR</code></td>
	 * 			<td>Specifies that the form item is a <code>SEPARATOR</code> instance
	 * 			that is used to horizontally seperate from fields.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Text area control</td>
	 * 			<td><code>FormItemType.TEXTAREA</code></td>
	 * 			<td>Specifies that the form item is a <code>TextArea</code> instance
	 * 			which lets users type free texts.</td>
	 * 		</tr>
	 *		<tr>
	 * 			<td>Reset control</td>
	 * 			<td><code>FormItemType.RESET</code></td>
	 * 			<td>Specifies that the form item is a <code>Button</code> instance
	 * 			which lets users reset the form.</td>
	 * 		</tr>
	 *		<tr>
	 * 			<td>Submit control</td>
	 * 			<td><code>FormItemType.SUBMIT</code></td>
	 * 			<td>Specifies that the form item is a <code>Button</code> instance
	 * 			which lets users submit the form.</td>
	 * 		</tr>
	 *		<tr>
	 * 			<td>Simple button control</td>
	 * 			<td><code>FormItemType.BUTTON</code></td>
	 * 			<td>Specifies that the form item is a <code>Button</code> instance.</td>
	 * 		</tr>
	 *		<tr>
	 * 			<td>Div control</td>
	 * 			<td><code>FormItemType.DIV</code></td>
	 * 			<td>Specifies that the form item is a <code>Canvas</code> instance
	 * 			which allows developers to add custom display objects within a
	 * 			form.</td>
	 * 		</tr>
	 *		<tr>
	 * 			<td>Hidden control</td>
	 * 			<td><code>FormItemType.HIDDEN</code></td>
	 * 			<td>Specifies that the form item is a hidden field. SPAS 3.0
	 * 			hidden fields are similar to HTML hidden fields.</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.Form
	 * 	@see org.flashapi.swing.LoggingForm
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleForm extends AFM implements Observer, Listable, LafRenderer, FormObject, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>SimpleForm</code> instance with the
		 * 					specified URL.
		 * 
		 * 	@param	url		The URI where is located the Web sevice to use with this 
		 * 					<code>SimpleForm</code> instance.
		 */
		public function SimpleForm(url:String = null) {
			super(SimpleFormContainer, SimpleFormUIRef, url);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::isInitialized(1);
		}
		
	}
}