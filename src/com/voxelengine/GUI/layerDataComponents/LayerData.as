
package com.voxelengine.GUI.layerDataComponents
{

	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import org.flashapi.swing.*;
	import org.flashapi.swing.button.RadioButtonGroup;
	import org.flashapi.swing.button.SimpleRadioButtonGroup;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.databinding.DataProvider;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.containers.*;
	
	import flash.utils.Dictionary;
	//import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	
	import flash.geom.Vector3D;

	public class LayerData extends SimpleContainerBase
	{
		public function LayerData( $label:String, $value:String, callBack:Function, $width:int = 180, $height:int = 20 ):void
		{
			super( $width, $height );
			padding = 0;
			//var compWidth = $width - 60;
			addElement( new Label( $label, 140 ) );
			var ti:TextInput = new TextInput( $value, 60 );
			ti.data = $label;
			addElement( ti );
			//worker.myEventCollector.addEvent( Text
			ti.addEventListener( TextEvent.EDITED, callBack );
		}
	}
}

