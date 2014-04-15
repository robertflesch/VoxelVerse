
package com.voxelengine.GUI.layerDataComponents
{

	//import com.voxelengine.events.ModelEvent;
	//import com.voxelengine.worldmodel.biomes.LayerInfo;
	//import com.voxelengine.worldmodel.models.ModelInfo;
	//import org.flashapi.swing.*;
	//import org.flashapi.swing.button.RadioButtonGroup;
	//import org.flashapi.swing.button.SimpleRadioButtonGroup;
	//import org.flashapi.swing.color.Color;
	//import org.flashapi.swing.databinding.DataProvider;
    //import org.flashapi.swing.event.*;
    //import org.flashapi.swing.constants.*;
	//import org.flashapi.swing.list.ListItem;
	//import org.flashapi.swing.containers.*;
	//
	//import flash.utils.Dictionary;
	//import flash.events.Event;
	//import flash.net.FileReference;
	//import flash.net.FileFilter;
	//
	//import com.voxelengine.Globals;
	//import com.voxelengine.Log;
	//import com.voxelengine.worldmodel.models.VoxelModel;
	//import com.voxelengine.worldmodel.models.InstanceInfo;
	
	import flash.geom.Vector3D;

	class LayerTypeData extends SimpleContainerBase
	{
		public function LayerTypeData( $label:String, $value:String, callBack:Function, $width:int = 180, $height:int = 20 ):void
		{
			super( $width, $height );
			padding = 0;
			autoSize = false;
			addElement( new Label( "Made of Type" ) );
			
			var cbType:ComboBox = new ComboBox( $value, 80, 10 );
			cbType.addEventListener( ListEvent.LIST_CHANGED, callBack );
			cbType.x = $width - 80;
			for each (var nitem:TypeInfo in Globals.Info )
			{
				//if ( "INVALID" != nitem.name && "AIR" != nitem.name && "BRAND" != nitem.name && -1 == nitem.name.indexOf( "EDIT" ) && -1 == nitem.name.indexOf( "UNNAMED" ) )
				if ( "INVALID" != nitem.name && "AIR" != nitem.name && "BRAND" != nitem.name && -1 == nitem.name.indexOf( "EDIT" ) )
				{
					cbType.addItem( nitem.name, nitem.type );
				}
			}
			cbType.selectedIndex = 0;
			addElement( cbType );
		}
	}
}

