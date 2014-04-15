
package com.voxelengine.GUI
{

	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import org.flashapi.swing.list.ListItem;
	
	import flash.utils.Dictionary;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	
	import flash.geom.Vector3D;

	public class WindowModels extends VVPopup
	{
		private var _listbox1:ListBox = new ListBox( 200, 15, 300 );
		private var _listbox2:ListBox = new ListBox( 200, 15, 300 );
		private var _fileReference:FileReference = new FileReference();
		private var _popup:Popup = null;
		
		public function WindowModels()
		{
			super("Voxel Models");
			autoSize = true;
			
			populateParentModels();
			
			var listBoxPanel:Container = new Container( 500, 300 );
			listBoxPanel.layout.orientation = LayoutOrientation.HORIZONTAL;
			listBoxPanel.padding = 0;
			//_listbox1.height = 300
			//_listbox2.height = 300
			listBoxPanel.addElement( _listbox1 );
			listBoxPanel.addElement( _listbox2 );
			_listbox1.addEventListener(ListEvent.LIST_CHANGED, selectParentModel);
			_listbox2.addEventListener(ListEvent.LIST_CHANGED, childModelDetail );
			addElement( listBoxPanel );
			
			var panelButton:Container = new Container( 500, 100 );
			panelButton.padding = 0;

			var panelParentButton:Container = new Container( 200, 80 );
			panelParentButton.layout.orientation = LayoutOrientation.VERTICAL;
			panelParentButton.padding = 0;
			panelButton.addElement( panelParentButton );

			var addModel:Button = new Button( "Add Parent Model..." );
			addModel.addEventListener(UIMouseEvent.CLICK, addParent );
			addModel.width = 150;
			panelParentButton.addElement( addModel );
			
			var deleteModel:Button = new Button("Delete Parent Model");
			deleteModel.addEventListener(UIMouseEvent.CLICK, deleteParent );
			deleteModel.width = 150;
			panelParentButton.addElement( deleteModel );
			
			var parentDetail:Button = new Button("Parent Detail");
			parentDetail.addEventListener(UIMouseEvent.CLICK, parentDetailHandler );
			parentDetail.width = 150;
			panelParentButton.addElement( parentDetail );
			
			var newModel:Button = new Button("New Model");
			newModel.addEventListener(UIMouseEvent.CLICK, newModelHandler );
			newModel.width = 150;
			panelParentButton.addElement( newModel );

			//var editModel:Button = new Button("Edit Template");
			//editModel.addEventListener(UIMouseEvent.CLICK, editModelHandler );
			//editModel.width = 150;
			//panelParentButton.addElement( editModel );
			
//			if ( true == Globals.g_debug )
//			{
				var oxelUtils:Button = new Button( "Oxel Utils" );
				oxelUtils.addEventListener(UIMouseEvent.CLICK, oxelUtilsHandler );
				oxelUtils.width = 150;
				panelParentButton.addElement( oxelUtils );
//			}
			
			var addCModel:Button = new Button( "Add Child Model..." );
			addCModel.addEventListener(UIMouseEvent.CLICK, addChildModel );
			var deleteCModel:Button = new Button("Delete Child Model");
			deleteCModel.addEventListener(UIMouseEvent.CLICK, deleteChild );
			
			var panelChildButton:Container = new Container( 300, 180 );
			panelChildButton.layout.orientation = LayoutOrientation.VERTICAL;
			panelChildButton.padding = 0;
			panelChildButton.addElement( addCModel );
			panelChildButton.addElement( deleteCModel );
			panelButton.addElement( panelChildButton );

			layout.orientation = LayoutOrientation.VERTICAL;
			addElement( panelButton );
			display();
			
			addEventListener(UIOEvent.REMOVED, onRemoved );
			Globals.g_app.addEventListener( ModelEvent.PARENT_MODEL_ADDED, onParentModelCreated );
        }
		
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
			removeEventListener(UIOEvent.REMOVED, onRemoved );
			Globals.g_app.removeEventListener( ModelEvent.PARENT_MODEL_ADDED, onParentModelCreated );
			removeChildModels();
			Globals.selectedModel = null;
		}
		
		private function addChildModel(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					_fileReference.addEventListener(Event.SELECT, onChildModelFileSelected);
					var swfTypeFilter:FileFilter = new FileFilter("Model Files","*.mjson");
					_fileReference.browse([swfTypeFilter]);
				}
			}
			else
				noModelSelected();
		}
		
		private function oxelUtilsHandler(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					Globals.selectedModel = li.data;
					new WindowOxelUtils( li.data );
				}
			}
			else
				noModelSelected();
		}
		
		private function noModelSelected():void
		{
			(new Alert( "No model selected" )).display();
		}
		
		private function newModelHandler(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			new WindowModelChoice();
			//new WindowNewModel();
		}

		private function editModelHandler(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					Globals.selectedModel = li.data;
					
					new WindowModelTemplate( Globals.selectedModel.modelInfo );
					
				}
			}
			else
				noModelSelected();
			
			//new WindowNewModel();
		}
		
		private function parentDetailHandler(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					Globals.selectedModel = li.data;
					new WindowModelDetail( li.data.instanceInfo );
				}
			}
			else
				noModelSelected();
		}
		
		private function addParent(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			new WindowModelList();
			//_fileReference.addEventListener(Event.SELECT, onModelFileSelected);
			//var swfTypeFilter:FileFilter = new FileFilter("Model Files","*.mjson");
			//_fileReference.browse([swfTypeFilter]);
		}
		
		public function onModelFileSelected(e:Event):void
		{
			// Globals.GUIControl = true;
			var instance:InstanceInfo = new InstanceInfo();
			instance.templateName = _fileReference.name.substr( 0, _fileReference.name.length - _fileReference.type.length )
			instance.grainSize = 6;
			instance.positionSet = Globals.controlledModel.instanceInfo.positionGet.clone();
			instance.positionSetComp( instance.positionGet.x, instance.positionGet.y - Globals.UNITS_PER_METER * 4, instance.positionGet.z );
			Globals.g_modelManager.create( instance );
		}
		
		private var _viewDistance:Vector3D = new Vector3D(0, 0, -75);
		public function onChildModelFileSelected(e:Event):void
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					var parentModel:VoxelModel = li.data;
					var instance:InstanceInfo = new InstanceInfo();
					instance.templateName = _fileReference.name.substr( 0, _fileReference.name.length - _fileReference.type.length )
					instance.positionSet = parentModel.worldToModel( Globals.controlledModel.instanceInfo.positionGet );

					var worldSpaceEndPoint:Vector3D = Globals.controlledModel.instanceInfo.worldSpaceMatrix.transformVector( _viewDistance );
					instance.positionSet = instance.positionGet.add( worldSpaceEndPoint );
					
					
					trace( "onChildModelFileSelected: " + instance.positionGet );
					instance.controllingModel = parentModel;
					Globals.g_modelManager.create( instance );
					Globals.g_app.addEventListener( ModelEvent.CHILD_MODEL_ADDED, onChildModelCreated );
				}
			}
		}
		
		private function onParentModelCreated(event:ModelEvent):void
		{
			var guid:String = event.instanceGuid;
			Log.out( "WindowModels.onParentModelCreated: " + guid );
			populateParentModels();
		}
		
		private function onChildModelCreated(event:ModelEvent):void
		{
			var guid:String = event.instanceGuid;
			var rootGuid:String = event.parentInstanceGuid;
			Log.out( "WindowModels.onChildModelCreated: " + guid );
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
					populateChildModels( li.data );
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( guid );
				if ( vm )
					vm.selected = true;
			}
			else
				noModelSelected();
		}
		
		private function deleteParent(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					Globals.g_modelManager.markDead( li.data.instanceInfo.instanceGuid );
					populateParentModels()
				}
			}
			else
				noModelSelected();
		}
		
		private function deleteChild(event:UIMouseEvent):void 
		{
			// Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					var parentModel:VoxelModel = li.data;
					var lic:ListItem = _listbox2.getItemAt( _listbox2.selectedIndex );
					if ( lic && lic.data )
					{
						parentModel.childRemove( lic.data )
					}
					populateChildModels( li.data );
				}
			}
			else
				noModelSelected();
		}
		
		private function removeChildModels():void
		{
			for each ( var vm:VoxelModel in _listbox2 )
			{
				vm.selected = false;
			}
			_listbox2.removeAll();
		}
		
		private function populateParentModels():void
		{
			_listbox1.removeAll();
			removeChildModels();
			var models:Dictionary = Globals.g_modelManager.modelInstancesGetDictionary();
			for each ( var vm:VoxelModel in models )
			{
				if ( vm && !vm.instanceInfo.dynamicObject && !vm.instanceInfo.dead )
				{
					if ( "Default_Name" != vm.instanceInfo.name )
						_listbox1.addItem( vm.instanceInfo.name + " - " + vm.instanceInfo.instanceGuid, vm );
					else
						_listbox1.addItem( vm.instanceInfo.templateName + " - " + vm.instanceInfo.instanceGuid, vm );
				}
			}
		}

		
		private function populateChildModels( $vm:VoxelModel ):void
		{
			removeChildModels();
			var models:Vector.<VoxelModel> = $vm.children;
			for each ( var vm:VoxelModel in models )
			{
				if ( "Default Name" != vm.instanceInfo.name )
					_listbox2.addItem( vm.instanceInfo.name + " - " + vm.instanceInfo.templateName, vm );
				else	
					_listbox2.addItem( vm.instanceInfo.templateName, vm );
			}
		}
		
		private function selectParentModel(event:ListEvent):void 
		{
			// Globals.GUIControl = true;
			var selectedModel:VoxelModel = event.target.data;
			if ( selectedModel )
			{
				populateChildModels( selectedModel );
			}
		}
		
		public function childModelDetail(event:ListEvent):void 
		{ 
			// Globals.GUIControl = true;
			var vm:VoxelModel = event.target.data;
			if ( vm )
			{
				if ( null != WindowModelDetail.currentInstance )
				{
					WindowModelDetail.currentInstance.remove();
				}
				Globals.selectedModel = vm;
				new WindowModelDetail( vm.instanceInfo );
			}
			else
				Log.out( "WindowModel.childModelDetail - VoxelModelNotFound" );
		}
  }
}