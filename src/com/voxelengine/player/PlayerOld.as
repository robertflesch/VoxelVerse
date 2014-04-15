package com.voxelengine.player
{
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.Location;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.utils.GameTime;
	import com.voxelengine.Globals;
    import flash.geom.Vector3D;

    public class PlayerOld
    {
        private var _voxelModel:VoxelModel = null;
//        private var _lastPosition:Vector3DExt = new Vector3DExt();
//        private var _position:Vector3DExt = new Vector3DExt();
//        private var _velocity:Vector3DExt = new Vector3DExt();
        //private var _gravity:Gravity;
		private var _gravity:Vector3D = new Vector3D(0, -1, 0);
        //private double          _headBob;
        //private PlayingState    _state;
/*
        private BubbleParticleSystem    _bubbleParticleSystem;
        private SnowParticleSystem      _snowParticleSystem;
        private SoundEffect             _bubbleSound;
        private SoundEffectInstance     _bubbleSoundInstance;
        private SoundEffect             _splashSound;
        private bool                    _wasUnderwater;
*/
        private var _isAboveSnowline:Boolean = false;

        public function Player():void { ; }
		
		public function init( voxelModel:VoxelModel ):void {
            _voxelModel = voxelModel;
			//_gravity = new Gravity();
			//_gravity.init( new Vector3D(0, -1, 0), Gravity.NEGY );
		}

		public function isNewPositionValid( newWorldPosition:Vector3D, oldWorldPosition:Vector3D ):Boolean 
		{
			const offset:Number = 0.5;
			if ( Globals.g_selectedModel )
			{
				var gct0:GrainCursor = GrainCursorPool.poolGet( Globals.g_selectedModel.oxel.gc.bound );
				
				var newModelSpacePosition:Vector3D = Globals.g_selectedModel.worldToModel( newWorldPosition );
				var oldModelSpacePosition:Vector3D = Globals.g_selectedModel.worldToModel( oldWorldPosition );
				
				newModelSpacePosition.y -= 32;
				GrainCursor.getFromPoint( newModelSpacePosition.x, newModelSpacePosition.y - offset, newModelSpacePosition.z, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid )
				{
 					newModelSpacePosition.y = oldModelSpacePosition.y - 32;
				}
				else
				{
					newModelSpacePosition.incrementBy( _gravity );
				}
				
				GrainCursor.getFromPoint( newModelSpacePosition.x - offset, newModelSpacePosition.y + offset, newModelSpacePosition.z + offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				GrainCursor.getFromPoint( newModelSpacePosition.x - offset, newModelSpacePosition.y + offset, newModelSpacePosition.z - offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				GrainCursor.getFromPoint( newModelSpacePosition.x - offset, newModelSpacePosition.y - offset, newModelSpacePosition.z + offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				GrainCursor.getFromPoint( newModelSpacePosition.x - offset, newModelSpacePosition.y - offset, newModelSpacePosition.z - offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				
				GrainCursor.getFromPoint( newModelSpacePosition.x + offset, newModelSpacePosition.y + offset, newModelSpacePosition.z + offset, gct0 );
				var fo:Oxel = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				GrainCursor.getFromPoint( newModelSpacePosition.x + offset, newModelSpacePosition.y + offset, newModelSpacePosition.z - offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				GrainCursor.getFromPoint( newModelSpacePosition.x + offset, newModelSpacePosition.y - offset, newModelSpacePosition.z + offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				GrainCursor.getFromPoint( newModelSpacePosition.x + offset, newModelSpacePosition.y - offset, newModelSpacePosition.z - offset, gct0 );
				fo = Globals.g_selectedModel.oxel.childFind( gct0 );
				if ( fo.solid ) return false;
				
				GrainCursorPool.poolDispose( gct0 );
			}
			return true;
		}

		// -1 means can't move in the - offset direction
		//  0 means
		//  1 means can't move in the + offset direction
		// only testing x and z components here
		public function getSlidingFactor( loc:Vector3D, resultVec:Vector3D ):Boolean {
			const offset:Number = 0.1;
			var result:Boolean = false;
			var _testLoc:Location = new Location();
			resultVec.setTo(0, 0, 0);

			_testLoc.setTo( loc.x + offset, loc.y, loc.z );
			result = _voxelModel.solidAt( _testLoc );
			// cant move forward in X
			if ( true == result )
				resultVec.x = 1;
				
			_testLoc.setTo( loc.x - offset, loc.y, loc.z );
			result = _voxelModel.solidAt( _testLoc );
			if ( true == result ){
				if ( 1 == resultVec.x )
					trace( "Player - getSlidingFactor - X cant move + or -" );
				resultVec.x = -1;
			}
				
			_testLoc.setTo( loc.x, loc.y, loc.z + offset );
			result = _voxelModel.solidAt( _testLoc );
			if ( true == result )
				resultVec.z = 1;

			_testLoc.setTo( loc.x, loc.y, loc.z - offset );
			result = _voxelModel.solidAt( _testLoc );
			if ( true == result ) {
				if ( 1 == resultVec.x )
					trace( "Player - getSlidingFactor - Z cant move + or -" );
				resultVec.z = -1;
			}
			
			return !result;
		}
		
        //public function get lastPosition():Vector3DExt { return _lastPosition; }
        //public function set lastPosition( val:Vector3DExt ):void { _lastPosition = val; }

        //public function get position():Vector3DExt { return _lastPosition; }
        //public function set position( val:Vector3DExt ):void { _lastPosition = val; }

        //public function get velocity():Vector3DExt { return _velocity; }
        //public function set velocity( val:Vector3DExt ):void { _velocity = val; }
		
/*
        public FirstPersonCamera Camera
        {
            get
            {
                return (FirstPersonCamera)_game.Camera;
            }
        }

        public void Initialize()
        {
            ResetVelocity();
            _bubbleParticleSystem = new BubbleParticleSystem(_game);
            _bubbleParticleSystem.Initialize();
            _snowParticleSystem = new SnowParticleSystem(_game);
            _snowParticleSystem.Initialize();
            _gravity = new Gravity();

            _position = new Vector3DExt(WorldSettings.MAPWIDTH / 2, + 15, WorldSettings.MAPLENGTH / 2);
            _gravity.Initialize(_voxelModel, new Vector3DExt(0, -1f, 0), Gravity.EGravityDirection.NegY);
            _velocity.y = -0.1f;

            //_position = new Vector3DExt(WorldSettings.MAPWIDTH / 2, WorldSettings.MAPHEIGHT - 15, WorldSettings.MAPLENGTH / 2);
            //_gravity.Initialize(_voxelModel, new Vector3DExt(0, 1f, 0), Gravity.EGravityDirection.PosY );
            //_velocity.y = 0.1f;
        }

        public void LoadContent()
        {
            _splashSound = _game.Content.Load<SoundEffect>("Sounds\\splash");
            _bubbleSound = _game.Content.Load<SoundEffect>("Sounds\\bubbles");
            _bubbleSoundInstance = _bubbleSound.CreateInstance();
            _bubbleSoundInstance.IsLooped = true;
            _bubbleSoundInstance.Play(); _bubbleSoundInstance.Pause();
            _bubbleSoundInstance.Volume = 0.2f;
            _bubbleSoundInstance.Pitch = -1f;
        }

        Matrix _rotationMatrix;
        Vector3DExt _lookVector;
        Random r = new Random();

        public bool IsAboveSnowLine
        {
            get { return _isAboveSnowline; }
        }

        private void UpdateParticles(GameTime gameTime)
        {
            if (IsUnderWater)
            {
                _bubbleParticleSystem.SetCamera(_game.Camera.View, _game.Camera.Projection);
                _bubbleParticleSystem.Update(gameTime);
                Vector3DExt offset = new Vector3DExt((float)(r.NextDouble() - r.NextDouble()) * 5, (float)(r.NextDouble() - r.NextDouble()) * 5, (float)(r.NextDouble() - r.NextDouble()) * 5);
                _bubbleParticleSystem.AddParticle(_game.Camera.Position + offset, Vector3DExt.zero);
            }
            if (IsAboveSnowLine)
            {
                _snowParticleSystem.SetCamera(_game.Camera.View, _game.Camera.Projection);
                _snowParticleSystem.Update(gameTime);
                Vector3DExt offset = new Vector3DExt((float)(r.NextDouble() - r.NextDouble()) * 5, (float)(r.NextDouble()) * 5, (float)(r.NextDouble() - r.NextDouble()) * 5);
                _snowParticleSystem.AddParticle(_game.Camera.Position + offset, Vector3DExt.zero);
                _snowParticleSystem.AddParticle(_game.Camera.Position + offset, Vector3DExt.zero);
            }
        }

        private void UpdateSounds()
        {
            bool underWater = IsUnderWater;

            if (underWater && !_wasUnderwater)
            {
                _splashSound.Play(0.2f, 0f, 0);
                _bubbleSoundInstance.Resume();
            }
            if (!underWater && _wasUnderwater)
            {
                _splashSound.Play(0.2f, 0f, 0);
                _bubbleSoundInstance.Pause();
            }
            _wasUnderwater = underWater;
        }

        public Vector3DExt LookVector
        {
            get { return _lookVector; }
        }
*/
        public function update( gameTime:GameTime ):void
        {
            //_rotationMatrix = Matrix.CreateRotationX(Camera.UpDownRotation) * Matrix.CreateRotationY(Camera.LeftRightRotation);
            //_lookVector = Vector3DExt.Transform(Vector3DExt.Forward, _rotationMatrix);
            //_lookVector.Normalize();

            //UpdateParticles(gameTime);
            //UpdateSounds();
            //updatePosition(gameTime);

            //float headbobOffset = (float) Math.Sin(_headBob) * 0.06f;            
            //Camera.Position = _position + new Vector3DExt(0, 0.15f + headbobOffset, 0);

            checkBuild( gameTime );
        }

        public function checkBuild( gameTime:GameTime ):void
        {
			/*
            PlayerIndex controlIndex;      

            if (_game.InputState.IsButtonPressed(Buttons.RightTrigger, _game.ActivePlayerIndex, out controlIndex) ||
                _game.InputState.IsKeyPressed(Keys.Q, _game.ActivePlayerIndex, out controlIndex))
            {
                for (float x = 0.5f; x < 5f; x += 0.2f)
                {
                    Vector3DExt targetPoint = Camera.Position + (_lookVector * x);
                    BlockType blockType = _voxelModel.BlockAtPoint(targetPoint);
                    if (blockType != BlockType.None && blockType != BlockType.Water)
                    {
                        if (targetPoint.y > 2)
                        {
                            // Can't dig water or lava
                            BlockType targetType = _voxelModel.BlockAtPoint(targetPoint);
                            if (BlockInformation.IsDiggable(targetType)) {
                            _voxelModel.RemoveBlock((ushort)targetPoint.x, (ushort)targetPoint.y, (ushort)targetPoint.z);
                            }
                        }
                        break;
                    }
                }
            }
            if (_game.InputState.IsKeyPressed(Keys.V, _game.ActivePlayerIndex, out controlIndex))
            {
                for (float x = 0.5f; x < 5f; x += 0.2f)
                {
                    Vector3DExt targetPoint = Camera.Position + (_lookVector * x);
                    if (_voxelModel.BlockAtPoint(targetPoint) != BlockType.None)
                    {
                        Random r = new Random();
                        for (ushort dy = (ushort)(targetPoint.y - 3); dy < (ushort)(targetPoint.y + 3); dy++)
                        {
                            for (ushort dx = (ushort)(targetPoint.x - 3); dx < (ushort)(targetPoint.x + 3); dx++)
                            {
                                for (ushort dz = (ushort)(targetPoint.z - 3); dz < (ushort)(targetPoint.z + 3); dz++)
                                {
                                    if (r.Next(3)==0) _voxelModel.RemoveBlock(dx, dy, dz);
                                }
                            }
                        }
                        break;
                    }
                }
            }
            if (_game.InputState.IsButtonPressed(Buttons.LeftTrigger, _game.ActivePlayerIndex, out controlIndex) ||
                _game.InputState.IsKeyPressed(Keys.E, _game.ActivePlayerIndex, out controlIndex))
            {
                float hit = 0;
                for (float x = 0.8f; x < 5f; x += 0.1f)
                {
                    Vector3DExt targetPoint = Camera.Position + (_lookVector * x);
                    if (_voxelModel.BlockAtPoint(targetPoint) != BlockType.None)
                    {
                        hit = x;
                        break;
                    }                    
                }
                if (hit != 0)
                {
                    for (float x = hit; x >0.7f; x -= 0.1f)
                    {
                        Vector3DExt targetPoint = Camera.Position + (_lookVector * x);
                        if (_voxelModel.BlockAtPoint(targetPoint) == BlockType.None)
                        {
                            _voxelModel.AddBlock((ushort) targetPoint.x, (ushort) targetPoint.y, (ushort)targetPoint.z, _state.BlockPicker.SelectedBlockType);
                            break;
                        }
                    }
                }
            }
			*/
        }
/*
        public bool IsUnderWater
        {
            get
            {
                return (_voxelModel.BlockAtPoint(_game.Camera.Position) == BlockType.Water);
            }
        }


        private void UpdatePlayerVelocity(GameTime gameTime)
        {
            //// The player should float when underwater
            //if (IsUnderWater)
            //    _playerVelocity.y += WorldSettings.PLAYER_GRAVITY_WATER * (float)gameTime.ElapsedGameTime.TotalSeconds;
            //else
            //    _playerVelocity.y += WorldSettings.PLAYER_GRAVITY_LAND * (float)gameTime.ElapsedGameTime.TotalSeconds;

            if (_voxelModel.SolidAt(getFootPositionInt()))
            {
                PlayerIndex controlIndex;
                if ((_game.InputState.IsKeyDown(Keys.Space, _game.ActivePlayerIndex, out controlIndex)))
                {

                    Velocity = _gravity.GravityScale * WorldSettings.PLAYERJUMPVELOCITY;
                    // RSF Not sure what this does so I commented it out.
                    //float amountBelowSurface = ((ushort)footPosition.y) + 1 - footPosition.y;
                    //_position.y += amountBelowSurface + 0.01f;
                }
            }
            else
            {
                if ( 0 < Velocity.Length() )
                    Velocity = Velocity + (_gravity.GravityScale * WorldSettings.PLAYER_GRAVITY_LAND * (float)gameTime.ElapsedGameTime.TotalSeconds);
            }
        }

        private void StandingOnBlockLogic()
        {
            //// Logic for standing on a block.
            //switch (block)
            //{
            //    case BlockType.Jump:
            //        _velocity.y = 2.5f * WorldSettings.PLAYERJUMPVELOCITY;
            //        //PlaySoundForEveryone(InfiniminerSound.Jumpblock, playerPosition);
            //        break;

            //    case BlockType.Road:
            //        //movingOnRoad = true;
            //        break;

            //    case BlockType.Lava:
            //        //KillPlayer(Defines.deathByLava);
            //        return;
            //}
        }

        private void HeadHittingBlockLogic()
        {
            //// Logic for bumping your head on a block.
            //switch (block)
            //{
            //    case BlockType.Shock:
            //        //KillPlayer(Defines.deathByElec);
            //        return;

            //    case BlockType.Lava:
            //        //KillPlayer(Defines.deathByLava);
            //        return;
            //}
        }
*/
        private function hittingSolidBlockLogic():void
        {
            // DIDN"T CONVERT TO 3D MOVEMENT RSF
            // If we"re hitting the ground with a high velocity, die!
            //if (standingOnBlock != BlockType.None && playerVelocity.y < 0)
            //{
            //    float fallDamage = Math.abs(playerVelocity.y) / DIEVELOCITY;
            //    if (fallDamage >= 1)
            //    {
            //        PlaySoundForEveryone(InfiniminerSound.GroundHit, playerPosition);
            //        KillPlayer(Defines.deathByFall);//"WAS KILLED BY GRAVITY!");
            //        return;
            //    }
            //    else if (fallDamage > 0.5)
            //    {
            //        // Fall damage of 0.5 maps to a screenEffectCounter value of 2, meaning that the effect doesn't appear.
            //        // Fall damage of 1.0 maps to a screenEffectCounter value of 0, making the effect very strong.
            //        if (standingOnBlock != BlockType.Jump)
            //        {
            //            screenEffect = ScreenEffect.Fall;
            //            screenEffectCounter = 2 - (fallDamage - 0.5) * 4;
            //            PlaySoundForEveryone(InfiniminerSound.GroundHit, playerPosition);
            //        }
            //    }
            //}

            // DIDN"T CONVERT TO 3D MOVEMENT RSF
            //// If the player has their head stuck in a block, push them down.
            //if (_voxelModel.SolidAtPoint(headPosition))
            //{
            //    int blockIn = (int)(headPosition.y);
            //    _position.y = (float)(blockIn - 0.15f);
            //}

            // If the player is stuck in the ground, bring them out.
            // This appears to happen when we fall to ground with some velocity
            // This happens because we're standing on a block at -1.5, but stuck in it at -1.4, so -1.45 is the sweet spot.
/*            if (_voxelModel.solidAt(getFootPosition()))
            {
                var location:Vector3DExt = _voxelModel.getFirstSolidBlockBeneathYou(_gravity.gravityScale, _position);
                var solidLocation:Vector3DExt = new Vector3DExt(location.x, location.y, location.z);

                // This gets the foot position in the direction of gravity
                // and translates it to the closest block
                // TODO Not sure if this is correct - RSF
				//var blockOn:Number  = (int)(_gravity.gravityScale * solidLocation).length;
                var blockOn:Number  = solidLocation.length;
                // Not clear why the magic number 2.45 is used. RSF
                if (Gravity.POSY == _gravity.dir || Gravity.POSX == _gravity.dir || Gravity.POSZ == _gravity.dir)
                    blockOn += 2.45;
                else
                    blockOn -= 2.45;


                // Now take the other two components and add them back in
				// TODO dont like a new every frame!
                var newPosition:Vector3DExt = new Vector3DExt();
				// TODO check logic
                //newPosition = _gravity.nonGravityComponents() * position;
                newPosition = position;
				// TODO check logic
				var newScale:Vector3DExt = _gravity.gravityScale;
				newScale.scaleBy( blockOn );
                newPosition.x += Math.abs(newScale.x);
                newPosition.y += Math.abs(newScale.y);
                newPosition.z += Math.abs(newScale.z);
                position = newPosition;


                //// This gets the foot position in the direction of gravity
                //// and translates it to the closest block
                //float blockOn = (int)(_gravity.GravityScale * getFootPosition()).Length();
                //// Not clear why the magic number 2.45 is used. RSF
                //if (Gravity.EGravityDirection.PosY == _gravity.Dir || Gravity.EGravityDirection.PosX == _gravity.Dir || Gravity.EGravityDirection.PosZ == _gravity.Dir )
                //    blockOn += 2.45f;
                //else
                //    blockOn -= 2.45f;


                //// Now take the other two components and add them back in
                //Vector3DExt newPosition = new Vector3DExt();
                //newPosition = _gravity.NonGravityComponents() * Position;
                //newPosition.x += Math.abs((_gravity.GravityScale * blockOn).x);
                //newPosition.y += Math.abs((_gravity.GravityScale * blockOn).y);
                //newPosition.z += Math.abs((_gravity.GravityScale * blockOn).z);
                //Position = newPosition;
            }*/
        }


        private function updatePositionDueToMovement( gameTime:GameTime ):void
        {
			// TODO dont like a new every frame!
/*            var moveVector:Vector3DExt = new Vector3DExt();
            if (_game.InputState.IsKeyDown(Keys.W, _game.ActivePlayerIndex, out controlIndex))
            {
                moveVector += Vector3DExt.Forward * 2;
            }
            else if (_game.InputState.IsKeyDown(Keys.S, _game.ActivePlayerIndex, out controlIndex))
            {
                moveVector += Vector3DExt.Backward * 2;
            }
            else if (_game.InputState.IsKeyDown(Keys.A, _game.ActivePlayerIndex, out controlIndex))
            {
                moveVector += Vector3DExt.Left * 2;
            }
            else if (_game.InputState.IsKeyDown(Keys.D, _game.ActivePlayerIndex, out controlIndex))
            {
                moveVector += Vector3DExt.Right * 2;
            }
            if (0 < moveVector.Length())
            {
                moveVector *= WorldSettings.PLAYERMOVESPEED * (float)gameTime.ElapsedGameTime.TotalSeconds;

                // This takes the move vector and rotates it to accomodate the players(Camera's) rotation
                Vector3DExt rotatedMoveVector = new Vector3DExt();
                if ( Gravity.EGravityDirection.PosY == _gravity.Dir )
                    rotatedMoveVector = Vector3DExt.Transform(moveVector, Matrix.CreateRotationY(Camera.LeftRightRotation));
                else if ( Gravity.EGravityDirection.NegY == _gravity.Dir )
                    rotatedMoveVector = Vector3DExt.Transform(moveVector, Matrix.CreateRotationY(Camera.LeftRightRotation - 3.141f));

                else if (Gravity.EGravityDirection.PosX == _gravity.Dir)
                    rotatedMoveVector = Vector3DExt.Transform(moveVector, Matrix.CreateRotationX(Camera.LeftRightRotation));
                else if (Gravity.EGravityDirection.NegX == _gravity.Dir)
                    rotatedMoveVector = Vector3DExt.Transform(moveVector, Matrix.CreateRotationX(Camera.LeftRightRotation - 3.141f));
                else if (Gravity.EGravityDirection.PosZ == _gravity.Dir)
                    rotatedMoveVector = Vector3DExt.Transform(moveVector, Matrix.CreateRotationZ(Camera.LeftRightRotation));
                else if (Gravity.EGravityDirection.NegZ == _gravity.Dir)
                    rotatedMoveVector = Vector3DExt.Transform(moveVector, Matrix.CreateRotationZ(Camera.LeftRightRotation));


                // Attempt to move, doing collision stuff.
                // RSF why try three directions?
                if (TryToMoveTo(rotatedMoveVector))
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("UpdatePositionDueToMovement 1 - Position {0}  MoveVector {1} rotatedMoveVector {2} Gravity {3}", Position, moveVector, rotatedMoveVector, _gravity));
                }
                else if (!TryToMoveTo(new Vector3DExt(0, 0, rotatedMoveVector.z)))
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("UpdatePositionDueToMovement 2 - Position {0}  MoveVector {1} rotatedMoveVector {2} Gravity {3}", Position, moveVector, rotatedMoveVector, _gravity));
                }
                else if (!TryToMoveTo(new Vector3DExt(rotatedMoveVector.x, 0, 0)))
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("UpdatePositionDueToMovement 3 - Position {0}  MoveVector {1} rotatedMoveVector {2} Gravity {3}", Position, moveVector, rotatedMoveVector, _gravity));
                }
            }*/
        }
/*
        public function getFootPosition():Vector3DExt
        {
            return _position; // + _gravity.gravityScale * new Vector3DExt( -1.5, -1.5, -1.5);
        }

        public function getHeadPosition():Vector3DExt 
        {
            return _position; // + _gravity.GravityScale * new Vector3DExt(.1, .1, .1);
        }

        public function resetVelocity():void
        {
            _velocity.setTo( 0, 0, 0 );
        }
		*/
/*
        public function updatePosition( gameTime:GameTime ):Boolean
        {
            //CorrectForFallOffEdgeOfWorld();

            // We havent fallen off, so this position should work with adjustments
            _lastPosition = _position;

            var footPosition:Vector3DExt = getFootPosition();
            var headPosition:Vector3DExt = getHeadPosition();

            if (_voxelModel.solidAt(footPosition) || _voxelModel.solidAt(headPosition))
            {
                hittingSolidBlockLogic();

                //StandingOnBlockLogic();
                //HeadHittingBlockLogic();

                // The player is on a solid block, so their velocity is 0
                resetVelocity();
            }

            //UpdatePlayerVelocity(gameTime);

            // This is the players position adjusted for bring in a cube, and the velocity which will be applied next turn.
			_velocity.scaleBy( gameTime.elapsedGameTime() );
            _position = (Vector3DExt)(_position.add( _velocity ));

            //
            // Working on changing this to 3d ... RSF
            //

            updatePositionDueToMovement( gameTime );

            _isAboveSnowline = _voxelModel.isAboveSnowLine( position );
			
			return true;
        }
		*/
/*
        private void CorrectForFallOffEdgeOfWorld()
        {
            Vector3DExti location = _voxelModel.GetFirstSolidBlockBeneathYou(_gravity.GravityScale, _position);
            if ( -1 == location.x )
            {
                // Adjust position so that player is on the adjucent face of the cube
                // Determine angle from last position, so that we can predict which plane gravity should be on next
                Vector3DExt changeVector = _lastPosition - _position;
                _gravity.AdjustFacingAndGravity(this, changeVector);
            }
        }

        private bool TryToMoveTo(Vector3DExt moveVector)
        {
            // Build a "test vector" that is a little longer than the move vector.
            float moveLength = moveVector.Length();
            Vector3DExt testVector = moveVector;
            testVector.Normalize();
            testVector = testVector * (moveLength + 0.3f);

            // Apply this test vector.
            Vector3DExt movePosition = _position + testVector;
            Vector3DExti midBodyPoint = new Vector3DExti( movePosition + new Vector3DExt(0, -0.7f, 0) );
            Vector3DExti lowerBodyPoint = new Vector3DExti( movePosition + new Vector3DExt(0, -1.4f, 0) );

            if (!_voxelModel.SolidAt(new Vector3DExti(movePosition)) && !_voxelModel.SolidAt(lowerBodyPoint) && !_voxelModel.SolidAt(midBodyPoint))
            {
                _position = _position + moveVector;
                if (moveVector != Vector3DExt.zero)
                {
                    _headBob += 0.2;
                }
                return true;
            }

            //// It's solid there, so while we can't move we have officially collided with it.
            //BlockType lowerBlock = _voxelModel.BlockAtPoint(lowerBodyPoint);
            //BlockType midBlock = _voxelModel.BlockAtPoint(midBodyPoint);
            //BlockType upperBlock = _voxelModel.BlockAtPoint(movePosition);

            //// It's solid there, so see if it's a lava block. If so, touching it will kill us!
            //if (upperBlock == BlockType.Lava || lowerBlock == BlockType.Lava || midBlock == BlockType.Lava)
            //{
            //    KillPlayer(Defines.deathByLava);
            //    return true;
            //}

            //// If it's a ladder, move up.
            //if (upperBlock == BlockType.Ladder || lowerBlock == BlockType.Ladder || midBlock == BlockType.Ladder)
            //{
            //    playerVelocity.y = CLIMBVELOCITY;
            //    Vector3DExt footPosition = playerPosition + new Vector3DExt(0f, -1.5f, 0f);
            //    if (blockEngine.SolidAtPointForPlayer(footPosition))
            //        playerPosition.y += 0.1f;
            //    return true;
            //}

            return false;
        }

        public void Draw(GameTime gameTime)
        {
            if (IsUnderWater)
            {
                _bubbleParticleSystem.Draw(gameTime);
            }
            _snowParticleSystem.Draw(gameTime);
        }
*/
    }
}
