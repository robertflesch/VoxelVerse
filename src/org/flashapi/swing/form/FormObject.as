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

package org.flashapi.swing.form {
	
	// -----------------------------------------------------------
	// FormObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/11/2008 15:46
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.net.rpc.WebService;
	
	/**
	 * 	The <code>FormObject</code> interface is the markup interface for all 
	 * 	form objects that extend the <code>AFM</code> class.
	 * 
	 * 	@see org.flahspai.swing.form.AFM
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface FormObject extends Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Invoked whenever a response has been sent by the server. This function
		 * 	must have an object parameter which is the <code>result</code> parameter
		 * 	of the <code>WebServiceEvent</code> event, as shown below:
		 * 
		 * 	<pre>
		 * 		var form:Form = new Form();
		 * 		form.onResponse = function(result:Object):void {
		 * 			trace (result);
		 * 		}
		 * 	</pre>
		 * 
		 * 	<p>If <code>null</code>, the <code>onResponse</code> event function is not
		 * 	invoked.</p>
		 * 
		 * 	@default null
		 * 
		 * 	@see org.flashapi.swing.event.WebServiceEvent
		 */
		function get onResponse():Function;
		function set onResponse(value:Function):void;
		
		/**
		 * 	Invoked whenever form data is sent to the specified URI through the 
		 * 	<code>WebService</code> defined for this <code>FormObject</code> instance.
		 * 	This function must have an object parameter which is a reference to the 
		 * 	<code>FormObject</code> instance, as shown below:
		 * 
		 * 	<pre>
		 * 		var form:Form = new Form();
		 * 		form.onSubmit = function(obj:Form):void {
		 * 			trace(obj);
		 * 		}
		 * 	</pre>
		 * 
		 * 	<p>If <code>null</code>, the <code>onSubmit</code> event function is not
		 * 	invoked.</p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #outputRequest
		 * 	@see #forceSubmitFunction
		 * 	@see #url
		 */
		function get onSubmit():Function;
		function set onSubmit(value:Function):void;
		
		/**
		 * 	Returns a collection of objects defined by pairs of a variable name
		 * 	and their corresponding data values. Each pair represents data values
		 * 	for a form item object contained within this <code>FormObject</code>
		 * 	instance.
		 */
		function get variables():Dictionary;
		
		/**
		 * 	Returns a reference to the <code>WebService</code> object used 
		 * 	by this <code>FormObject</code> instance.
		 */
		function get webService():WebService;
		
		/**
		 * 	Sets or gets the URI where is located the Web sevice to use with this 
		 * 	<code>FormObject</code> instance. The <code>url</code> property is the 
		 * 	same as <code>url</code> property of the <code>WebService</code> object 
		 * specified by the <code>webService</code> property.
		 * 
		 * 	@default null
		 * 
		 * 	@see #webService
		 * 	@see org.flashapi.swing.net.rpc.WebService#url
		 */
		function get url():String;
		function set url(value:String):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates wheter the request sent to
		 * 	the specified URI should be output for debugging (<code>true</code>), or
		 * 	not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get outputRequest():Boolean;
		function set outputRequest(value:Boolean):void;
		
		/**
		 * 	A <code>false</code> value that specifies the behavior of the
		 * 	<code>onSubmit</code> action.
		 * 
		 * 	If <code>true</code>, the <code>onSubmit</code> action is fired
		 * 	before data treatment and submition, even if the <code>url</code>
		 * 	parameter is <code>null</code>.
		 * 
		 * 	<p>If <code>false</code>, the <code>onSubmit</code> action is fired
		 * 	only if the data treatment has succeeded, which means that all validation
		 * 	routines have succeeded, and the <code>url</code> parameter is not
		 * 	<code>null</code>.</p>
		 * 
		 * 	@default false
		 */
		function get forceSubmitFunction():Boolean;
		function set forceSubmitFunction(value:Boolean):void
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Gets data from all form item objects within this <code>FormObject</code>
		 * 	instance and sends the request to the specified URI.
		 * 
		 * 	@see #url
		 */
		function submit():void;
		
		/**
		 * 	Resets this <code>FormObject</code> instance.
		 */
		function reset():void;
	}
}