/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.shaders 
{
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.geom.Matrix3D;

	import com.adobe.utils.AGALMiniAssembler;
	
	import com.voxelengine.renderer.shaders.Shader;
	
	public class ShaderFire extends Shader {

		public function ShaderFire( $context:Context3D ) {
			super( $context );
			createProgram( $context );
		}
		
		override public function update( mvp:Matrix3D, $vm:VoxelModel, $context:Context3D, selected:Boolean, $isChild:Boolean = false ): Boolean {
			if ( !update_texture( $context ) )
				return false;
			
			$context.setProgram( program3D );	
			setVertexData( mvp, $vm, $context );
			setFragmentData( $isChild, $vm, $context );
			
			//$context.setCulling(Context3DTriangleFace.NONE);
			$context.setCulling(Context3DTriangleFace.BACK);
			
			var sourceFactor:String = Context3DBlendFactor.SOURCE_ALPHA;
			//var destinationFactor:String = Context3DBlendFactor.SOURCE_COLOR;
			var destinationFactor:String = Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR
			$context.setBlendFactors( sourceFactor, destinationFactor );
			
			return true;
		}

		override protected function setVertexData( mvp:Matrix3D, $vm:VoxelModel, $context:Context3D ): void {
			// send down the view matrix
			$context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mvp, true); // aka vc0

			var invmat:Matrix3D = $vm.instanceInfo.modelMatrix.clone();
			if ( _isAnimated ) 
			{
				animationOffsets();
			}
			$context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, _offsets);
		}
		
		override protected function setFragmentData( $isChild:Boolean, $vm:VoxelModel, $context:Context3D ): void { return; } // nothing needed here
		
		override public function animationOffsets():void {
				_textureOffsetV += 0.0078125;
				_textureOffsetU = 0;
//				if ( _textureOffsetU > (0.0625 * 5) )
				// ah, now I recall, I repeated the first texture at the end, so that it doesnt pop.
				if ( _textureOffsetV > 0.9921875 ) // this scroll DOWN a single 2048x2048 texture
					_textureOffsetV = 0;
					
				_offsets[0] = _textureOffsetU;
				_offsets[1] = _textureOffsetV;

		}
		
		override public function createProgram( $context:Context3D ):void {
			// This uses 3 peices of vertex data from - setVertexData
			// va0 holds the vertex locations
			// va1 holds the UV texture offset
			// va2 holds the normal data ( in a very ineffiencent way )
			// and two constant values
			// vc0-3 hold the transform matrix for the camera
			// vc4 holds the UV offsets for the texture
			var vertexShader:Array =
			[
				"m44 op, va0, vc0", // transform vertex positions (va0) by the world camera data (vc0)
				"add v0, va1, vc4.xy",	// add in the UV offset (va1) and the animated offset (vc12) (may be 0 for non animated), and put in v0 which holds the UV offset
				"mov v1, va3",        	// pass texture color and brightness (va3) to the fragment shader via v1
				"mov v2, va2",        	// need to pass normals to keep shader compiler happy
				"m44 v3, va0, vc8",  	// the transformed vertices with out the camera data, works great for default AND for translated cube, rotated cube broken still
				"mov v4, va4",        	// pass light color and brightness (va4) to the fragment shader via v4
			];
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX, vertexShader.join("\n"));
			
			// This uses 4 peices of data from vertex shader
			// v0 holds the offset UV data
			// v1 holds the texture color and brightness
			// temp registers
			// ft0 holds the texture data
			var fragmentShader:Array =
			[
				// Texture
				// texture dimension. Options: 2d, cube
				// mip mapping. Options: nomip (or mipnone , they are the same) , mipnearest, miplinear
				// texture filtering. Options: nearest, linear
				// texture repeat. Options: repeat, wrap, clamp
				"tex ft0, v0, fs0 <2d,clamp,mipnearest>", // v1 is passed in from vertex, UV coordinates
				// now apply the color and brightness from the vertex attirbutes
				"mul ft0, v1.xyz, ft0", // texture color - v3.xyz
				// should this or light from dynamic source take greater value?
				"mul ft0, ft0, v1.w",   // brightness - v3.w
				"mov oc ft0"
				
			];
			
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT, fragmentShader.join("\n"));
			
			_program3D = $context.createProgram();
			_program3D.upload(vertexShaderAssembler.agalcode, fragmentAssembler.agalcode);
		}
		
	}
}
