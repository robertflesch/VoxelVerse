/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine
{

	import com.furusystems.dconsole2.DConsole;
	import com.furusystems.logging.slf4as.Logging;
	import com.furusystems.logging.slf4as.ILogger;

	
	public class Log {
		
		public static const DEBUG:int = 0;
		public static const INFO:int = 1;
		public static const WARN:int = 2;
		public static const ERROR:int = 3;
		public static const FATAL:int = 4;
		
		private static var _showing:Boolean = false;
		private static var _initialized:Boolean = false;
		private static const L:ILogger = Logging.getLogger(Log);
		
		public static function get showing():Boolean { return _showing; }
		public static function hide():void
		{
			DConsole.hide();
			_showing = false;
		}
		
		public static function show():void
		{
			if ( !_initialized )
			{
				_initialized = true;
				Globals.g_app.addChild(DConsole.view);
				out("VoxelVerse.init - console created", Log.INFO);
				DConsole.createCommand( "hide", hide );
				ConsoleCommands.addCommands();
				out( "Type 'hide' or '`' to hide the console" );
			}
			DConsole.show();
			_showing = true;
		}
		
		public static function out( msg:String, type:int = INFO ):void
		{

			trace( msg );
			
			if ( INFO < type )
				show();

				if ( _showing )
			{
				switch ( type )
				{ 
					//case DEBUG:
						//Log.L.debug(msg); //These are general debugging messages (your commonplace traces)
						//break;
					//case INFO:
						//Log.L.info(msg); //These are general debugging messages (your commonplace traces)
						//break;
					case WARN:
						Log.L.warn(msg);
						break;
					case ERROR:
						Log.L.error("*** " + msg);
						break;
					case FATAL:
						Log.L.fatal(msg);
						break;
				}
			}
		}
	}
}