
package com.voxelengine.server
{
	import com.voxelengine.GUI.VVPopup;
	import flash.display.FocusDirection;
	import flash.events.FocusEvent;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
	import flash.events.Event;
	
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	import playerio.PlayerIORegistrationError;
	import playerio.Message;
	
	public class WindowRegister extends VVPopup
	{
		private var _userNameInput:LabelInput = null;
		private var _userName:String;
		private var _emailInput:LabelInput = null;
		private var _email:String;
		private var _passwordInput:LabelInput = null;
		private var _password:String;
		private var _password2Input:LabelInput = null;
		private var _password2:String;
		
		public function WindowRegister()
		{
			super( "Register" );
            autoSize = true;
			//width = 300;
			//height = 300;
			layout.orientation = LayoutOrientation.VERTICAL;
			addEventListener(FocusEvent.FOCUS_IN, focusInHandler );
			addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler );
			
			_userName = "GuestUser";
			_userNameInput = new LabelInput( "UserName", _userName );
			_userNameInput.labelControl.width = 80;
			_userNameInput.editableText.addEventListener( TextEvent.EDITED, 
				function( event:TextEvent ):void 
				{ _userName = event.target.text; } );
//				{ Globals.GUIControl = true; _userName = event.target.text; } );
			addElement( _userNameInput );
			
			_email = "me@me.com";
			_emailInput = new LabelInput( "email", _email );
			_emailInput.labelControl.width = 80;
			_emailInput.editableText.addEventListener( TextEvent.EDITED, 
				function( event:TextEvent ):void 
				{ _email = event.target.text; } );
//				{ Globals.GUIControl = true; _email = event.target.text; } );
			addElement( _emailInput );
			
			_password = "";
			_passwordInput = new LabelInput( "Password", _password );
			_passwordInput.labelControl.width = 80;
			_passwordInput.editableText.addEventListener( TextEvent.EDITED, 
				function( event:TextEvent ):void 
				{ _password = event.target.text; } );
//				{ Globals.GUIControl = true; _password = event.target.text; } );
			addElement( _passwordInput );
			
			_password2 = "";
			_password2Input = new LabelInput( "Password", _password2 );
			_password2Input.labelControl.width = 80;
			_password2Input.editableText.addEventListener( TextEvent.EDITED, 
				function( event:TextEvent ):void 
				{ _password2 = event.target.text; } );
//				{ Globals.GUIControl = true; _password2 = event.target.text; } );
			addElement( _password2Input );
			
			var createAccountButton:Button = new Button( "Create Account" );
			addElement( createAccountButton );
			createAccountButton.addEventListener(UIMouseEvent.CLICK, createAccountButtonHandler );
			
			display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );
		}
		
		override protected function focusInHandler(e:FocusEvent):void
		{
			trace( "WindowRegister.focusInHandler - got focus" );
		}
		
		override protected function focusOutHandler( event:FocusEvent ):void
		{
			trace( "WindowRegister.focusOutHandler - lost focus" );
		}

		private function createAccountButtonHandler(event:UIMouseEvent):void 
		{
			//Globals.GUIControl = true;
			trace( "userName: " + _userName + "  password: " + _password + "  email:" + _email );
			PlayerIO.quickConnect.simpleRegister(
									Globals.g_app.stage,
									"voxelverse-lpeje46xj0krryqaxq0vog",
									_userName,
									_password,
									_email,
									"", 	// the captcha key from the simpleGetCaptcha() method
									"", 	// the captcha text entered by the user
									null, 	// Extra data attached to the user on creation
									"", 	// String that identifies a possible affiliate partner.
									registrationSucess,
									registrationError
								);
		}
		
		private function registrationError(e:PlayerIORegistrationError):void
		{
			trace("WindowRegister.registrationError Error: ", e);
		}
			
		private function registrationSucess(client:Client):void 
		{ 
			trace("simpleRegister succeed");
			new WindowLogin( _email, _password );
			remove();
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
	}
}