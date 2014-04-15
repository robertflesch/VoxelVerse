package com.voxelengine.worldmodel.models
{
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PositionTest 
	{
		static public const HEAD:int = 0;
		static public const CHEST:int = 1;
		static public const FOOT:int = 2;
		static public const OTHER:int = 3;
		
		public var head:Boolean = false;
		public var chest:Boolean = false;
		public var foot:Boolean = false;
		public var footHeight:Number = 0;
		public var type:int = OTHER;
		private var _position:Vector3D = new Vector3D();

		public function PositionTest()
		{
		}
		
		public function set position( $val:Vector3D ):void 
		{
			_position.setTo( $val.x, $val.y, $val.z );
		}
		
		public function get position():Vector3D 
		{
			return _position;
		}
		
		public function isNotValid():Boolean
		{
			return (!head || !chest || !foot);
		}

		public function isValid():Boolean
		{
			return ( head && chest && foot );
		}
		
		public function setValid():void
		{
			head = true;
			chest = true; 
			foot = true;
		}
		
		public function toString():String {
			var result:String = "PositionTest type: " + type + " head: " + ( head ? "true" : "FALSE") + " chest: " + ( chest ? "true" : "FALSE") + " foot: " + ( foot ? "true" : "FALSE");
			return result;
		}
		
	}
}