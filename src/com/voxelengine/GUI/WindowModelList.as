
package com.voxelengine.GUI
{

	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import org.flashapi.swing.list.ListItem;
	import flash.geom.Vector3D;
	
	import flash.utils.Dictionary;

	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	public class WindowModelList extends VVPopup
	{
		static private var _s_mi:ModelInfo = null;
		
		static public function get modelInfo():ModelInfo { return _s_mi; }
		private var _listbox1:ListBox = new ListBox( 200, 15, 300 );
		
		public function WindowModelList()
		{
			super("Model List");
			autoSize = true;
			layout.orientation = LayoutOrientation.VERTICAL;
			
			addElement( _listbox1 );
			_listbox1.addEventListener(ListEvent.LIST_CHANGED, selectModel);
			populateModels();
			
			var addModel:Button = new Button( "Add This Model" );
			addModel.addEventListener(UIMouseEvent.CLICK, addThisModelHandler );
			var cancel:Button = new Button( "Cancel" );
			cancel.addEventListener(UIMouseEvent.CLICK, cancelSelection );

			var panelParentButton:Panel = new Panel( 200, 30 );
			panelParentButton.layout.orientation = LayoutOrientation.HORIZONTAL;
			panelParentButton.padding = 2;
			panelParentButton.addElement( addModel );
			panelParentButton.addElement( cancel );
			
			addElement( panelParentButton );
			
			display();
			
			addEventListener(UIOEvent.REMOVED, onRemoved );
        }
		
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
			removeEventListener(UIOEvent.REMOVED, onRemoved );
		}
		
		private function selectModel(event:ListEvent):void 
		{
			// Globals.GUIControl = true;
			_s_mi = event.target.data;
//			remove();
		}

		private function addThisModelHandler(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 == _listbox1.selectedIndex )
				return;
			var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
			if ( li && li.data )
			{
				_s_mi = li.data;
				var ii:InstanceInfo = new InstanceInfo();
				ii.templateName = _s_mi.fileName;
				var viewDistance:Vector3D = new Vector3D(0, 0, -75);
				ii.positionSet = Globals.controlledModel.instanceInfo.worldSpaceMatrix.transformVector( viewDistance );
				Globals.g_modelManager.create( ii );
				remove();
			}
		}
		
		private function cancelSelection(event:UIMouseEvent):void 
		{
			_s_mi = null;
			remove();
		}
		
		private function populateModels():void
		{
			var models:Dictionary = Globals.g_modelManager.modelInfoGetDictionary();
			for each ( var mi:ModelInfo in models )
			{
				if ( mi && "Player" != mi.modelClass && "EditCursor" != mi.modelClass )
					_listbox1.addItem( mi.fileName + " - " + mi.modelClass, mi );
			}
			//var models:Dictionary = Globals.g_modelManager.instanceInfo;
			//for each ( var mi:InstanceInfo in models )
			//{
				//if ( mi && "Player" != mi.modelClass && "EditCursor" != mi.modelClass )
					//_listbox1.addItem( mi.modelGuid + " - " + mi.instanceGuid, mi );
			//}
		}
	}
}