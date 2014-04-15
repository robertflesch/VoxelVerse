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
	* @version 1.0.3, 17/03/2010 20:32
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.form.AFM;
	import org.flashapi.swing.form.FormObject;
	import org.flashapi.swing.form.LoggingFormContainer;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.plaf.libs.LoggingFormUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("LoggingForm.png")]
	
	/**
	 * 	<img src="LoggingForm.png" alt="LoggingForm" width="18" height="18"/>
	 * 
	 * 	The <code>LoggingForm</code> class lets you create and easily control a basic
	 * 	logging / password HTML-like form. You can add the number of fields you want to a 
	 * 	<code>LoggingForm</code> instance by passing a <code>FormItem</code> object
	 * 	(or a simple <code>Object</code>) as value parameter of the <code>LoggingForm.addItem()</code>
	 * 	method. Both codes bellow show how to add similar input fields within a SPAS 3.0 form:
	 * 
	 *  <listing version="3.0">
	 * 		var form:LoggingForm = new LoggingForm();
	 *  	form.addItem( { type:FormItemType.INPUT, label:"Loggin :", variable:"loggin" } );
	 * 		form.addItem( new FormItem("Loggin :", "loggin") );
	 *  </listing>
	 * 
	 * 	<p>The following table lists the type of field you use to create forms in SPAS 3.0:</p>
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
	 * 			<td>Hidden control</td>
	 * 			<td><code>FormItemType.HIDDEN</code></td>
	 * 			<td>Specifies that the form item is a hidden field. SPAS 3.0
	 * 			hidden fields are similar to HTML hidden fields.</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.Form
	 * 	@see org.flashapi.swing.SimpleForm
	 * 	@see org.flashapi.swing.form.FormItem
	 * 
	 * 	@includeExample LoggingFormExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LoggingForm extends AFM implements Observer, Listable, LafRenderer, FormObject, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>LoggingForm</code> instance with the
		 * 					specified URL.
		 * 
		 * 	@param	url		The URI where is located the Web sevice to use with this 
		 * 					<code>LoggingForm</code> instance.
		 */
		public function LoggingForm(url:String = null) {
			super(LoggingFormContainer, LoggingFormUIRef, url);
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
			//TODO: must implement a credential connection process!
		}
	}
}