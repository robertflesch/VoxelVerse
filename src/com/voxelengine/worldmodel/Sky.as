/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.renderer.VertexIndexBuilder;
	import com.voxelengine.renderer.Quad;
	import flash.display.Bitmap;
	import flash.display3D.textures.CubeTexture;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.display.BitmapData;

	import flash.display3D.Context3D;
	
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class Sky 
	{
		//private var _skyBitmap:Bitmap;
		//[Embed(source='../../../assets/skyTest1024.png')]
		//private var _skyImage:Class;
		
		//private var _sunPos:Vector3D = new Vector3D(128,128,128);
		private var _sunPos:Vector3D;
//		private var _ambientSunrise:Vector3D = new Vector3D(0.1, 0.1, 0.1);
		//private var _ambientSunrise:Vector3D = new Vector3D(0.3, 0.3, 0.3);
		private var _ambientSunrise:Vector3D = new Vector3D(0.4, 0.4, 0.4);
		private var _ambient:Vector3D;
		//private var _ambient:Vector3D = new Vector3D(0.8, 0.8, 0.8);
		private const _sunPosInc:Vector3D =  new Vector3D( 0.1, 0.15, 0 );
		private const _sunPosDec:Vector3D =  new Vector3D( 0.1, -0.15, 0 );
		private const _ambientInc:Vector3D =  new Vector3D( -0.001, 0.002, 0.002 );
		private const _ambientDec:Vector3D =  new Vector3D( -0.001, -0.002, -0.002 );
		private const _ambientMax:Vector3D =  new Vector3D( 0.8, 0.8, 0.8 );
//		private const _ambientMax:Vector3D =  new Vector3D( 1, 1, 1 );
		private var _bufferObject:VertexIndexBuilder;
		private var _oxel:Oxel;
		private var _cubeTex:CubeTexture
		private var _voxelModel:VoxelModel;

		private var _moveSun:Boolean = false;
		
		private static var _count:int = 0;
		
		public function get sunPos():Vector3D { return _sunPos; }
		public function get ambient():Vector3D { return _ambient; }
		public function get cubeTex():CubeTexture { return _cubeTex; }
		
		public function init( context:Context3D, voxelModel:VoxelModel ):void {
			_voxelModel = voxelModel;
			_bufferObject = new VertexIndexBuilder();
			
			var plane_facing:int = -1;
			var grain:int = 24;
			var loc:GrainCursor = GrainCursorPool.poolGet( _voxelModel.oxel.size_of_grain() );
			loc.grain = grain;
			_oxel = new Oxel( null, loc , Globals.STONE );
			_oxel.faces_set_all();
			Quad.texture_scale_set( 1.0 );
			_oxel.quads_build_sky( plane_facing );
			Quad.texture_scale_set( 1.0/4.0 );
			_bufferObject.addOxel( _oxel );
		
			_sunPos = new Vector3D( -1 / 2, 0, 1 / 2);
			_ambient = new Vector3D(_ambientSunrise.x, _ambientSunrise.y, _ambientSunrise.z);
			
			
			/*
			Creates a CubeTexture object.
			Use a CubeTexture object to upload cube texture bitmaps to the rendering context and to reference a cube texture during rendering. A cube texture consists of six equal-sized, square textures arranged in a cubic topology and are useful for describing environment maps.

			You cannot create CubeTexture objects with a CubeTexture constructor; use this method instead. After creating a CubeTexture object, upload the texture bitmap data using the CubeTexture uploadFromBitmapData(), uploadFromByteArray(), or uploadCompressedTextureFromByteArray() methods..
			*/
			 _cubeTex = makeCubeTexture(16, context);
			 /*
			_skyBitmap = (new _skyImage() as Bitmap);
			_cubeTex = context.createCubeTexture( 256, "bgra", false );
			uploadTextureWithMipmaps( _cubeTex, _skyBitmap.bitmapData );
			_cubeTex.uploadFromBitmapData( _skyBitmap.bitmapData, 0 );
			_cubeTex.uploadFromBitmapData( _skyBitmap.bitmapData, 1 );
			_cubeTex.uploadFromBitmapData( _skyBitmap.bitmapData, 2 );
			_cubeTex.uploadFromBitmapData( _skyBitmap.bitmapData, 3 );
			_cubeTex.uploadFromBitmapData( _skyBitmap.bitmapData, 4 );
			_cubeTex.uploadFromBitmapData( _skyBitmap.bitmapData, 5 );
			*/
		}
		
		private function bd(size:uint, color:uint):BitmapData {
			return new BitmapData(size, size, false, color)
		}		
		
		private function makeCubeTexture(size:uint, context:Context3D ):CubeTexture {
			var tex:CubeTexture = context.createCubeTexture(size, "bgra", false)
			
			var mm:uint = 0
			for(; size != 0 ; size >>= 1){
				tex.uploadFromBitmapData( bd(size, 0xff0000), 0, mm)
				tex.uploadFromBitmapData( bd(size, 0x00ff00), 1, mm)
				tex.uploadFromBitmapData( bd(size, 0x0000ff), 2, mm)
				tex.uploadFromBitmapData( bd(size, 0xff00ff), 3, mm)
				tex.uploadFromBitmapData( bd(size, 0xffff00), 4, mm)
				tex.uploadFromBitmapData( bd(size, 0x00ffff), 5, mm)
				mm ++
			}
			return tex
		}	
		
		public function draw( context:Context3D ):void {
			buffersBuildFromOxels( context );
			_bufferObject.BufferCopyToGPU( context );
			//_bufferObject.moveSkyTrianglesToGPU( context );
		}
		
		public function clear():void {
			_bufferObject.clear();
		}
		
		public function dispose():void 
		{
			_bufferObject.dispose();
		}
		
		public function buffersBuildFromOxels( context:Context3D ):void 
		{
			if ( true == _bufferObject.isDirty )
			{
				_bufferObject.dispose();
				_bufferObject.buffersBuildFromOxels( context );
			}
		}
		
		public function updateLighting():void {
			
			if ( false == _moveSun ) {
				_sunPos.setTo( 1 / 2, 1 + 32, 1 / 2 );
				_ambient.setTo( _ambient.x, _ambient.y, _ambient.z );
				
			} else {
				if ( _count++ > 100 ) {
					_count = 0
					trace( "sun pos x: " + _sunPos.x + " y: " + _sunPos.y + " z: " + _sunPos.z + "  ambient x: " + _ambient.x + " y: " + _ambient.y + " z: " + _ambient.z );
				}
				
				if ( 192 > _sunPos.x ) 
				{
					if ( 64 <= _sunPos.x )
						_sunPos.incrementBy( _sunPosDec ); // zenith
					else
						_sunPos.incrementBy( _sunPosInc );
				}
				else 
				{
					_sunPos.setTo( -1 / 2, 0, 1 / 2 );
				}
				
				if ( -32 >= _sunPos.x ) 
				{
					//morning, let it be redish
				}
				else if ( ( -32 < _sunPos.x ) && ( _sunPos.x <= 64 ) && ( _ambient.y < 0.8 ) )  
				{
					_ambient.incrementBy( _ambientInc );
				}
				else if ( ( 64 < _sunPos.x ) && ( _sunPos.x <= 128 ) )  
				{
					_ambient.incrementBy( _ambientDec );
				}
				else 
				{
					_ambient.setTo( _ambientSunrise.x, _ambientSunrise.y, _ambientSunrise.z );
				}
			}
		}

	}
	
}