
package com.voxelengine.GUI
{
import com.voxelengine.events.ModeChoiceEvent;
import org.flashapi.swing.button.RadioButtonGroup;
import org.flashapi.swing.databinding.DataProvider;

import org.flashapi.swing.*;
import org.flashapi.swing.event.*;
import org.flashapi.swing.constants.*;

import com.voxelengine.Globals;

public class WindowModeChoice extends VVPopup
{
	public function WindowModeChoice( email:String = "bob@me.com", password:String = "bob" )
	{
		super( "Choice Mode" );
		autoSize = true;
		layout.orientation = LayoutOrientation.VERTICAL;
		closeButtonActive = false;
		
		var rbGroup:RadioButtonGroup = new RadioButtonGroup( this );
		var radioButtons:DataProvider = new DataProvider();
		radioButtons.addAll( { label:"SandBox" }, { label:"Online" } );
		rbGroup.dataProvider = radioButtons;
		eventCollector.addEvent( rbGroup, ButtonsGroupEvent.GROUP_CHANGED
							   , function (event:ButtonsGroupEvent):void {  chooseMode( event.target.index ); } );
		
		display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );
	}

	private function chooseMode( mode:int ):void 
	{
		//Globals.GUIControl = true;
		if ( 1 == mode )
		{
			Globals.g_app.dispatchEvent( new ModeChoiceEvent( ModeChoiceEvent.MODE_ONLINE ) );
		}
		else
		{
			Globals.g_app.dispatchEvent( new ModeChoiceEvent( ModeChoiceEvent.MODE_SANDBOX ) );
		}
		remove();
	}
}
}