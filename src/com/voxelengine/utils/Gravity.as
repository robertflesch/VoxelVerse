/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.utils
{
	import flash.geom.Vector3D;

 
    public class Gravity
    {
        private var _gravityScale:Vector3D;
        private var _dir:int;
        //private World _world;

		private static var enum_val:int = -1
		public static const INVALID:int = enum_val++; 	// -1
		public static const POSX:int = enum_val++; 	// 0
		public static const POSY:int = enum_val++; 	// 1
		public static const POSZ:int = enum_val++;	// 2
		public static const NEGX:int = enum_val++; 	// 0
		public static const NEGY:int = enum_val++; 	// 1
		public static const NEGZ:int = enum_val++;	// 2
		
		private static var enum_val2:int = 0
		public static const COMPX:int = enum_val2++; 	// 0
		public static const COMPY:int = enum_val2++; 	// 1
		public static const COMPZ:int = enum_val2++;	// 2

        public function init(  scale:Vector3D, dir:int ):void      
        {
            _gravityScale = scale;
            _dir = dir;
        }

        public function get gravityScale():Vector3D { return _gravityScale; } 
        public function set gravityScale( gravityScale:Vector3D ):void { _gravityScale = gravityScale; } 

        public function get dir():int { return _dir; }
        public function set dir( dir:int ):void 
        { 
			_dir = dir;
			_gravityScale.setTo( 0, 0, 0 );
			switch (_dir)
			{
				case POSX:
					_gravityScale.x = 1.0;
					break;
				case NEGX:
					_gravityScale.x = -1.0;
					break;
				case POSY:
					_gravityScale.y = 1.0;
					break;
				case NEGY:
					_gravityScale.y = -1.0;
					break;
				case POSZ:
					_gravityScale.z = 1.0;
					break;
				case NEGZ:
					_gravityScale.z = -1.0;
					break;
			}
		}

        public function getLargestComp( x:Number, y:Number, z:Number ):int
        {
            if (x > y && x > z)
                return COMPX;
            else if (y > x && y > z)
                return COMPY;
            else if (z > x && z > y)
                return COMPZ;

            return INVALID;
        }

        //private function adjustPositionToAroundCorner( player:Player ):void 
        //{
            //blockOn:Number = (int)(GravityScale * player.GetFootPosition()).Length();
        //}
        

        //public void AdjustFacingAndGravity(Player player, Vector3 changeVector)
        //{
            //Console.WriteLine("AdjustFacingAndGravity = {0} Player Position {1}", changeVector, player.Position );
            //bool xPlus = true;
            //bool yPlus = true;
            //bool zPlus = true;
            //float xChange = Math.abs(changeVector.x);
            //if (xChange != changeVector.x)
                //xPlus = false;
            //float yChange = Math.abs(changeVector.y);
            //if (yChange != changeVector.y)
                //yPlus = false;
            //float zChange = Math.abs(changeVector.z);
            //if (zChange != changeVector.z)
                //zPlus = false;
//
            //ELargestComp result = GetLargestComp(xChange, yChange, zChange);
            //const float adj = 1.45f;
            //
            // Get the last block under the player that was valid
            //Vector3i location = _world.GetFirstSolidBlockBeneathYou( GravityScale, player.LastPosition );
            //_gravityScale = Vector3.zero;
            //switch (result)
            //{
                //case ELargestComp.CompX:
//
                    //if (xPlus) // if xPlus is positive then we are moving in the neg x direction
                    //{
                        //switch (_dir)
                        //{
                            //case EGravityDirection.PosY:
                                //player.Position = new Vector3(location.x - 1.45f, location.y - 0.5f, player.Position.z); // Checked -  PosY to Neg X
                                //break;
                            //case EGravityDirection.NegY:
                                //player.Position = new Vector3(location.x + 2.45f, location.y + 0.5f, player.Position.z);  // Checked -  Neg Y to Neg X
                                //break;
                            //case EGravityDirection.PosZ:
                                //player.Position = new Vector3(location.x - 2.45f, player.Position.y, location.z + 0.5f);
                                //break;
                            //case EGravityDirection.NegZ:
                                //player.Position = new Vector3(location.x + 2.45f, player.Position.y, location.z + 0.5f);
                                //break;
                        //}
                        //Dir = EGravityDirection.NegX;
                    //}
                    //else
                    //{
                        //switch (_dir)
                        //{
                            //case EGravityDirection.PosY:
                                //player.Position = new Vector3(location.x + 2.45f, location.y + 0.5f, player.Position.z); // Checked -  PosY to Pos X
                                //break;
                            //case EGravityDirection.NegY:
                                //player.Position = new Vector3(location.x + 2.45f, location.y + 0.5f, player.Position.z); // Checked -  Neg Y to Pos X
                                //break;
                            //case EGravityDirection.PosZ:
                                //player.Position = new Vector3(location.x - 2.45f, player.Position.y, location.z + 0.5f);
                                //break;
                            //case EGravityDirection.NegZ:
                                //player.Position = new Vector3(location.x + 2.45f, player.Position.y, location.z + 0.5f);
                                //break;
                        //}
                        //Dir = EGravityDirection.PosX;
                    //}
                    //break;
                //case ELargestComp.CompY:
//
                    //if (yPlus) // if yPlus is positive then we are moving in the neg Y direction
                    //{
                        //switch (_dir)
                        //{
                            //case EGravityDirection.PosX:
                                //player.Position = new Vector3(location.x + 0.5f, location.y + 2.45f, player.Position.z);  // Checked -  Pos X to Neg Y
                                //break;
                            //case EGravityDirection.NegX:
                                //player.Position = new Vector3(location.x + 0.5f, location.y + 2.45f, player.Position.z);  // Checked -  Pos X to Neg Y
                                //break;
                            //case EGravityDirection.PosZ:
                                //player.Position = new Vector3(player.Position.x, location.y + 2.45f, location.z + 0.5f);
                                //break;
                            //case EGravityDirection.NegZ:
                                //player.Position = new Vector3(player.Position.x, location.y + 2.45f, location.z + 0.5f);
                                //break;
                        //}
                        //Dir = EGravityDirection.NegY;
                    //}
                    //else
                    //{
                        //switch (_dir)
                        //{
                            //case EGravityDirection.PosX:
                                //player.Position = new Vector3(location.x + 0.5f, location.y + 2.45f, player.Position.z);  // Checked -  Pos X to Pos Y
                                //break;
                            //case EGravityDirection.NegX:
                                //player.Position = new Vector3(location.x + 0.5f, location.y + 2.45f, player.Position.z);  // Checked -  Neg X to Pos Y
                                //break;
                            //case EGravityDirection.PosZ:
                                //player.Position = new Vector3(player.Position.x, location.y + 2.45f, location.z + 0.5f);  // Checked - Pos Y to Pos Z
                                //break;
                            //case EGravityDirection.NegZ:
                                //player.Position = new Vector3(player.Position.x, location.y + 2.45f, location.z + 0.5f);
                                //break;
                        //}
                        //Dir = EGravityDirection.PosY;
                    //}
                    //break;
                //case ELargestComp.CompZ:
                    //if (zPlus) // if zPlus is positive then we are moving in the neg Z direction
                    //{
                        //switch (_dir)
                        //{
                            //case EGravityDirection.PosX:
                                //player.Position = new Vector3(location.x + 0.5f, player.Position.y, location.z + 2.45f);
                                //break;
                            //case EGravityDirection.NegX:
                                //player.Position = new Vector3(location.x + 0.5f, player.Position.y, location.z + 2.45f);
                                //break;
                            //case EGravityDirection.PosY:
                                //player.Position = new Vector3(player.Position.x, location.y - 0.5f, location.z - 1.45f);  // Checked -  Pos Y to Neg Z 
                                //break;
                            //case EGravityDirection.NegY:
                                //player.Position = new Vector3(player.Position.x, location.y + 0.5f, location.z + 2.45f);  // Neg Y to Neg Z
                                //break;
                        //}
                        //Dir = EGravityDirection.NegZ;
                    //}
                    //else
                    //{
                        //switch (_dir)
                        //{
                            //case EGravityDirection.PosX:
                                //player.Position = new Vector3(location.x + 0.5f, player.Position.y, location.z + 2.45f); // Pos X to Pos Z
                                //break; 
                            //case EGravityDirection.NegX:
                                //player.Position = new Vector3(location.x + 0.5f, player.Position.y, location.z + 2.45f); // Neg X to Pos Z
                                //break;
                            //case EGravityDirection.PosY:
                                //player.Position = new Vector3(player.Position.x, location.y + 0.5f, location.z + 2.45f); // Checked -  Pos Y to Pos Z
                                //break;
                            //case EGravityDirection.NegY:
                                //player.Position = new Vector3(player.Position.x, location.y + 0.5f, location.z + 2.45f); // Neg Y to Pos Z (way screwed up)
                                //break;
                        //}
                        //Dir = EGravityDirection.PosZ;
                    //}
                    //break;
            //}
            //Console.WriteLine("AdjustFacingAndGravity End - Player Position {0}", player.Position);
        //}
//
        public function nonGravityComponents():Vector3D
        {
            var x:int = 1 ^ Math.abs(gravityScale.x);
            var y:int = 1 ^ Math.abs(gravityScale.y);
            var z:int = 1 ^ Math.abs(gravityScale.z);

            return new Vector3D(x, y, z);
        }

        //private Vector3 GetGravityDirection(Vector3 point)
        //{
        //    // Check all six tetrahedron centered on the cube.
        //    // Which ever tetrahedron the player is in sets the direction of gravity
        //    Vector3 gd = new Vector3(0, 0, 0);
        //    if (PointInPyramid(point, _v0, _v1, _v2, _v3, _vc)) // Negative Y
        //    {
        //        gd.y = -1.0;
        //        _dir = EGravityDirection.NegY;
        //        return gd;
        //    }
        //    else if (PointInPyramid(point, _v4, _v5, _v6, _v7, _vc)) // Pos Y
        //    {
        //        gd.y = 1.0;
        //        _dir = EGravityDirection.PosY;
        //        return gd;
        //        //if (PointInPyramid(point, _vi4, _vi5, _vi6, _vi7, _vc)) // Inner Pos Y
        //        //{
        //        //    gd.y = 1.0;
        //        //    _dir = EGravityDirection.PosY;
        //        //    System.Diagnostics.Debug.WriteLine(string.Format("Pos Y Inner P {0}", point));
        //        //}
        //        //else if (PointInTetrahedron(point, _v4, _v5, _pyfc, _vc)) 
        //        //{
        //        //    gd.y = 1.0;
        //        //    _dir = EGravityDirection.PosY;
        //        //    System.Diagnostics.Debug.WriteLine(string.Format("Pos Y  - Neg Z {0}", point));
        //        //}
        //        //else if (PointInTetrahedron(point, _v5, _v6, _pyfc, _vc))
        //        //{
        //        //    gd.y = 0f;
        //        //    gd.x = 1.0;
        //        //    _dir = EGravityDirection.PosX;
        //        //    _position.x = (float)Math.Ceiling( _position.x ) + 2.45f;
        //        //    _position.y = _position.y - 2.0f;
        //        //    System.Diagnostics.Debug.WriteLine(string.Format("TURNING CORNER", point));
        //        //}
        //        //else if (PointInTetrahedron(point, _v6, _v7, _pyfc, _vc))
        //        //{
        //        //    gd.y = 1.0;
        //        //    _dir = EGravityDirection.PosY;
        //        //    System.Diagnostics.Debug.WriteLine(string.Format("Pos Y  - Pos Z {0}", point));
        //        //}
        //        //else if (PointInTetrahedron(point, _v7, _v4, _pyfc, _vc))
        //        //{
        //        //    gd.y = 1.0;
        //        //    _dir = EGravityDirection.PosY;
        //        //    System.Diagnostics.Debug.WriteLine(string.Format("Pos Y  - Neg X {0}", point));
        //        //}
        //        //return gd;
        //    }
        //    else if (PointInPyramid(point, _v0, _v1, _v4, _v5, _vc)) // Neg Z
        //    {
        //        gd.z = -1.0;
        //        _dir = EGravityDirection.NegZ;
        //        return gd;
        //    }
        //    else if (PointInPyramid(point, _v2, _v3, _v6, _v7, _vc)) // Pos Z
        //    {
        //        gd.z = 1.0;
        //        _dir = EGravityDirection.PosZ;
        //        return gd;
        //    }
        //    else if (PointInPyramid(point, _v0, _v3, _v4, _v7, _vc)) // Neg X
        //    {
        //        gd.x = -1.0;
        //        _dir = EGravityDirection.NegX;
        //        return gd;
        //    }
        //    else if (PointInPyramid(point, _v1, _v2, _v5, _v6, _vc)) // Pos X
        //    {
        //        gd.x = 1.0;
        //        _dir = EGravityDirection.PosX;
        //        return gd;
        //    }
        //    else
        //    {
        //        System.Diagnostics.Debug.WriteLine(string.Format("Player - GetGravityDirection - Outside of gravity well {0}", point));
        //        gd = Vector3.zero;
        //        return gd;
        //    }
        //}


        //private const float _outer = 0.95f;
        //private const float _inner = 1 - _outer;
        //// This is the 8 corners of the world and the center point
        //Vector3 _v0 = new Vector3(0, 0, 0);
        //Vector3 _v1 = new Vector3(WorldSettings.MAPLENGTH, 0, 0);
        //Vector3 _v2 = new Vector3(WorldSettings.MAPLENGTH, 0, WorldSettings.MAPWIDTH);
        //Vector3 _v3 = new Vector3(0, 0, WorldSettings.MAPWIDTH);
        //Vector3 _v4 = new Vector3(0, WorldSettings.MAPHEIGHT, 0);
        //Vector3 _v5 = new Vector3(WorldSettings.MAPLENGTH, WorldSettings.MAPHEIGHT, 0);
        //Vector3 _v6 = new Vector3(WorldSettings.MAPLENGTH, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH);
        //Vector3 _v7 = new Vector3(0, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH);

        //Vector3 _vc = new Vector3(WorldSettings.MAPLENGTH / 2, WorldSettings.MAPHEIGHT / 2, WorldSettings.MAPWIDTH / 2);

        //Vector3 _vi0 = new Vector3(WorldSettings.MAPLENGTH * _inner, 0, WorldSettings.MAPWIDTH * _inner);
        //Vector3 _vi1 = new Vector3(WorldSettings.MAPLENGTH * _outer, 0, WorldSettings.MAPWIDTH * _inner);
        //Vector3 _vi2 = new Vector3(WorldSettings.MAPLENGTH * _outer, 0, WorldSettings.MAPWIDTH * _outer);
        //Vector3 _vi3 = new Vector3(WorldSettings.MAPLENGTH * _inner, 0, WorldSettings.MAPWIDTH * _outer);
        //Vector3 _vi4 = new Vector3(WorldSettings.MAPLENGTH * _inner, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH * _inner);
        //Vector3 _vi5 = new Vector3(WorldSettings.MAPLENGTH * _outer, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH * _inner);
        //Vector3 _vi6 = new Vector3(WorldSettings.MAPLENGTH * _outer, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH * _outer);
        //Vector3 _vi7 = new Vector3(WorldSettings.MAPLENGTH * _inner, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH * _outer);

        //Vector3 _nyfc = new Vector3(WorldSettings.MAPLENGTH / 2, 0, WorldSettings.MAPWIDTH / 2);
        //Vector3 _pyfc = new Vector3(WorldSettings.MAPLENGTH / 2, WorldSettings.MAPHEIGHT, WorldSettings.MAPWIDTH / 2);
        //Vector3 _nxfc = new Vector3(0, WorldSettings.MAPHEIGHT / 2, WorldSettings.MAPWIDTH / 2);
        //Vector3 _pxfc = new Vector3(WorldSettings.MAPLENGTH, WorldSettings.MAPHEIGHT / 2, WorldSettings.MAPWIDTH / 2);
        //Vector3 _nzfc = new Vector3(WorldSettings.MAPLENGTH / 2, WorldSettings.MAPHEIGHT / 2, 0);
        //Vector3 _pzfc = new Vector3(WorldSettings.MAPLENGTH / 2, WorldSettings.MAPHEIGHT / 2, WorldSettings.MAPWIDTH);

        //private Matrix MatrixFrom4Vector3(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4)
        //{
        //    return new Matrix(p1.x, p1.y, p1.z, 1, p2.x, p2.y, p2.z, 1, p3.x, p3.y, p3.z, 1, p4.x, p4.y, p4.z, 1);
        //}

        //private bool PointInTetrahedron(Vector3 point, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 pc)
        //{
        //    Matrix d0 = MatrixFrom4Vector3(p1, p2, p3, pc);
        //    Matrix d1 = MatrixFrom4Vector3(p1, p2, p3, pc);
        //    d1.M11 = point.x;
        //    d1.M12 = point.y;
        //    d1.M13 = point.z;
        //    Matrix d2 = MatrixFrom4Vector3(p1, p2, p3, pc);
        //    d2.M21 = point.x;
        //    d2.M22 = point.y;
        //    d2.M23 = point.z;
        //    Matrix d3 = MatrixFrom4Vector3(p1, p2, p3, pc);
        //    d3.M31 = point.x;
        //    d3.M32 = point.y;
        //    d3.M33 = point.z;
        //    Matrix d4 = MatrixFrom4Vector3(p1, p2, p3, pc);
        //    d4.M41 = point.x;
        //    d4.M42 = point.y;
        //    d4.M43 = point.z;

        //    float f0 = d0.Determinant();
        //    float f1 = d1.Determinant();
        //    float f2 = d2.Determinant();
        //    float f3 = d3.Determinant();
        //    float f4 = d4.Determinant();

        //    if (0 < f0 && 0 <= f1 && 0 <= f2 && 0 <= f3 && 0 <= f4)
        //    {
        //        //System.Diagnostics.Debug.WriteLine(string.Format("Point {0} Found in {1},{2},{3},{4}", point, p1, p2, p3, pc));
        //        return true;
        //    }
        //    else if (0 > f0 && 0 >= f1 && 0 >= f2 && 0 >= f3 && 0 >= f4)
        //    {
        //        //System.Diagnostics.Debug.WriteLine(string.Format("Point {0} Found in {1},{2},{3},{4}", point, p1, p2, p3, pc));
        //        return true;
        //    }
        //    return false;
        //}

        //private bool PointInPyramid(Vector3 point, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4, Vector3 pc)
        //{
        //    // Break the pyramid into 2 tetrahedons, and then test each one.
        //    if (PointInTetrahedron(point, p1, p2, p3, pc) || PointInTetrahedron(point, p1, p4, p3, pc))
        //        return true;
        //    else
        //        return false;
        //}


		
    }
}