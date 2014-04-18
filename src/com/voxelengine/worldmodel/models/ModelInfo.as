/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.furusystems.dconsole2.core.commands.IntrospectionCommand;
	import com.voxelengine.worldmodel.animation.Animation;
	import com.voxelengine.worldmodel.biomes.Biomes;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	/**
	 * ...
	 * @author Bob
	 */
	public class ModelInfo 
	{
		private var _fileName:String = "INVALID";
		private var _editable:Boolean = false;
		private var _template:Boolean = false;
		private var _biomes:Biomes = null;
		private var _parent:ModelInfo = null;
		private var _modelClass:String = "VoxelModel";
		private var _children:Vector.<InstanceInfo> = new Vector.<InstanceInfo>;
		private var _scripts:Vector.<String> = new Vector.<String>;
		private var _grainSize:int = 0;
		private var _name:String = "Default_Name";
		private var _desc:String = "Default_Description";
		private var _modelJson:Object = null;
		private var _animations:Vector.<Animation> 		= new Vector.<Animation>();

		public function get json():Object 						{ return _modelJson; }
		public function get fileName():String 					{ return _fileName; }
		public function set fileName(val:String):void 			{ _fileName = val; }
		public function get editable():Boolean 					{ return _editable; }
		public function set editable(val:Boolean):void			{ _editable = val; }
		public function get template():Boolean 					{ return _template; }
		public function set template(val:Boolean):void	 		{ _template = val; }
		public function get biomes():Biomes 					{ return _biomes; }
		public function get children():Vector.<InstanceInfo> 	{ return _children; }
		public function get scripts():Vector.<String> 			{ return _scripts; }
		public function get modelClass():String					{ return _modelClass; }
		public function set modelClass(val:String):void 		{ _modelClass = val; }
		public function get grainSize():int						{ return _grainSize; }
		public function set grainSize(val:int):void				{ _grainSize = val; }
		public function get name():String						{ return _name; }
		public function set name(val:String):void				{ _name = val; }
		public function get desc():String						{ return _desc; }
		public function set desc(val:String):void				{ _desc = val; }
		
		public function get parent():ModelInfo  				{ return _parent; }
		public function set parent(val:ModelInfo):void 			{ _parent = val; }
		
		public function get animations():Vector.<Animation> 	{ return _animations; }

		//public function biomesReset():void 					{ _biomes = null; }

		public function ModelInfo():void 
		{ 
			; 
		}
		
		public function clone( newGuid:String = "" ):ModelInfo
		{
			var newModelInfo:ModelInfo = new ModelInfo();
			if ( "" == newGuid )
				newModelInfo.fileName 			= Globals.getUID();
			else	
				newModelInfo.fileName 			= newGuid;
				
			newModelInfo._editable 		= this.editable;
			newModelInfo._template      = this.template;
			newModelInfo._parent		= null;               // Don't want to inherit this
			newModelInfo._modelClass	= this.modelClass;
			newModelInfo._grainSize		= this.grainSize;
			newModelInfo._name			= this.name;
			newModelInfo._modelJson		= this._modelJson;
			
			if ( _biomes )
				newModelInfo._biomes 		= _biomes.clone();
			
			// This clone is important, and it creates a unique instance for each child
			// otherwise the children all share the same instanceInfo, which is not good
			for each ( var ii:InstanceInfo in _children )
				newModelInfo.childAdd( ii.clone() );
			// The cloning here was overwriting changes I made during the repeat stage
			// I think that each ii is already unique, or SHOULD be.

			for each ( var script:String in _scripts )
				newModelInfo._scripts.push( script );
			
			for each ( var animation:Animation in _animations )
				newModelInfo._animations.push( animation );
				
			return newModelInfo;
		}
		
		public function childAdd( instanceInfo:InstanceInfo):void
		{
			// Dont add child that already exist
			for each ( var child:InstanceInfo in _children )
			{
				if ( child === instanceInfo )
				{
					return;
				}
			}
			_children.push( instanceInfo );
		}
			
		public function childRemove( instanceInfo:InstanceInfo):void
		{
			var index:int = 0;
			for each ( var child:InstanceInfo in _children )
			{
				if ( child === instanceInfo )
				{
					_children.splice( index, 1 );
					return;
				}
				
				index++;
			}
		}
		
		public function getJSON():String
		{
			var json:String = "{\"model\":";
			json += JSON.stringify( this );			
			json +=  "}"

			return json;
		}
	
		public function toJSON(k:*):* 
		{ 
			return {
					name:			_name,
					desc:			_desc,
					editable: 		_editable,
					template:		_template,
					biomes:			_biomes,
					children:		_children,
					grainSize:		_grainSize,
					modelClass:		_modelClass,
					animations:		_animations
					};
		} 	
		
		public function init( $fileNameNoExt:String, $json:Object ):void 
		{
			//Log.out( "ModelInfo.init - fileName: " + $fileNameNoExt + "  $json: " + JSON.stringify( $json.model ) );
			_modelJson = $json;
			_fileName = $fileNameNoExt;
			
			if ( !$json.model  )
			{
				Log.out( "ModelInfo.init - ERROR - unable to find model Info in : " + $fileNameNoExt + "  containing: " + JSON.stringify($json), Log.ERROR );					
				return;
			}
				
			var json:Object = $json.model;
			
			if ( json && json.guid  )
				Log.out( "ModelInfo.init - WARNING - FOUND OLD modelGuid in file: " + $fileNameNoExt );					
				
			
			if ( json.grainSize )
				_grainSize = 	json.grainSize;
			else if ( json.GrainSize )
				_grainSize = 	json.GrainSize;
			else if ( json.grainsize )
				_grainSize = 	json.grainsize;
			
			if ( json.name )
			{
				name = json.name;
			}
			
			if ( json.desc )
			{
				desc = json.desc;
			}
			
			if ( json.modelClass )
				_modelClass = json.modelClass;

			if ( json.script )
			{
				for each ( var scriptObject:Object in json.script )
				{
					if ( scriptObject.name )
					{
						//trace( "ModelInfo.init - Model GUID:" + fileName + "  adding script: " + scriptObject.name );
						_scripts.push( scriptObject.name );
					}
				}
			}
			
			if ( json.template )
			{
				var templateAbility:String = json.template;
				if ( "true" == templateAbility.toLowerCase() )
					_template = true;
				else	
					_template = false;
			}
			
			if ( json.editable )
			{
				var editAbility:String = json.editable;
				if ( "true" == editAbility.toLowerCase() )
					_editable = true;
				else	
					_editable = false;
			}
				
			if ( json.biomes )
			{
				var biomes:Object = json.biomes;
				if ( !biomes  )
				{
					throw new Error( "ModelInfo.init - WARNING - unable to find biomesXML: " + fileName );					
					return;
				}
				
				const createHeightMap:Boolean = true;
				_biomes = new Biomes( createHeightMap  );
				if (  !json.biomes.layers )
				{
					throw new Error( "ModelInfo.init - WARNING - unable to find layerInfo: " + fileName );					
					return;
				}
				var layers:Object = json.biomes.layers;
				_biomes.load_biomes_data(layers);
			}
			
			if ( json.children )
			{
				var children:Object = json.children;
				for each ( var v:Object in children )		   
				{
					var ii:InstanceInfo = new InstanceInfo();
					ii.initJSON( v );
					parent = this;
					childAdd( ii );
				}
			}
			
			if ( json.animations )
			{
				//Log.out( "ModelInfo.init - animations found" );
				var animationsObj:Object = json.animations;
				for each ( var a:Object in animationsObj )		   
				{
					var animation:Animation = new Animation( a, $fileNameNoExt );
					_animations.push( animation )
				}
			}
		}
	}
}