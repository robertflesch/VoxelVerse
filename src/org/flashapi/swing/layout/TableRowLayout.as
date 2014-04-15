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

package org.flashapi.swing.layout {
	
	// -----------------------------------------------------------
	// TableRowLayout.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/02/2009 18:56
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------

	/**
	 *  The "finished" <code>LayoutEvent</code> occurs after child elements are added
	 * 	or removed, bounds of the <code>UIContainer</code> object change and after 
	 * 	all other changes that could affect the layout have been performed.
	 *
	 *  @eventType org.flashapi.swing.event.LayoutEvent.FINISHED
	 */
	[Event(name="finished", type="org.flashapi.swing.event.LayoutEvent")]
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>TableRowLayout</code> class creates layout objects specific to
	 * 	<code>Datagrid</code> rows and header rows.
	 * 
	 * 	@see org.flashapi.swing.table.core.DataGridRowBase
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TableRowLayout extends AbstractLayout implements Layout {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>TableRowLayout</code> instance.
		 */
		public function TableRowLayout() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The grid map that defines the single row for this table layout.
		 */
		public var rowMap:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		public function moveObjects(bounds:Rectangle, caller:* = null):void {
			if (rowMap == null) return;
			spas_internal::bounds = bounds;
			if ($elementsList.length > 0) setRowLayout();
			dispatchFinishedEvent();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function setRowLayout():void {
			var obj:*;
			var s:int = $elementsList.length;
			var xPos:Number = spas_internal::bounds.x;
			var i:uint = 0;
			var hg:Number = $target.horizontalGap;
			var w:Number;
			var h:Number = 0;
			for (; i < s; ++i) {
				w = rowMap[i];
				obj = $elementsList[i];
				invalidateEvent(obj, true);
				obj.x = xPos;
				obj.width = w;
				xPos += hg + w;
				if (obj.height > h) h = obj.height;
				invalidateEvent(obj, false);
			}
			//if(_target.autoHeight) _target.height = h;
		}
		
		private function invalidateEvent(obj:*, value:Boolean):void { 
			if (obj is UIObject)
				obj.spas_internal::invalidateChangeEvent =
				obj.deactivateMetricsChanges = value;
			if (obj is UIContainer) obj.spas_internal::invalidateLayoutUpdate = value;
		}
	}
}