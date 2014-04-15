
package com.voxelengine.GUI
{

	import org.flashapi.swing.*;
	import org.flashapi.swing.button.RadioButtonGroup;
	import org.flashapi.swing.databinding.DataProvider;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.containers.*;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.ModelInfo;
	
	/////////////////////////////////////////////////////		
	public class PanelModelInfoDetail extends VVContainer
	{
		private var _templateName:TextInput = null;
		private var _templateLabel:Label = null;
		private var _mi:ModelInfo = null;
		public function PanelModelInfoDetail( $width:int, $height:int, $mi:ModelInfo ):void
		{
			_mi = $mi;
			super( $width, $height );
//			borderColor = Color.WINDOWS_WORKSPACE_COLOR;
			layout.orientation = LayoutOrientation.VERTICAL;
			layout.verticalAlignment = LayoutVerticalAlignment.TOP;
			layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			
			addElement( new Label( "File Name" ) );
			var fileNameInput:TextInput = new TextInput( _mi.fileName );
			fileNameInput.width = $width - $width/5;
			fileNameInput.height = 20;
//			eventCollector.addEvent( fileNameInput, TextEvent.EDITED
//								   , function(e:TextEvent):void { _mi.fileName = e.target.text; Globals.GUIControl = true; } );
			eventCollector.addEvent( fileNameInput, TextEvent.EDITED
								   , function(e:TextEvent):void { _mi.fileName = e.target.text; } );
			addElement( fileNameInput );
			
			addElement( new Label( "User Friendly Name" ) );
			var nameInput:TextInput = new TextInput( _mi.name );
			nameInput.width = $width - $width/5;
			nameInput.height = 20;
//			eventCollector.addEvent( nameInput, TextEvent.EDITED
//								   , function(e:TextEvent):void { _mi.name = e.target.text; Globals.GUIControl = true; } );
			eventCollector.addEvent( nameInput, TextEvent.EDITED
								   , function(e:TextEvent):void { _mi.name = e.target.text; } );
			addElement( nameInput );
			
			addElement( new Label( "Description" ) );
			var descInput:TextArea = new TextArea( $width - $width / 5 );
			descInput.appendText( _mi.desc );
//			eventCollector.addEvent( descInput, TextEvent.EDITED
//								   , function(e:TextEvent):void { _mi.desc = e.target.text; Globals.GUIControl = true; } );
			eventCollector.addEvent( descInput, TextEvent.EDITED
								   , function(e:TextEvent):void { _mi.desc = e.target.text; } );
			addElement( descInput );
			
			addElement( new Label( "Class of Object" ) );
			var cbClass:ComboBox = new ComboBox( "Class" );
			cbClass.addItem( "Meldable" );
			cbClass.addItem( "Ship" );
			cbClass.addItem( "Gun" );
			cbClass.addEventListener(ListEvent.LIST_CHANGED, selectionChanged );
			if ( _mi.modelClass != "" )
			{
				for ( var index:int = cbClass.size - 3; 0 <= index; index-- )
				{
					var li:ListItem = cbClass.getItemAt( index );
					if ( _mi.modelClass == li.value )
					{
						cbClass.selectedIndex = index;
						break;
					}
				}
			}
			addElement( cbClass );
			
			function selectionChanged( me:ListEvent ):void
			{
				var cb:ComboBox = me.target as ComboBox;
				if ( -1 == cb.selectedIndex )
					return;
				var li:ListItem = cb.getItemAt(cb.selectedIndex );
				_mi.modelClass = li.value;
				
				(me.target as ComboBox).getItemAt( (me.target as ComboBox).selectedIndex ).value;
				_mi.modelClass = li.value;
			}
		
			//--------------------- Template and Editable Radio button -------------------------------------------------------
			var rbGroup:RadioButtonGroup = new RadioButtonGroup( this );
			var radioButtons:DataProvider = new DataProvider();
            radioButtons.addAll( { label:"Template" }, { label:"Editable" } );
			eventCollector.addEvent( rbGroup, ButtonsGroupEvent.GROUP_CHANGED
			                       , function (event:ButtonsGroupEvent):void {  checkAnswer( 0 == event.target.index ? true : false ); } );
			rbGroup.dataProvider = radioButtons;

			_templateLabel = new Label( "Template Name" )
			addElement( _templateLabel );
			_templateName = new TextInput( "" );
			_templateName.width = $width - $width/5;
			_templateName.height = 20;
			addElement( _templateName );
			
			// Now that all of the peices have been created, initialize the radio buttons
			if ( _mi.template )
				rbGroup.index = 0;
			else	
				rbGroup.index = 1;

			function checkAnswer( isTemplate:Boolean ):void
			{
                if (   isTemplate )
				{
					_templateLabel.visible = true;
					_templateName.visible = true;
					_mi.template = true;
					_mi.editable = false;
				}
				else
				{
					_templateLabel.visible = false;	
					_templateName.visible = false;
					_mi.template = false;
					_mi.editable = true;
				}
			}
		}
	}
}
///////////////////////////		
