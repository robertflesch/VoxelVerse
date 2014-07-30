
package com.voxelengine.GUI
{
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.events.RegionEvent;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.Region;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	public class WindowModelDetail extends VVPopup
	{
		static private var _s_inExistance:int = 0;
		static private var _s_currentInstance:WindowModelDetail = null;
		
		private var _eventCollector:EventCollector = new EventCollector();
		private var _textInputX:TextInput;
		private var _textInputY:TextInput;
		private var _textInputZ:TextInput;
		private var _textInputXRot:TextInput;
		private var _textInputYRot:TextInput;
		private var _textInputZRot:TextInput;

		private var _panelAdvanced:Panel;
		
		private var _ii:InstanceInfo = null;
		
		private static const BORDER_WIDTH:int = 4;
		private static const BORDER_WIDTH_2:int = BORDER_WIDTH * 2;
		private static const BORDER_WIDTH_3:int = BORDER_WIDTH * 3;
		private static const BORDER_WIDTH_4:int = BORDER_WIDTH * 4;
		
		private var _calculatedWidth:int = 300;
		private var _calculatedHeight:int = 20;

		static public function get inExistance():int { return _s_inExistance; }
		static public function get currentInstance():WindowModelDetail { return _s_currentInstance; }
		
		private function addSpinLabel( parentPanel:Panel, label:String, clickHandler:Function, textChanged:Function, initialValue:String ):TextInput
		{
			var lbl:Label = new Label(label);
			lbl.width = 80;
			lbl.height = 20;
			
			var src:TextInput = new TextInput(initialValue);
			src.width = 80;
			src.height = 20;
			src.x = 100;
			src.addEventListener( TextEvent.EDITED, textChanged );
			
			var sb:SpinButton = new SpinButton( 20, 20 );
			sb.addEventListener( SpinButtonEvent.CLICK_DOWN, clickHandler );
			sb.addEventListener( SpinButtonEvent.CLICK_UP, clickHandler );

			//var myWidth:int = li.width + sb.width + BORDER_WIDTH_4 + BORDER_WIDTH_2;
			//var myHeight:int = sb.height + BORDER_WIDTH_4;
			
			var panel:Panel = new Panel( 300, 100 );
			panel.layout.orientation = LayoutOrientation.HORIZONTAL;
			
			panel.addElement( lbl );
			panel.addElement( src );
			panel.addElement( sb );
			panel.width = lbl.width + src.width + sb.width + BORDER_WIDTH_4 + BORDER_WIDTH_2;
			panel.height = sb.height + BORDER_WIDTH_4;
			panel.borderWidth = BORDER_WIDTH;
			parentPanel.addElement( panel );
			
			//_calculatedWidth = Math.max( panel.width, _calculatedWidth );
			//_calculatedHeight += panel.height;
			
			return src;
		}
		
		private function addLabel( parentPanel:Panel, label:String, changeHandler:Function, initialValue:String, inputEnabled:Boolean = false ):LabelInput
		{
			var li:LabelInput = new LabelInput( label, initialValue );
			li.labelControl.width = 120;
			if ( null != changeHandler )
				li.editableText.addEventListener( TextEvent.EDITED, changeHandler );
			else
			{
				li.editableText.editable = false;
				li.editableText.fontColor = 0x888888;
			}

			var myWidth:int = li.width + BORDER_WIDTH_4 + BORDER_WIDTH_2;
			var myHeight:int = li.height + BORDER_WIDTH_4;
			var panel:Panel = new Panel( myWidth, myHeight );
			panel.addElement( li );
			panel.borderWidth = BORDER_WIDTH;
			parentPanel.addElement( panel );
			_calculatedWidth = Math.max( myWidth, _calculatedWidth );
			
			return li;
		}

		private function LocationGroup():void
		{
			var label:Text = new Text( 300, 20 );
			label.text = "Location";
			label.textAlign = TextAlign.CENTER;
			label.fontSize = 16;
			label.fixToParentWidth = true;
			var panel:Panel = new Panel( 300, 20 );
//			panel.autoSize =  true;
			panel.padding = 0;
			panel.addElement( label );
			_textInputX = addSpinLabel( panel, "X:", spe_x, labele_x,  _ii.positionGet.x.toFixed(0) );
			_textInputY = addSpinLabel( panel, "Y:", spe_y, labele_y, _ii.positionGet.y.toFixed(0) );
			_textInputZ = addSpinLabel( panel, "Z:", spe_z, labele_z, _ii.positionGet.z.toFixed(0) );
			panel.layout.orientation = LayoutOrientation.VERTICAL;
			panel.width = _calculatedWidth;
			panel.height = label.height + _textInputX.height * 6 + BORDER_WIDTH_4;
			addElement( panel );
		}
		
		private function RotationGroup():void
		{
			var label:Text = new Text( 300, 20 );
			label.text = "Rotation";
			label.textAlign = TextAlign.CENTER;
			label.fontSize = 16;
			label.fixToParentWidth = true;
			var panel:Panel = new Panel( 300, 20 );
			panel.padding = 0;
			panel.addElement( label );
			_textInputXRot = addSpinLabel( panel, "X:", spe_rot_x, labele_rot_x, _ii.rotationGet.x.toFixed(0) );
			_textInputYRot = addSpinLabel( panel, "Y:", spe_rot_y, labele_rot_y, _ii.rotationGet.y.toFixed(0) );
			_textInputZRot = addSpinLabel( panel, "Z:", spe_rot_z, labele_rot_z, _ii.rotationGet.z.toFixed(0) );
			panel.layout.orientation = LayoutOrientation.VERTICAL;
			panel.width = _calculatedWidth;
			panel.height = label.height + _textInputX.height * 6 + BORDER_WIDTH_4;
			panel.layout.autoSizeAnimated = true;
			addElement( panel );
		}
		
		private function Advanced():void
		{
			var label:Text = new Text( 300, 20 );
			label.text = "Advanced";
			label.textAlign = TextAlign.CENTER;
			label.fontSize = 16;
			label.fixToParentWidth = true;
			//label.addEventListener(MouseEvent.CLICK, close );
			_panelAdvanced = new Panel( 300, 20 );
            _panelAdvanced.autoSize = true;
			_panelAdvanced.padding = 0;
			_panelAdvanced.layout.orientation = LayoutOrientation.VERTICAL;
           //_panelAdvanced.layout.autoSizeAnimated = true;
			_panelAdvanced.addElement( label );
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _ii.instanceGuid )
							addLabel( _panelAdvanced, "State:", changeStateHandler, vm.anim ? vm.anim.name : "" );
							addLabel( _panelAdvanced, "Name:", changeNameHandler, _ii.name );
			//_GrainSize = 	addLabel( _panelAdvanced, "GrainSize:", null, _vm.oxel.gc.grain.toString() );
							addLabel( _panelAdvanced, "GrainSize:", null, String( _ii.grainSize ) );
			addLabel( _panelAdvanced, "Instance GUID:", null, _ii.instanceGuid );
			addLabel( _panelAdvanced, "Model GUID:", null, _ii.templateName );
			addLabel( _panelAdvanced, "Parent:", null, _ii.controllingModel ? _ii.controllingModel.instanceInfo.templateName : "" );
			//addLabel( _panelAdvanced, "Script:", null, _ii.scriptName );
			//_Texture = 		addLabel( _panelAdvanced, "Texture:", null, _ii.textureName );
			//_TextureScale =	addLabel( _panelAdvanced, "TextureScale:", null, _ii.textureScale.toString() );
			
			addElement( _panelAdvanced );
		}
		
		public function WindowModelDetail( $ii:InstanceInfo )
		{
			super( "Model Details" );
			_s_inExistance++;
			_s_currentInstance = this;
			
			_ii = $ii;
			onCloseFunction = closeFunction;
			defaultCloseOperation = ClosableProperties.CALL_CLOSE_FUNCTION;
			layout.orientation = LayoutOrientation.VERTICAL;
            autoSize = true;
			shadow = true;
			
			LocationGroup();
			RotationGroup();
			Advanced();

			display( 400, 20 );
        }
		
		private function closeFunction():void
		{
//			Globals.GUIControl = false;
			_s_inExistance--;
			_s_currentInstance = null;
			
			Globals.g_app.dispatchEvent( new ModelEvent( ModelEvent.MODEL_MODIFIED, _ii.instanceGuid ) );
			Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_MODIFIED, "" ) );
		}
		
		private function spe_x(event:SpinButtonEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( _textInputX.text );
			if ( "clickDown" == event.type ) 	ival--;
			else 								ival++;
			_ii.positionSetComp( ival, _ii.positionGet.y, _ii.positionGet.z );
			_textInputX.text = ival.toString();
		}
		private function spe_y(event:SpinButtonEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( _textInputY.text );
			if ( "clickDown" == event.type ) 	ival--;
			else 								ival++;
			//_ii.position.y = ival;
			_ii.positionSetComp( _ii.positionGet.x, ival, _ii.positionGet.z );
			_textInputY.text = ival.toString();
		}
		private function spe_z(event:SpinButtonEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( _textInputZ.text );
			if ( "clickDown" == event.type ) 	ival--;
			else 								ival++;
			//_ii.position.z = ival;
			_ii.positionSetComp( _ii.positionGet.x, _ii.positionGet.y, ival );
			_textInputZ.text = ival.toString();
		}

		private function changeNameHandler(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			_ii.name = event.target.text;
		}
		
		private function changeStateHandler(event:TextEvent):void
		{
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _ii.instanceGuid )
			var state:String = event.target.text;
			vm.stateLock( false );
			vm.stateSet( state );
			vm.stateLock( true );
		}

		private function labele_x(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( event.target.text );
			//_ii.position.x = ival;
			_ii.positionSetComp( ival, _ii.positionGet.y, _ii.positionGet.z );
		}
		private function labele_y(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( event.target.text );
			//_ii.position.y = ival;
			_ii.positionSetComp( _ii.positionGet.x, ival, _ii.positionGet.z );
		}
		private function labele_z(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( event.target.text );
			_ii.positionSetComp( _ii.positionGet.x, _ii.positionGet.y, ival );
			//_ii.position.z = ival;
		}
		
		private function labele_rot_x(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( event.target.text );
//			_ii.rotation.x = ival;
			_ii.rotationSet = new Vector3D( ival, _ii.rotationGet.y, _ii.rotationGet.z );
		}
		private function labele_rot_y(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( event.target.text );
			//_ii.rotation.y = ival;
			_ii.rotationSet = new Vector3D( _ii.rotationGet.x, ival, _ii.rotationGet.z );
		}
		private function labele_rot_z(event:TextEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( event.target.text );
			//_ii.rotation.z = ival;
			_ii.rotationSet = new Vector3D( _ii.rotationGet.x, _ii.rotationGet.y, ival );
		}
		
		private function spe_rot_x(event:SpinButtonEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( _textInputXRot.text );
			if ( "clickDown" == event.type ) 	ival--;
			else 								ival++;
			//_ii.rotation.x = ival;
			_ii.rotationSet = new Vector3D( ival, _ii.rotationGet.y, _ii.rotationGet.z );
			_textInputXRot.text = ival.toString();
		}
		private function spe_rot_y(event:SpinButtonEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( _textInputYRot.text );
			if ( "clickDown" == event.type ) 	ival--;
			else 								ival++;
			//_ii.rotation.y = ival;
			_ii.rotationSet = new Vector3D( _ii.rotationGet.x, ival, _ii.rotationGet.z );
			_textInputYRot.text = ival.toString();
		}
		private function spe_rot_z(event:SpinButtonEvent):void
		{
			// Globals.GUIControl = true;
			var ival:int = int( _textInputZRot.text );
			if ( "clickDown" == event.type ) 	ival--;
			else 								ival++;
			//_ii.rotation.z = ival;
			_ii.rotationSet = new Vector3D( _ii.rotationGet.x, _ii.rotationGet.y, ival );
			_textInputZRot.text = ival.toString();
		}

        private function close(e:MouseEvent):void { setHeight(0); }
        private function open():void { setHeight(20); }
  
        private function setHeight(height:Number):void {
			
			//_GrainSize.height = height;
			//_InstanceGUID.height = height;
			//_ModelGUID.height = height;
			//_Parent.height = height;
			//_Script.height = height;
			//_Texture.height = height;
			//_TextureScale.height = height;
			//_ModelClass.height = height;
			_panelAdvanced.height = 20;
            //_image.height = height;
            //_.label = height == 0 ? "Double click to open" : "Double click to close";
        }		
		
	}
}