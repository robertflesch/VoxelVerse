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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// Observable.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/04/2008 11:05
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.exceptions.AlreadyBoundException;
	import org.flashapi.swing.exceptions.NullPointerException;
	import org.flashapi.swing.util.Observer;
	
	/**
	 * 	This <code>Observable</code> class represents an observable object, or "data"
	 * 	in the model-view paradigm.
	 * 
	 * 	<p>An observable object can have one or more observers. An observer may be any
	 * 	object that implements interface <code>Observer</code>. After an observable instance
	 * 	changes, an application calling the <code>notifyObservers()</code> method of the
	 * 	<code>Observable</code> object causes all of its observers to be notified of the
	 * 	change by a call to their <code>update()</code> method.</p>
	 * 
	 * 	<p>Note that the order in which notifications will be delivered is unspecified.</p>
	 * 
	 * 	@see org.flashapi.swing.util.Observer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Observable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 */
		public function Observable() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds an observer to the set of observers for this object, provided that it
		 * 	 is not the same as some observer already in the set. The order in which
		 * 	notifications will be delivered to multiple observers is not specified.
		 * 
		 * 	@param	o	An observer to be added.
		 * 
		 *  @throws org.flashapi.swing.exceptions.NullPointerException A 
		 * 			<code>NullPointerException</code> if the <code>o</code> parameter
		 * 			is <code>null</code>.
		 *  @throws org.flashapi.swing.exceptions.AlreadyBoundException As
		 * 			<code>AlreadyBoundException</code> if the <code>o</code> parameter
		 * 			had already been added to the set of observers for this object.
		 */
		public function addObserver(o:Observer):void {
			if(o==null) throw new NullPointerException();
			for each(var obj:Observer in _obs)
				if(obj==o) throw new AlreadyBoundException(String(o));
			_obs.push(o);
		}
		
		/**
		 * 	Deletes an observer from the set of observers of this object.
		 * 
		 *	 @param	o	 The observer to be deleted.
		 */
		public function deleteObserver(o:Observer):void {
			var i:int = _obs.length - 1;
			for (; i >= 0; i--) {
				if (_obs[i] == o) {
					_obs.splice(i, 1);
					return;
				}
			}
		}
		
		/**
		 * 	If this object has changed, as indicated by the <code>hasChanged()</code>
		 * 	method, then notify all of its observers and then call the <code>clearChanged()</code>
		 * 	method to indicate that this object has no longer changed.
		 * 
		 * 	<p>Each observer has its update method called with two arguments:
		 * 	this observable object and the <code>arg</code> argument. The default
		 * 	value for the <code>arg</code> argument is <code>null</code>.</p>
		 * 
		 * 	@param	arg	Any object.
		 */
		public function notifyObservers(arg:* = undefined):void {
			if (!_changed) return;
			var arrLocal:Array = _obs;
			clearChanged();
			for each(var obj:Observer in arrLocal) obj.update(this, arg);
		}
		
		/**
		 * 	Clears the observer list so that this object no longer has any observers.
		 */
		public function deleteObservers():void {
			_obs = [];
		}
		
		/**
		 * 	Returns an array that contains all observers for this object.
		 * 
		 * 	@return	An array that contains all observers for this object.
		 */
		public function getObservers():Array {
			var newArray:Array = [];
			var l:int = _obs.length;
			var i:int = 0;
			for (; i < l; ++i) newArray.push(_obs[i]);
			return newArray;
		}
		
		/**
		 * 	Marks this <code>Observable</code> object as having been changed;
		 * 	the <code>hasChanged()</code> method will now return <code>true</code>.
		 * 
		 * 	@see #hasChanged()
		 * 	@see #clearChanged()
		 */
		public function setChanged():void {
			_changed = true;
		}
		
		/**
		 * 	Indicates that this object has no longer changed, or that it has 
		 * 	already notified all of its observers of its most recent change, so 
		 * 	that the <code>hasChanged()</code> method will now return <code>false</code>.
		 * 	This method is called automatically by the <code>notifyObservers()</code>
		 * 	method. 
		 * 
		 * 	@see #hasChanged()
		 * 	@see #setChanged()
		 */
		public function clearChanged():void {
			_changed = false;
		}
		
		/**
		 * 	Checks whether this object has changed, or not. Returns <code>true</code>
		 * 	if and only if the <code>setChanged()</code> method has been
		 * 	called more recently than the <code>clearChanged()</code> method on this
		 * 	object; <code>false</code> otherwise.
		 * 
		 * 	@return	<code>true</code> if this object has changed; <code>false</code>
		 * 			otherwise.
		 * 
		 * 	@see #clearChanged()
		 * 	@see #setChanged()
		 */
		public function hasChanged():Boolean {
			return _changed;
		}
		
		/**
		 * 	Returns the number of observers of this <code>Observable</code> object.
		 * 
		 *	@return	The number of observers of this object.
		 */
		public function countObservers():Number {
			return _obs.length;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _changed:Boolean = false;
		private var _obs:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_obs = [];
		}
	}
}