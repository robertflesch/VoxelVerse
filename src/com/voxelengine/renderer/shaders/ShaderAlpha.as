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
	import flash.geom.Vector3D;

	import com.voxelengine.renderer.shaders.Shader;
	import com.adobe.utils.AGALMiniAssembler;
	
	public class ShaderAlpha extends Shader {


		public function ShaderAlpha( $context:Context3D ) {
			super( $context );
			createProgram( $context );
		}
		
		override public function update( mvp:Matrix3D, $vm:VoxelModel, selected:Boolean, $isChild:Boolean = false ): Boolean {
			if ( !update_texture() )
				return false;
			
			_context.setProgram( program3D );	
			setVertexData( mvp, $vm );
			setFragmentData( $isChild, $vm );
			
			//_context.setCulling(Context3DTriangleFace.NONE);
			_context.setCulling(Context3DTriangleFace.BACK);
			
			var sourceFactor:String = Context3DBlendFactor.SOURCE_ALPHA;
			var destinationFactor:String = Context3DBlendFactor.SOURCE_COLOR;
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ZERO);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.DESTINATION_COLOR);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.DESTINATION_ALPHA);
			//_context.setBlendFactors( Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);

			_context.setBlendFactors( sourceFactor, destinationFactor );
			
			return true;
		}

		override public function animationOffsets():void {
				//_textureOffsetV -= 0.0001; // This was in here
				_textureOffsetV -= 0.000025;

				if ( _textureOffsetV < -0.953125 ) // this scrolls up a single 1952 pixels
					_textureOffsetV = 0;
					
				_offsets[0] = _textureOffsetU;
				_offsets[1] = _textureOffsetV;
		}
	}
}
