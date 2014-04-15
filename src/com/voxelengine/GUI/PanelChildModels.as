
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

	public class PanelChildModels extends VVContainer
	{
		private var _lbChildModel:ListBox = null;
		private var _parentModel:VoxelModel = null
		private var _ii:InstanceInfo = null
		private var _mi:ModelInfo = null;
		
		public function PanelChildModels( $width:int, $height:int, $mi:ModelInfo )
		{
			super( $width, $height );
			_mi = $mi;
			
			layout.orientation = LayoutOrientation.VERTICAL;
			
			_lbChildModel = new ListBox( $width, 15, $height - 40 );
			_lbChildModel.addEventListener(ListEvent.LIST_CHANGED, childModelDetail );
			this.addElement( _lbChildModel );
			
			var addCModel:Button = new Button( "Add Child Model..." );
			addCModel.addEventListener(UIMouseEvent.CLICK, addChildModel );
			var deleteCModel:Button = new Button("Delete Child Model");
			deleteCModel.addEventListener(UIMouseEvent.CLICK, deleteChild );
			
			this.addElement( addCModel );
			this.addElement( deleteCModel );
			
			for each ( var childModel:InstanceInfo in _mi.children )
			{
				_lbChildModel.addItem( childModel.name );
			}
			
        }
		
		
		
		private function addChildModel(event:UIMouseEvent):void 
		{
			new Alert( "Where do I get my list of child models from?" );
			/*
			//Globals.GUIControl = true;
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
			*/
		}
		
		
		private function newModelHandlerOld(event:UIMouseEvent):void 
		{
			//Globals.GUIControl = true;
			var ii:InstanceInfo = new InstanceInfo();
			ii.templateName = "GenerateCube";
			ii.name = "New Object";
			// preload the modelInfo for the GenerateCube
			Globals.g_modelManager.modelInfoPreload( ii.templateName );
			new WindowNewModelGenerateCube( ii );
		}

		private function newModelHandler(event:UIMouseEvent):void 
		{
			//Globals.GUIControl = true;
			new WindowModelTemplate( new ModelInfo() );
			//new WindowNewModel();
		}

		private var _viewDistance:Vector3D = new Vector3D(0, 0, -75);
		public function onChildModelFileSelected(e:Event):void
		{
			/*
			//Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					var parentModel:VoxelModel = li.data;
					var instance:InstanceInfo = new InstanceInfo();
					instance.fileName = _fileReference.name.substr( 0, _fileReference.name.length - _fileReference.type.length )
					instance.positionSet = parentModel.worldToModel( Globals.controlledModel.instanceInfo.positionGet );

					var worldSpaceEndPoint:Vector3D = Globals.controlledModel.instanceInfo.worldSpaceMatrix.transformVector( _viewDistance );
					instance.positionSet = instance.positionGet.add( worldSpaceEndPoint );
					
					
					trace( "onChildModelFileSelected: " + instance.positionGet );
					instance.controllingModel = parentModel;
					Globals.g_modelManager.create( instance );
					Globals.g_app.addEventListener( ModelEvent.CHILD_MODEL_ADDED, onChildModelCreated );
				}
			}
			*/
		}
		
		private function onChildModelCreated(event:ModelEvent):void
		{
			/*
			var guid:String = event.ownerGuid;
			var rootGuid:String = event.parentInstanceGuid;
			Log.out( "PanelChildModels.onChildModelCreated: " + guid );
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
					populateChildModels( li.data );
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( guid );
				if ( vm )
					vm.selected = true;
			}
			*/
		}
		
		private function deleteChild(event:UIMouseEvent):void 
		{
			/*
			//Globals.GUIControl = true;
			if ( -1 < _listbox1.selectedIndex )
			{
				var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
				if ( li && li.data )
				{
					var parentModel:VoxelModel = li.data;
					var lic:ListItem = _lbChildModel.getItemAt( _lbChildModel.selectedIndex );
					if ( lic && lic.data )
					{
						parentModel.childRemove( lic.data )
					}
					populateChildModels( li.data );
				}
			}
			*/
		}
		
		private function removeChildModels():void
		{
			for each ( var vm:VoxelModel in _lbChildModel )
			{
				vm.selected = false;
			}
			_lbChildModel.removeAll();
		}
		
		private function populateChildModels( $vm:VoxelModel ):void
		{
			removeChildModels();
			var models:Vector.<VoxelModel> = $vm.children;
			for each ( var vm:VoxelModel in models )
			{
				if ( "Default Name" != vm.instanceInfo.name )
					_lbChildModel.addItem( vm.instanceInfo.name + " - " + vm.instanceInfo.templateName, vm );
				else	
					_lbChildModel.addItem( vm.instanceInfo.templateName, vm );
			}
		}
		
		public function childModelDetail(event:ListEvent):void 
		{ 
			//Globals.GUIControl = true;
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
