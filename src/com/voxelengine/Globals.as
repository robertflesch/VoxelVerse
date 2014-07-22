/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine {
	import com.voxelengine.worldmodel.RegionManager;
	import com.voxelengine.worldmodel.Sky;
	import com.voxelengine.worldmodel.TextureBank;
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.oxel.OxelBad;
	import com.voxelengine.worldmodel.ConfigManager;
	import com.voxelengine.worldmodel.MouseKeyboardHandler;
	import com.voxelengine.renderer.Renderer;
	import com.voxelengine.utils.GUID;

	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;

	import com.developmentarc.core.tasks.TaskController;
	
	public class Globals  {
		public static var g_app:VoxelVerse = null;
		
		public static var g_modelManager:ModelManager = new ModelManager();
		public static var g_textureBank:TextureBank = new TextureBank();
		public static var g_regionManager:RegionManager = null;
		public static var g_renderer:Renderer = new Renderer();
		public static var g_mouseKeyboardHandler:MouseKeyboardHandler = new MouseKeyboardHandler();

		public static var g_nearplane:Number = 1/4;
		public static var g_farplane:Number = 65536 / 4;
		public static const UNITS_PER_METER:int = 16;
		static public const AVATAR_HEIGHT:int = ( UNITS_PER_METER * 2 ) - ( UNITS_PER_METER * 0.2 ); // 80% of two meters
		static public const AVATAR_WIDTH:int = UNITS_PER_METER;
		static public const AVATAR_HEIGHT_FOOT:int = 0;
		static public const AVATAR_HEIGHT_HEAD:int = AVATAR_HEIGHT;
		static public const AVATAR_HEIGHT_CHEST:int = 20;
		
		static public const GRAVITY:int = 10;
		
		static public const VERSION_000:String = "000";
		static public const VERSION_001:String = "001";
		static public const VERSION_002:String = "002";
		static public const VERSION_003:String = "003";
		static public const VERSION_004:String = "004";
		static public const VERSION_005:String = "005";
		static public const VERSION:String = VERSION_005;
		
		static public const MANIFEST_VERSION:int = 100;
		

		public static var g_landscapeTaskController:TaskController = new TaskController();
		public static var g_flowTaskController:TaskController =  new TaskController();
		public static var g_lightTaskController:TaskController =  new TaskController();

		
		public static var g_debug:Boolean  = false;
				
		public static const INVALID:uint						= 0;	//  0
		private static var  enum_val:uint						= 100;
		public static const AIR:uint							= enum_val++;	//  100
		public static const GRASS:uint							= enum_val++;	//  101
		public static const DIRT:uint							= enum_val++;	//  102
		public static const SAND:uint							= enum_val++;	//  103
		public static const STONE:uint							= enum_val++;	//  104 
		public static const GRAVEL:uint							= enum_val++;	//  105
		public static const PLANK:uint							= enum_val++;	//  106
		public static const WATER:uint							= enum_val++;	//  107
		public static const MIST:uint							= enum_val++;	//  108 
		public static const LEAF:uint							= enum_val++;	//  109 
		public static const BARK:uint							= enum_val++;	//  110 
		public static const LAVA:uint							= enum_val++;	//  111
		public static const RED:uint							= enum_val++;	// 112
		public static const BLUE:uint							= enum_val++;	// 113
		public static const GREEN:uint							= enum_val++;	// 114
		public static const CLOUD:uint							= enum_val++;	// 115
		public static const BALLOON:uint						= enum_val++;	// 116
		public static const ROPE:uint							= enum_val++;	// 117
		public static const IRON:uint							= enum_val++;	// 118
		public static const UNUSED_1:uint						= enum_val++;	// 119
		public static const STONE_WALL:uint						= enum_val++;	// 120
		public static const COPPER:uint							= enum_val++;	// 121
		public static const BRONZE:uint							= enum_val++;	// 122
		public static const STEEL:uint							= enum_val++;	// 123
		public static const GLASS:uint							= enum_val++;	// 124
		public static const EDITCURSOR_SQUARE:uint				= 1000;
		public static const EDITCURSOR_ROUND:uint				= 1001;
		public static const EDITCURSOR_CYLINDER:uint			= 1002;
		public static const EDITCURSOR_CYLINDER_ANIMATED:uint	= 1003;
		// NO MORE!!
		
		// code throws an exception when WRITE or READ is done from this object
		public static const BAD_OXEL:OxelBad = new OxelBad();

		public static var Info:Array = new Array;
		
		static public function drawable( type:int ):Boolean
		{
			if ( Info[type].solid || Info[type].alpha )
				return true;
			return false;
		}
		
		// This ideally should be define by texture, but then it is very hard to operate on programattically
		static public function hasAlpha( type:int ):Boolean
		{
			if ( Info[type].alpha || AIR == type )
				return true;
			return false;	
		}

		// solid is a collidable object
		static public function isSolid( type:int ):Boolean
		{
			if ( Info[type].solid )
				return true;
			return false;	
		}
		
		static public function getTypeId( type:* ):int
		{
			if ( type is int )
				return type;
			else if ( type is Number )
				return (type as int);
			else if ( type is String )
			{
				var typeString:String = type.toLowerCase();
				for each ( var o:TypeInfo in Info )
				{
					if ( typeString == o.name.toLowerCase() ) 
						return o.type; 
				}
			}

   			Log.out( "Globals.getTypeId - WARNING - INVALID type found: " + type, Log.WARN );
			
			return AIR
		}
		
		static private const PLANE_INWARD_FACING:int = -1;
		static private const PLANE_OUTWARD_FACING:int = 1;
		
		public static const AXIS_X:uint = 0;
		public static const AXIS_Y:uint = 1;
		public static const AXIS_Z:uint = 2;

		public static const POSX:uint = 0;
		public static const NEGX:uint = 1;
		public static const POSY:uint = 2;
		public static const NEGY:uint = 3;
		public static const POSZ:uint = 4;
		public static const NEGZ:uint = 5;
		public static const ALL_DIRS:uint = 6;
		
		public static var Plane:Array = [  { id: POSX, name: "POSX" }
										 , { id: NEGX, name: "NEGX" }
										 , { id: POSY, name: "POSY" }
										 , { id: NEGY, name: "NEGY" }
										 , { id: POSZ, name: "POSZ" }
										 , { id: NEGZ, name: "NEGZ" }
										 ];
		
		private static const  g_horizontalDirections:Array = [ Globals.POSX, Globals.NEGX, Globals.POSZ, Globals.NEGZ ];
		public static function get horizontalDirections():Array { return g_horizontalDirections; }

		private static const  g_allButDownDirections:Array = [ Globals.POSY, Globals.POSX, Globals.NEGX, Globals.POSZ, Globals.NEGZ ];
		public static function get allButDownDirections():Array { return g_allButDownDirections; }
		
		private static const g_adjacentFacesPOSX:Array = [POSY, NEGY, POSZ, NEGZ];
		private static const g_adjacentFacesNEGX:Array = [POSY, NEGY, POSZ, NEGZ];
		private static const g_adjacentFacesPOSY:Array = [POSX, NEGX, POSZ, NEGZ];
		private static const g_adjacentFacesNEGY:Array = [POSX, NEGX, POSZ, NEGZ];
		private static const g_adjacentFacesPOSZ:Array = [POSX, NEGX, POSY, NEGY];
		private static const g_adjacentFacesNEGZ:Array = [POSX, NEGX, POSY, NEGY];
		public static function adjacentFaces( $face:int ):Array
		{
			if ( POSX == $face )
				return g_adjacentFacesPOSX;
			else if ( NEGX == $face )
				return g_adjacentFacesNEGX;
			else if ( POSY == $face )
				return g_adjacentFacesPOSY;
			else if ( NEGY == $face )
				return g_adjacentFacesNEGY;
			else if ( POSZ == $face )
				return g_adjacentFacesPOSZ;
			else ( NEGZ == $face )
				return g_adjacentFacesNEGZ;
				
			return g_adjacentFacesNEGZ;
		}

		//public static var g_seed:int = 6429;
		//public static var g_seed:int = 1972; // has two water flow voxels
		private static var g_seed:int = 0; // has two water flow voxels
		public static function seed():int { return g_seed; }
		public static function seedSet( val:int ):void { g_seed = val; }
		
		private static var g_GUIControl:Boolean = false;
		public static function get GUIControl():Boolean{ return g_GUIControl; }
		public static function set GUIControl( val:Boolean ):void { g_GUIControl = val; }
		
		private static var g_active:Boolean = false; // app is active
		public static function get active():Boolean{ return g_active; }
		public static function set active( val:Boolean ):void  { g_active = val; }
		
		// This eats the first click on the screen when it is activated
		private static var g_clicked:Boolean = false; // app has been clicked on after an activate has happened
		public static function get clicked():Boolean { return g_clicked; } 
		public static function set clicked( val:Boolean ):void  { g_clicked = val; }

		private static var g_mouseView:Boolean  = false;
		public static function get mouseView():Boolean{ return g_mouseView; }
		public static function set mouseView( val:Boolean ):void { g_mouseView = val; }
		
		private static var g_appPath:String;
		public static function get appPath():String{ return g_appPath; }
		public static function set appPath( val:String ):void 
		{ 
			g_appPath = val; 
			g_modelPath = g_appPath + "assets/models/";
			g_soundPath = g_appPath + "assets/sounds/";
			g_regionPath = g_appPath + "assets/regions/";
		}
		
		private static var g_modelPath:String;
		public static function get modelPath():String{ return g_modelPath; }
		private static var g_soundPath:String;
		public static function get soundPath():String { return g_soundPath; }
		private static var g_regionPath:String;
		public static function get regionPath():String { return g_regionPath; }
		
		private static var g_player:Player = null;
		public static function get player():Player { return g_player; }
		public static function set player( val:Player ):void { g_player = val; }
		
		private static var g_controlledModel:VoxelModel = null;
		public static function get controlledModel():VoxelModel { return g_controlledModel; }
		public static function set controlledModel( val:VoxelModel ):void { g_controlledModel = val; }
		
		private static var g_selectedModel:VoxelModel = null;
		public static function get selectedModel():VoxelModel { return g_selectedModel; }
		public static function set selectedModel( val:VoxelModel ):void { g_selectedModel = val; }
		
		public static function isGuid(val:String):Boolean { return 30 < val.length; }
		public static function getUID():String { return GUID.create() }
		
		private static var g_online:Boolean = false;
		public static function get online():Boolean { return g_online }
		public static function set online(val:Boolean):void { g_online = val; }
		
		private static var g_muted:Boolean = false;
		public static function get muted():Boolean { return g_muted }
		public static function set muted(val:Boolean):void { g_muted = val; }
		
		private static var g_sandbox:Boolean = true;
		public static function get sandbox():Boolean { return g_sandbox }
		public static function set sandbox(val:Boolean):void { g_sandbox = val; }
		
		public static const MODE_LOCAL:String = "Local";
		public static const MODE_PUBLIC:String = "Public";
		public static const MODE_PRIVATE:String = "Private";
		
		private static var g_mode:String = MODE_LOCAL;
		public static function get mode():String { return g_mode }
		public static function set mode(val:String):void { g_mode = val; }
		
		private static var g_autoFlow:Boolean = true;
		public static function get autoFlow():Boolean { return g_autoFlow }
		public static function set autoFlow(val:Boolean):void { g_autoFlow = val; }
	}
}