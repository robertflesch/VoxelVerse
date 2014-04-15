
package com.voxelengine.server
{
	import flash.events.Event;
	
	import org.flashapi.swing.*;
	import org.flashapi.swing.button.ButtonGroup;
    import org.flashapi.swing.event.*;
	import org.flashapi.swing.color.SVGCK;
    import org.flashapi.swing.constants.*;
	
	import playerio.Client;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.LoginEvent;
	import com.voxelengine.GUI.VVPopup;
	import com.voxelengine.GUI.WindowSandboxList;
	
	public class WindowLogin extends VVPopup
	{
		//private var eventCollector:EventCollector = new EventCollector();
		private var _emailInput:LabelInput = null;
		private var _email:String;
		private var _passwordInput:LabelInput = null;
		private var _password:String;
		private var _result:Text;

		public function WindowLogin( email:String = "bob@me.com", password:String = "bob" )
		{
			super( "Login" );
            autoSize = true;
			//width = 300;
			//height = 300;
			layout.orientation = LayoutOrientation.VERTICAL;
			
			_email = email;
			_emailInput = new LabelInput( "email", _email );
			_emailInput.labelControl.width = 80;
			_emailInput.editableText.addEventListener( TextEvent.EDITED, 
				function( event:TextEvent ):void 
				{ _email = event.target.text; } );
//				{ Globals.GUIControl = true; _email = event.target.text; } );
			addElement( _emailInput );
			
			_password = password;
			_passwordInput = new LabelInput( "Password", _password );
			_passwordInput.labelControl.width = 80;
			_passwordInput.editableText.addEventListener( TextEvent.EDITED, 
				function( event:TextEvent ):void 
				{ _password = event.target.text; } );
//				{ Globals.GUIControl = true; _password = event.target.text; } );
			addElement( _passwordInput );
			
			//var buttonPanel:Panel = new Panel( 200, 30 );
			var loginButton:Button = new Button( "Login" );
			loginButton.addEventListener(UIMouseEvent.CLICK, loginButtonHandler );
			addElement( loginButton );
			
			var registerButton:Button = new Button( "Register" );
			registerButton.addEventListener(UIMouseEvent.CLICK, registerButtonHandler );
			addElement( registerButton );
			
			_result = new Text(200, 30);
			_result.textAlign = TextAlign.CENTER;
			_result.textFormat.size = 16;
			var my_SVGCK:SVGCK = new SVGCK("orangered");
			_result.textFormat.color = my_SVGCK;
			addElement( _result );
			
			//addElement( buttonPanel );
			
			display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );
			
			//Globals.g_app.stage.addEventListener( LoginEvent.LOGIN_SUCCESS, onLoginSucess );
		}

			
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
            Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
			removeEventListener(UIOEvent.REMOVED, onRemoved );
		}
		
        protected function onResize(event:Event):void
        {
			move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
		}
		
		private function loginButtonHandler(event:UIMouseEvent):void 
		{
			//Globals.GUIControl = true;
			PlayerIO.quickConnect.simpleConnect( Globals.g_app.stage
											   , "voxelverse-lpeje46xj0krryqaxq0vog"
											   , _email
											   , _password
											   , connectSuccess
											   , connectFailure );
			trace("WindowLogin.loginButtonHandler - Trying to establish connection to server");
		}
		
		private function registerButtonHandler(event:UIMouseEvent):void 
		{
			//Globals.GUIControl = true;
			new WindowRegister();
			remove();
		}
		
		public function connectFailure(error:PlayerIOError):void
		{
			_result.text = error.message;
			trace("VVServer.handleConnectError",error)
		}
		
		public function connectSuccess( $client:Client):void
		{
			trace("WindowLogin.connectSuccess - connection to server established");
			
			//Set developmentsever (Comment out to connect to your server online)
			$client.multiplayer.developmentServer = "localhost:8184";
			Network.userId = $client.connectUserId;
			Network.client = $client

			Globals.online = true;
			remove();
			if ( !WindowSandboxList.isActive )
				WindowSandboxList.create();
		}
		
		//private function onLoginSucess( event:LoginEvent ):void 
		//{
			//Globals.online = true;
			//remove();
			//if ( !WindowSandboxList.isActive )
				//WindowSandboxList.create();
		//}
	}
}