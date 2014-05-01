/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer {

//import com.voxelengine.utils.Color;
import com.voxelengine.utils.Color;
import flash.geom.Vector3D;
import flash.utils.getTimer;

import com.voxelengine.Globals
import com.voxelengine.Log;
import com.voxelengine.worldmodel.oxel.Brightness;
import com.voxelengine.worldmodel.oxel.FlowInfo;
import com.voxelengine.worldmodel.oxel.FlowScaling;
import com.voxelengine.worldmodel.TileType;
import com.voxelengine.worldmodel.TypeInfo;
	
public class Quad {
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Static Variables
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static const VERTEX_PER_QUAD:int = 4;
	private static const QUAD_UV_COUNT:int = 5;
	//public static const DATA_PER_VERTEX:int = 11; // 8;
	static public const DATA_PER_VERTEX:int = 12; // 11 added brightness
	static public const VERTICES:int = VERTEX_PER_QUAD * DATA_PER_VERTEX;
	static public const INDICES:int = 6;
	static private var _s_TextureScale:int = 256;
	static private var _s_tint:Vector3D = new Vector3D();
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Static Functions
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public static function texture_scale_set( val:int ):void { _s_TextureScale = val; }
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Member Variables
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// These are accessed by the VertexIndexBuilder when building the Vertex and Index buffers
	public var _vertices:Vector.<Number> 	= new Vector.<Number>(VERTICES,true);
	public var _indices:Vector.<uint> 		= new Vector.<uint>(INDICES,true);
	private var _U:Vector.<Number> = new Vector.<Number>(QUAD_UV_COUNT,true);
	private var _V:Vector.<Number> = new Vector.<Number>(QUAD_UV_COUNT,true);
	
	// Empty constuctor for QuadPool
	public function Quad():void { };
	
	public function rebuild( $type:int,						 // material type
						     $x:Number, $y:Number, $z:Number,// world location
						     $face:int,						 // which 
						     $plane_facing:int,				 // facing
						     $scale:Number,                  // the world size of the quad 
						     $brightness:Brightness ):void			
	{
		add( $type, $x, $y, $z, $face, $plane_facing, $scale, Globals.Info[$type], $brightness );
	}
	
	public function build( $type:int,						// material type
						   $x:Number, $y:Number, $z:Number,	// world location
						   $face:int,						// which 
						   $plane_facing:int,				// facing
						   $scale:Number,                   // the world size of the quad 
						   $brightness:Brightness ):void			
	{
		var typeInfo:TypeInfo = Globals.Info[$type];
		if ( !calculateUV( typeInfo, $face, $scale, null ) )
			return;
			
		add( $type, $x, $y, $z, $face, $plane_facing, $scale, typeInfo, $brightness );
	}
	
	public function buildScaled( $type:int,						// material type
										$x:Number, $y:Number, $z:Number,	// world location
										$face:int,						// which 
										$plane_facing:int,				// facing
										$scale:Number,
									    $brightness:Brightness,
										$flowInfo:FlowInfo ):void			// the scaled for flow distance
	{
		var typeInfo:TypeInfo = Globals.Info[$type];
		if ( !calculateUV( typeInfo, $face, $scale, $flowInfo ) )
			return;
		
		addScaled( $type, $x, $y, $z, $face, $plane_facing, $scale, typeInfo, $brightness, $flowInfo );
	}
	
	public function print():void 
	{
		var output:String;
		var index:int = 0;
		for each ( var v:Number in _vertices )
		{
			Log.out( "vert[" + index + "]: " + v );
			index++;
		}
		index = 0;
		for each ( var i:Number in _indices )
		{
			Log.out( "indi[" + index + "]: " + i );
			index++;
		}
	}
	
	public function copyUV( rhs:Quad ):void {
		
		for ( var vindex:int = 0; vindex < QUAD_UV_COUNT; vindex++ )
		{
			_V[vindex] = rhs._V[vindex];
		}
			
		for ( var uindex:int = 0; uindex < QUAD_UV_COUNT; uindex++ )
		{
			_U[uindex] = rhs._U[uindex];
		}
	}
	
	//public function copy( rhs:Quad ):void {
		//
		//for ( var vindex:int = 0; vindex < VERTICES; vindex++ )
		//{
			//_vertices[vindex] = rhs._vertices[vindex];
		//}
			//
		//for ( var iindex:int = 0; iindex < VERTICES; iindex++ )
		//{
			//_indices[iindex] = rhs._indices[iindex];
		//}
	//}
	private function randomTextureOffset( maxpix:int, scale:Number ):Number
	{
		// if the requested texture is larger then the size that can return a random texture
		// then return 0. So for a 256x256 texture, the largest random texture is 128x128
		var result:int = 0;
		if ( 0 < (maxpix - scale) )
			result = int(Math.random() * (maxpix - scale) );
			
		return result;
	}
	
	private function calculateUV( typeInfo:TypeInfo, face:int, scale:Number, $flowInfo:FlowInfo ):Boolean
	{
		const maxpix:int = typeInfo.maxpix;
		const minpix:int = typeInfo.minpix;
		var tilingType:int = TileType.TILE_FIXED;
		
		if ( 0 == maxpix || 0 == minpix )
		{
			throw new Error("Quad.calculateUV - Maxpix or Minpix is 0, Likely tried to create an AIR, PARENT, or INVALID oxel");
		}
		
		if ( null == typeInfo )
		{
			throw new Error("Quad.calculateUV - typeInfo NULL", Log.ERROR );
		}
		
		// First get the right section of the texture, and the tilingtype
		switch ( face ) 
		{
			case Globals.POSY:
			{
				tilingType = typeInfo.top;
				_U[0] = typeInfo.ut;
				_V[0] = typeInfo.vt;
				break;
			}
			case Globals.NEGY:
			{
				tilingType = typeInfo.bottom;
				_U[0] = typeInfo.ub;
				_V[0] = typeInfo.vb;
				break;
			}
			default:
			{
				tilingType = typeInfo.side;
				_U[0] = typeInfo.us;
				_V[0] = typeInfo.vs;
				break;
			}
		}

		// This gets a random placement of the starting corner of the texture
		// maxpix is the total size of the texture to sample from
		// scale is how many pixels the texture uses
		// texture size is the size of the overall texture
//		if ( Globals.GRASS == type && face != Globals.NEGY && face != Globals.POSY && 1 == minpix)
		//static public const TILE_FIXED:int				= 0;
		//static public const TILE_RANDOM:int 				= 1;
		//static public const TILE_RANDOM_CENTERED:int 		= 2;
		//static public const TILE_RANDOM_8_HORZ:int 		= 3;
		//static public const TILE_RANDOM_8_VERT:int 		= 4;
		//static public const TILE_RANDOM_16_BOTH:int		= 5;

		if ( TileType.TILE_NONE == tilingType )
		{
			return false;
		}
		
		if ( TileType.TILE_RANDOM_CENTERED == tilingType )
		{
			_U[0] += randomTextureOffset( maxpix, scale )/ _s_TextureScale;
			var offset:Number = ((maxpix - scale) / 2);
			_V[0] += offset / _s_TextureScale;
		}
		//if ( Globals.WOOD == type && face != Globals.NEGY && face != Globals.POSY && 1 == minpix)
		else if ( TileType.TILE_RANDOM_8_HORZ == tilingType )
		{
			_U[0] += randomTextureOffset( maxpix, scale )/ _s_TextureScale;
			var woffset:Number = randomTextureOffset( maxpix, scale );
			if (  8 <= scale )
				woffset = int( woffset/8 ) * 8
			_V[0] += woffset / _s_TextureScale;
		}
		else if ( TileType.TILE_RANDOM_8_VERT == tilingType )
		{
			var voffset:int = randomTextureOffset( maxpix, scale );
			if (  8 <= scale )
				voffset = int( voffset/8 ) * 8
			_U[0] += voffset / _s_TextureScale;
			_V[0] += randomTextureOffset( maxpix, scale )/ _s_TextureScale;
		}
		//else if ( 16 < maxpix && maxpix != minpix )
		else if ( TileType.TILE_RANDOM == tilingType || TileType.TILE_RANDOM_NO_ROTATE == tilingType ) 
		{
			_U[0] += randomTextureOffset( maxpix, scale ) / _s_TextureScale;
			_V[0] += randomTextureOffset( maxpix, scale )/ _s_TextureScale;
		}
		else if ( TileType.TILE_RANDOM_16_BOTH == tilingType )
		{
			var soffset:Number = randomTextureOffset( maxpix, scale );
			if (  16 <= scale )
				soffset = int( soffset/16 ) * 16
			_U[0] += soffset / _s_TextureScale
			soffset = randomTextureOffset( maxpix, scale );
			if (  16 <= scale )
				soffset = int( soffset/16 ) * 16
			_V[0] += soffset / _s_TextureScale
		}
		
		// This is the length of the texture in pixels/length
		var tSize:Number = scale / _s_TextureScale;
		tSize = Math.min( tSize, maxpix / _s_TextureScale );
		tSize = Math.max( tSize, minpix / _s_TextureScale );
		_U[1] = _U[0] + tSize					;		_V[1] = _V[0];			
		_U[2] = _U[0] + tSize					;		_V[2] = _V[0] + tSize;
		_U[3] = _U[0]							;		_V[3] = _V[0] + tSize;
		_U[4] = _U[0]							;		_V[4] = _V[0];
		
		// idea here was to rotate all of the water textures so that they flowed down
		// but I get tearing, so I am doing something wrong.
		//if ( TileType.TILE_FIXED == tilingType )
		//{
			//if ( Globals.WATER == typeInfo.type && face != Globals.POSY && face != Globals.NEGY )
			//{
				//for (var ii:int = 0; i < 4; i++)
				//{
					//_U[ii] = _U[ii + 1];
					//_V[ii] = _V[ii + 1];
				//}
			//}
		//}

		if ( TileType.TILE_RANDOM == tilingType && 16 < maxpix )
		{
			// 50% chance to rotate the texture
			if (Math.random() < 0.50)
			{
				rotateTexture( ROTATE_090 );
			}
		}
		// This makes the sides of water and lava oxels flow downward
		else if ( TileType.TILE_FIXED == tilingType && 16 <= maxpix && typeInfo.animated )
		{
			//if ( Globals.POSX == face ||  face == Globals.NEGX || face == Globals.POSZ || face == Globals.NEGZ )
			//{
				//rotateTexture90();
			//}
			// For top and bottom faces, adjust the texture rotation to the direction of the flow
			//else {
			if ( $flowInfo )
			{
				if ( Globals.POSY == face ||  face == Globals.NEGY )
				{
					// PosX is the default
					if ( Globals.POSZ == $flowInfo.direction ) {
						rotateTexture( ROTATE_000 );
					} else if ( Globals.POSX == $flowInfo.direction ) {
						rotateTexture( ROTATE_090 );
					} else if ( Globals.NEGZ == $flowInfo.direction ) {
						rotateTexture( ROTATE_180 );
					} else if ( Globals.NEGX == $flowInfo.direction ) {
						rotateTexture( ROTATE_270 );
					}
				}
			}
		}
		
		return true;
	}
	
	private static const ROTATE_000:int = 0;
	private static const ROTATE_090:int = 1;
	private static const ROTATE_180:int = 2;
	private static const ROTATE_270:int = 3;
	
	private function rotateTexture( rotation:int ):void {  
		var i:int = 0;
		var j:int = 0;
		if ( ROTATE_000 == rotation )
			return;
		else if ( ROTATE_090 == rotation )
		{
			for (i = 0; i < 4; i++) {
				_U[i] = _U[i + 1];
				_V[i] = _V[i + 1];
			}
		}
		else if ( ROTATE_180 == rotation )
		{
			_U[4] = _U[0];		_V[4] = _V[0];
			_U[0] = _U[2];		_V[0] = _V[2];
			_U[2] = _U[4];		_V[2] = _V[4];
			
			_U[4] = _U[1];		_V[4] = _V[1];
			_U[1] = _U[3];		_V[1] = _V[3];
			_U[3] = _U[4];		_V[3] = _V[4];			
		}
		else if ( ROTATE_270 == rotation )
		{
			for (i = 0; i < 4; i++) {
				_U[i] = _U[i + 1];
				_V[i] = _V[i + 1];
			}
			_U[4] = _U[0];		_V[4] = _V[0];
			_U[0] = _U[2];		_V[0] = _V[2];
			_U[2] = _U[4];		_V[2] = _V[4];
			
			_U[4] = _U[1];		_V[4] = _V[1];
			_U[1] = _U[3];		_V[1] = _V[3];
			_U[3] = _U[4];		_V[3] = _V[4];			
		}
	}

	private function buildVertices( vertexIndex:int, x:Number, y:Number, z:Number, u:Number, v:Number, normalx:int, normaly:int, normalz:int, tint:Vector3D, $brightness:Number ):int
	{
		//trace( "Quad.buildVerticies - buildVertices x: " + x + " y: " + y + " z: " + z  + " u: " + u  + " v: " + v  + " nx: " + normalx + " ny: " + normaly + " nz: " + normalz );
		_vertices[vertexIndex++] = x;
		_vertices[vertexIndex++] = y;
		_vertices[vertexIndex++] = z;
		_vertices[vertexIndex++] = u;
		_vertices[vertexIndex++] = v;
		_vertices[vertexIndex++] = normalx; // Needed for lighting and face culling
		_vertices[vertexIndex++] = normaly; // Needed for lighting
		_vertices[vertexIndex++] = normalz; // Needed for lighting
		_vertices[vertexIndex++] = tint.x; 
		_vertices[vertexIndex++] = tint.y; 
		_vertices[vertexIndex++] = tint.z; 
		_vertices[vertexIndex++] = $brightness;

		return vertexIndex;
	}
	
	private function buildIndices( facing:int ):void {
		var indiceIndex:int = 0;
		if (facing > 0) {
			// CCW
			_indices[indiceIndex++] = 0;
			_indices[indiceIndex++] = 1;
			_indices[indiceIndex++] = 2;
			
			_indices[indiceIndex++] = 2;
			_indices[indiceIndex++] = 3;
			_indices[indiceIndex++] = 0;
		} else {
			// CW
			_indices[indiceIndex++] = 0;
			_indices[indiceIndex++] = 2;
			_indices[indiceIndex++] = 1;
			
			_indices[indiceIndex++] = 2;
			_indices[indiceIndex++] = 0;
			_indices[indiceIndex++] = 3;
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Member Functions 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private function addScaled( type:int, x:Number, y:Number, z:Number, face:int, plane_facing:int, scale:Number, $ti:TypeInfo, $brightness:Brightness, $flowInfo:FlowInfo ):void
	{
		//trace( "Quad.addScaledVertices temp: " + brightness + "  TYPE = : " + Globals.Info[type].name );

		var vertexIndex:int = 0;
		var fs:FlowScaling = $flowInfo.flowScaling;
		var height:Number = 1;
		
		//var tint:Vector3D = Color.toVector3D( tint, $ti.color );
		_s_tint = Color.toVector3D( _s_tint, Color.combineRGB( $ti.color, $brightness.color ) );
		var sideBrightness:Number = 0.5;
		if ( $ti.light || 1000 <= $ti.type )
		{
			sideBrightness = 1;
		}
		//if ( Globals.WATER == type )
			//brightness /= 2;
		
		var normal:int = 1;
		switch ( face ) 
		{
			case Globals.POSX:
				//trace( "Quad.addScaledVertices - addQuad POSX" );
				normal = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x + scale	, y         			, z			, _U[1]		, _V[3]		, normal, 0, 0, _s_tint, $brightness.b100 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + (scale * fs.PxNz)	, z			, _U[2]		, _V[0]		, normal, 0, 0, _s_tint, $brightness.b110 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + (scale * fs.PxPz)	, z + scale	, _U[3]		, _V[1]		, normal, 0, 0, _s_tint, $brightness.b111 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y         			, z + scale	, _U[0]		, _V[2]		, normal, 0, 0, _s_tint, $brightness.b101 * sideBrightness );
				break;
				
			case Globals.NEGX:
				//trace( "Quad.addScaledVertices - addQuad NEGX" );
				normal = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y         			, z			, _U[3]		, _V[3]		, normal, 0, 0, _s_tint, $brightness.b000 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + (scale * fs.NxNz)	, z			, _U[0]		, _V[0]		, normal, 0, 0, _s_tint, $brightness.b010 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + (scale * fs.NxPz)	, z + scale	, _U[1]		, _V[1]		, normal, 0, 0, _s_tint, $brightness.b011 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y         			, z + scale	, _U[2]		, _V[2]		, normal, 0, 0, _s_tint, $brightness.b001 * sideBrightness );
				break;
				
			case Globals.NEGY:
				//trace( "Quad.addStraightVertices - addQuad POSY" );
				normal = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y             , z			, _U[0]		, _V[0]		, 0, normal, 0, _s_tint, $brightness.b000 );
				vertexIndex = buildVertices( vertexIndex, x			, y             , z + scale	, _U[3]		, _V[3]		, 0, normal, 0, _s_tint, $brightness.b001 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y				, z + scale	, _U[2]		, _V[2]		, 0, normal, 0, _s_tint, $brightness.b101 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y				, z			, _U[1]		, _V[1]		, 0, normal, 0, _s_tint, $brightness.b100 );
				break;
				
		case Globals.POSY:
				//trace( "Quad.addStraightVertices - addQuad NEGY" );
				normal = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y + (scale * fs.NxNz)	, z			, _U[0]		, _V[0]		, 0, normal, 0, _s_tint, $brightness.b010 );
				vertexIndex = buildVertices( vertexIndex, x			, y + (scale * fs.NxPz)	, z + scale	, _U[3]		, _V[3]		, 0, normal, 0, _s_tint, $brightness.b011 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + (scale * fs.PxPz)	, z + scale	, _U[2]		, _V[2]		, 0, normal, 0, _s_tint, $brightness.b111 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + (scale * fs.PxNz)	, z			, _U[1]		, _V[1]		, 0, normal, 0, _s_tint, $brightness.b110 );
				break;

			case Globals.POSZ:
				//trace( "Quad.addScaledVertices - addQuad POSZ" );
				normal = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y						, z + scale	, _U[0]		, _V[2]		, 0, 0, normal, _s_tint, $brightness.b001 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y						, z + scale	, _U[1]		, _V[3]		, 0, 0, normal, _s_tint, $brightness.b101 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + (scale * fs.PxPz)	, z + scale	, _U[2]		, _V[0]		, 0, 0, normal, _s_tint, $brightness.b111 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + (scale * fs.NxPz)	, z + scale	, _U[3]		, _V[1]		, 0, 0, normal, _s_tint, $brightness.b011 * sideBrightness );
				break;
				
			case Globals.NEGZ:
				//trace( "Quad.addScaledVertices - addQuad NEGZ" );
				normal = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y						, z			, _U[2]		, _V[2]		, 0, 0, normal, _s_tint, $brightness.b000 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y						, z			, _U[3]		, _V[3]		, 0, 0, normal, _s_tint, $brightness.b100 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + (scale * fs.PxNz)	, z			, _U[0]		, _V[0]		, 0, 0, normal, _s_tint, $brightness.b110 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + (scale * fs.NxNz)	, z			, _U[1]		, _V[1]		, 0, 0, normal, _s_tint, $brightness.b010 * sideBrightness );
				break;
				
			default:
				Log.out( "Quad.addStraightVertices - Plane INVALID", Log.ERROR );
			}
			
		buildIndices( normal );
	}
	
	private function add( $type:int, x:Number, y:Number, z:Number, face:int, plane_facing:int, scale:Number, $ti:TypeInfo, $brightness:Brightness ):void
	{
		//Log.out( "Quad.addStraightVerticesNew temp: " + brightness );
		//Log.out( "Quad.asvn - plane_facing: " + plane_facing );
		var vertexIndex:int;
		_s_tint = Color.toVector3D( _s_tint, Color.combineRGB( $ti.color, $brightness.color ) );
		
		var sideBrightness:Number = 0.5;
		var normal:int = 1;
		switch ( face ) 
		{
			case Globals.POSX:
				//trace( "Quad.addStraightVertices - addQuad POSX" );
				normal = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x + scale	, y         , z			, _U[1]		, _V[3]		, normal, 0, 0, _s_tint, $brightness.b100 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z			, _U[2]		, _V[0]		, normal, 0, 0, _s_tint, $brightness.b110 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[3]		, _V[1]		, normal, 0, 0, _s_tint, $brightness.b111 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y         , z + scale	, _U[0]		, _V[2]		, normal, 0, 0, _s_tint, $brightness.b101 * sideBrightness );
				break;
				
			case Globals.NEGX:
				//trace( "Quad.addStraightVertices - addQuad NEGX" );
				normal = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y         , z			, _U[3]		, _V[3]		, normal, 0, 0, _s_tint, $brightness.b000 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z			, _U[0]		, _V[0]		, normal, 0, 0, _s_tint, $brightness.b010 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[1]		, _V[1]		, normal, 0, 0, _s_tint, $brightness.b011 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y         , z + scale	, _U[2]		, _V[2]		, normal, 0, 0, _s_tint, $brightness.b001 * sideBrightness );
				break;
				
			case Globals.NEGY:
				//trace( "Quad.addStraightVertices - addQuad POSY" );
				normal = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y             , z			, _U[0]		, _V[0]		, 0, normal, 0, _s_tint, $brightness.b000 );
				vertexIndex = buildVertices( vertexIndex, x			, y             , z + scale	, _U[3]		, _V[3]		, 0, normal, 0, _s_tint, $brightness.b001 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y				, z + scale	, _U[2]		, _V[2]		, 0, normal, 0, _s_tint, $brightness.b101 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y				, z			, _U[1]		, _V[1]		, 0, normal, 0, _s_tint, $brightness.b100 );
				break;
				
			case Globals.POSY:
				//trace( "Quad.addStraightVertices - addQuad NEGY" );
				normal = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z			, _U[0]		, _V[0]		, 0, normal, 0, _s_tint, $brightness.b010 );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[3]		, _V[3]		, 0, normal, 0, _s_tint, $brightness.b011 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[2]		, _V[2]		, 0, normal, 0, _s_tint, $brightness.b111 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z			, _U[1]		, _V[1]		, 0, normal, 0, _s_tint, $brightness.b110 );
				break;

			case Globals.POSZ:
				//trace( "Quad.addStraightVertices - addQuad POSZ" );
				normal = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y			, z + scale	, _U[0]		, _V[2]		, 0, 0, normal, _s_tint, $brightness.b001 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y			, z + scale	, _U[1]		, _V[3]		, 0, 0, normal, _s_tint, $brightness.b101 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[2]		, _V[0]		, 0, 0, normal, _s_tint, $brightness.b111 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[3]		, _V[1]		, 0, 0, normal, _s_tint, $brightness.b011 * sideBrightness );
				break;
				
			case Globals.NEGZ:
				//trace( "Quad.addStraightVertices - addQuad NEGZ" );
				normal = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y			, z			, _U[2]		, _V[2]		, 0, 0, normal, _s_tint, $brightness.b000 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y			, z			, _U[3]		, _V[3]		, 0, 0, normal, _s_tint, $brightness.b100 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z			, _U[0]		, _V[0]		, 0, 0, normal, _s_tint, $brightness.b110 * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z			, _U[1]		, _V[1]		, 0, 0, normal, _s_tint, $brightness.b010 * sideBrightness );
				break;
				
			default:
				Log.out( "Quad.addStraightVertices - Plane INVALID", Log.ERROR );
		}
			
		buildIndices( normal );
	}


	
	
	///////////////////////
	// DEPRECATED DEPRECATED DEPRECATED
	///////////////////////
