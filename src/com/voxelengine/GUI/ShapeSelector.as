
package com.voxelengine.GUI
{
	import org.flashapi.swing.Container;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.constants.BorderStyle;
    import org.flashapi.swing.event.UIMouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.flashapi.collector.EventCollector;
	import com.voxelengine.worldmodel.models.EditCursor;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	public class ShapeSelector extends VVCanvas
	{
		private var _evtColl:EventCollector = new EventCollector();;
		private const IMAGE_SIZE:int = 64;
		private var _butCurrent:Box;
		
		public function ShapeSelector()
		{
		}
		
		public function addShapeSelector():void
		{
			_butCurrent = new Box(IMAGE_SIZE, IMAGE_SIZE);
			_butCurrent.x = IMAGE_SIZE * 0;
			_butCurrent.y = 0;
			_butCurrent.data = "square";
			_butCurrent.backgroundTexture = "assets/textures/square.jpg";
			addElement( _butCurrent );
			
			
			var hk:Label = new Label("", 20);
//			hk.x = -20;
			hk.fontColor = 0xffffff;
			hk.text = "F8";
			addElement(hk);
			
			_evtColl.addEvent( _butCurrent, UIMouseEvent.PRESS, pressShape );
			_evtColl.addEvent( _butCurrent, UIMouseEvent.RELEASE, releaseShape );
			_evtColl.addEvent( hk, UIMouseEvent.PRESS, pressShape );
			_evtColl.addEvent( hk, UIMouseEvent.RELEASE, pressShape );
			
			//_evtColl.addEvent( box, MouseEvent.ROLL_OVER, report);
			//_evtColl.addEvent( box, MouseEvent.ROLL_OUT, report);
			display();
		}
		
		public function pressShapeHotKey(e:KeyboardEvent):void 
		{
			nextShape();
		}
		private function pressShape(event:UIMouseEvent):void 
		{
			nextShape();
		}
		private function nextShape():void
		{
			if ( "square" == _butCurrent.data)
			{
				_butCurrent.data = "cylinder";	
				_butCurrent.backgroundTexture = "assets/textures/cylinder.jpg";
				EditCursor.cursorType = EditCursor.CURSOR_TYPE_CYLINDER;
				if ( EditCursor.CURSOR_OP_DELETE == EditCursor.cursorOperation )
					EditCursor.cursorColor = Globals.EDITCURSOR_CYLINDER;
				//EditCursor.cursorColor = Globals.EDITCURSOR_CYLINDER_ANIMATED;
			} 
			else if ( "cylinder" == _butCurrent.data)
			{
				_butCurrent.data = "sphere";	
				_butCurrent.backgroundTexture = "assets/textures/sphere.jpg";
				EditCursor.cursorType = EditCursor.CURSOR_TYPE_SPHERE;
				if ( EditCursor.CURSOR_OP_DELETE == EditCursor.cursorOperation )
					EditCursor.cursorColor = Globals.EDITCURSOR_ROUND;
			} 
			else if ( "sphere" == _butCurrent.data)
			{
				_butCurrent.data = "square";	
				_butCurrent.backgroundTexture = "assets/textures/square.jpg";
				EditCursor.cursorType = EditCursor.CURSOR_TYPE_GRAIN;
				if ( EditCursor.CURSOR_OP_DELETE == EditCursor.cursorOperation )
					EditCursor.cursorColor = Globals.EDITCURSOR_SQUARE;
			}
		}
		
		private function releaseShape(e:UIMouseEvent):void 
		{
//			Globals.GUIControl = false;
		}			
		
		//static public function report(evt:MouseEvent):void
		//{
			//if ( "rollOver" == evt.type )
			//{
				//Globals.GUIControl = true;
			//}
			//else if ( "rollOut" == evt.type )
			//{
//				Globals.GUIControl = false;
			//}
		//}			
	}
}