/*
	public function buildVerticies( type:int,						// material type
									x:Number, y:Number, z:Number,	// world location
									face:int,						// which 
									plane_facing:int,				// facing
									scale:Number ):void			// the world size of the quad 
	{
		var typeInfo:TypeInfo = Globals.Info[type];
		if ( !calculateUV( typeInfo, face, scale, null ) )
			return;
			
		// This tint gets added into the texture from oxel.png
		var tint:Vector3D = typeInfo.tint.clone();
		var a:Array = Color.RGBtoHSV( tint.x * 255, tint.y * 255, tint.z * 255 );
		a[2] = a[2] * _brightness;
		a = Color.HSVtoRGB( a[0], a[1], a[2] );
		tint.x = a[0]/255;
		tint.y = a[1]/255;
		tint.z = a[2]/255;
		
		//addStraightVertices( x:Number, y:Number, z:Number, face:int, plane_facing:int, scale:Number, tint:Vector3D, $brightness:Number ):void
		addStraightVertices( type, x, y, z, face, plane_facing, scale, tint, _brightness );
	}
	
	public function buildFlowingVerticies( type:int, x:Number, y:Number, z:Number, face:int, plane_facing:int, scale:Number, tint:Vector3D, $brightness:Number ):void {
		var timer:int = getTimer();

		var ut:Number = Globals.Info[type].ut * _s_TextureScale
		var vt:Number = Globals.Info[type].vt * _s_TextureScale

		var us:Number = Globals.Info[type].us * _s_TextureScale
		var vs:Number = Globals.Info[type].vs * _s_TextureScale
		
		const HALFTEX_SIZE:Number = _s_TextureScale / 5;

		var vertexIndex:int = 0;
		var facing:int = 1;
		switch ( face ) {
			case Globals.POSX:
				//trace( "Quad - addQuad POSX" );
				facing = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x + scale, y        , z        , us               , vs               , facing, 0, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y * scale, z        , us + HALFTEX_SIZE, vs               , facing, 0, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y * scale, z + scale, us + HALFTEX_SIZE, vs + _s_TextureScale, facing, 0, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y        , z + scale, us 		        , vs + _s_TextureScale, facing, 0, 0, tint, $brightness );
				break;
			case Globals.NEGX:
				//trace( "Quad - addQuad NEGX" );
				facing = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x, y        , z        , us               , vs               , facing, 0, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x, y * scale, z        , us + HALFTEX_SIZE, vs               , facing, 0, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x, y * scale, z + scale, us + HALFTEX_SIZE, vs + _s_TextureScale, facing, 0, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x, y        , z + scale, us 			   , vs + _s_TextureScale, facing, 0, 0, tint, $brightness );
				break;
				
			case Globals.POSY:
				//trace( "Quad - addQuad POSY" );
				facing = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x        , y, z        , ut               , vt               , 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y, z        , ut + _s_TextureScale, vt               , 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y, z + scale, ut + _s_TextureScale, vt + _s_TextureScale, 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x        , y, z + scale, ut               , vt + _s_TextureScale, 0, facing, 0, tint, $brightness );
				break;
			case Globals.NEGY:
				//trace( "Quad - addQuad NEGY" );
				facing = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x        , y * scale, z        , ut               , vt + _s_TextureScale, 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y * scale, z        , ut               , vt               , 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y * scale, z + scale, ut + _s_TextureScale, vt               , 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x        , y * scale, z + scale, ut + _s_TextureScale, vt + _s_TextureScale, 0, facing, 0, tint, $brightness );
				break;
				
			case Globals.POSZ:
				//trace( "Quad - addQuad POSZ" );
				facing = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x        , y        , z + scale, us                , vs + _s_TextureScale, 0, 0, facing, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y        , z + scale, us                , vs               , 0, 0, facing, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y * scale, z + scale, us  + HALFTEX_SIZE, vs               , 0, 0, facing, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x        , y * scale, z + scale, us  + HALFTEX_SIZE, vs + _s_TextureScale, 0, 0, facing, tint, $brightness );
				break;
			case Globals.NEGZ:
				//trace( "Quad - addQuad NEGZ" );
				facing = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x        , y        , z, us               , vs               , 0, 0, facing, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y        , z, us               , vs + _s_TextureScale, 0, 0, facing, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale, y * scale, z, us + HALFTEX_SIZE, vs + _s_TextureScale, 0, 0, facing, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x        , y * scale, z, us + HALFTEX_SIZE, vs               , 0, 0, facing, tint, $brightness );
				break;
			default:
				Log.out( "Quad - NEW - Plane INVALID", Log.ERROR );
			}
		
		buildIndices( facing );
	}

	private function addStraightVertices( type:int, x:Number, y:Number, z:Number, face:int, plane_facing:int, scale:Number, tint:Vector3D, $brightness:Number ):void
	{
		var vertexIndex:int = 0;
		var facing:int = 1;
		
		var sideBrightness:Number = 0.5;
		var ti:TypeInfo = Globals.Info[type];
		if ( ti.light || 1000 <= ti.type )
		{
			sideBrightness = 1;
		}
		if ( Globals.WATER == type )
			brightness /= 2;
		
		switch ( face ) 
		{
			case Globals.POSX:
				//trace( "Quad.addStraightVertices - addQuad POSX" );
				facing = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x + scale	, y         , z			, _U[1]		, _V[3]		, facing, 0, 0, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z			, _U[2]		, _V[0]		, facing, 0, 0, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[3]		, _V[1]		, facing, 0, 0, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y         , z + scale	, _U[0]		, _V[2]		, facing, 0, 0, tint, $brightness * sideBrightness );
				break;
				
			case Globals.NEGX:
				//trace( "Quad.addStraightVertices - addQuad NEGX" );
				facing = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y         , z			, _U[3]		, _V[3]		, facing, 0, 0, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z			, _U[0]		, _V[0]		, facing, 0, 0, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[1]		, _V[1]		, facing, 0, 0, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y         , z + scale	, _U[2]		, _V[2]		, facing, 0, 0, tint, $brightness * sideBrightness );
				break;
				
			case Globals.NEGY:
				//trace( "Quad.addStraightVertices - addQuad POSY" );
				facing = -1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y             , z			, _U[0]		, _V[0]		, 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y				, z			, _U[1]		, _V[1]		, 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y				, z + scale	, _U[2]		, _V[2]		, 0, facing, 0, tint, $brightness );
				vertexIndex = buildVertices( vertexIndex, x			, y             , z + scale	, _U[3]		, _V[3]		, 0, facing, 0, tint, $brightness );
				break;
				
			case Globals.POSY:
				//trace( "Quad.addStraightVertices - addQuad NEGY" );
				facing = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z			, _U[0]		, _V[0]		, 0, facing, 0, tint, $brightness );
				tint.scaleBy( 0.9 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z			, _U[1]		, _V[1]		, 0, facing, 0, tint, $brightness * 0.6 );
				tint.scaleBy( 0.9 );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[2]		, _V[2]		, 0, facing, 0, tint, $brightness * 0.4 );
				tint.scaleBy( 0.9 );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[3]		, _V[3]		, 0, facing, 0, tint, $brightness * 0.2 );
				break;
				
			case Globals.POSZ:
				//trace( "Quad.addStraightVertices - addQuad POSZ" );
				facing = -1 * plane_facing;
				//vertexIndex = buildVertices( vertexIndex, x			, y			, z + scale	, _U[2]		, _V[2]		, 0, 0, facing, tint, $brightness * sideBrightness );
				//vertexIndex = buildVertices( vertexIndex, x + scale	, y			, z + scale	, _U[3]		, _V[3]		, 0, 0, facing, tint, $brightness * sideBrightness );
				//vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[0]		, _V[0]		, 0, 0, facing, tint, $brightness * sideBrightness );
				//vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[1]		, _V[1]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y			, z + scale	, _U[0]		, _V[2]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y			, z + scale	, _U[1]		, _V[3]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z + scale	, _U[2]		, _V[0]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z + scale	, _U[3]		, _V[1]		, 0, 0, facing, tint, $brightness * sideBrightness );
				break;
				
			case Globals.NEGZ:
				//trace( "Quad.addStraightVertices - addQuad NEGZ" );
				facing = 1 * plane_facing;
				vertexIndex = buildVertices( vertexIndex, x			, y			, z			, _U[2]		, _V[2]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y			, z			, _U[3]		, _V[3]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x + scale	, y + scale	, z			, _U[0]		, _V[0]		, 0, 0, facing, tint, $brightness * sideBrightness );
				vertexIndex = buildVertices( vertexIndex, x			, y + scale	, z			, _U[1]		, _V[1]		, 0, 0, facing, tint, $brightness * sideBrightness );
				break;
				
			default:
				Log.out( "Quad.addStraightVertices - Plane INVALID", Log.ERROR );
			}
			
		buildIndices( facing );
	}
	*/
	
}
}

