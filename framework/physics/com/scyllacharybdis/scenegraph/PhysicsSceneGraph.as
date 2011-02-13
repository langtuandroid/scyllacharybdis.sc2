package com.scyllacharybdis.scenegraph 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.events.TimerEvent;

	/**
	 * ...
	 * @author ...
	 */
	[Singleton]
	public class PhysicsSceneGraph extends SceneGraph implements IDestruct
	{
		private var _world:b2World;
		private var _contactListener:PhysicsContactListener;
		
		// map pixels to meters ( 30 pixels = 1 meter );
		private var _drawScale:int = 30;
		
		private var _velocityIterations:int = 10;
		private var _positionIterations:int = 10;
		
		/**
		 * The default constructor
		 * @param	renderer
		 */
		public function PhysicsSceneGraph( renderer:Renderer, contactListener:PhysicsContactListener )
		{
			// Call the parent constructor
			super( renderer );
			
			// Store the contact listener
			_contactListener = contactListener;

			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Construct a world object
			_world = new b2World(gravity, doSleep);
			
			// Set the contact listener for the world
			_world.SetContactListener(_contactListener);	
		}
		
		/**
		 * Default destructor
		 */
		public function destructor()
		{
			_contactListener = null;
			_world = null;
		}	


		/**
		 * Update the physics model
		 * @param	event
		 * @private
		 */
		public final function update(event:TimerEvent):void
		{
			// Update the physics world
			_world.Step( 1 / 30, _velocityIterations, _positionIterations );
			
			// Update all the game object positions
			for (var bb:b2Body = _world.GetBodyList(); bb; bb = bb.GetNext())
			{
				if (bb.GetUserData() is GameObject)
				{
					gameObj = bb.GetUserData() as GameObject;
					if ( gameObj == null ) {
						continue;
					}
					gameObj.position = new Point3d( bb.GetPosition().x * drawScale, bb.GetPosition().y * drawScale, gameObj.position.z );
					gameObj.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}
			
			// Update the parent
			super.update();
		}
		
		/**
		 * Get the world 
		 */
		public function get world():b2World { return _world; }
		
		/**
		 * Get the draw scale that maps pixels to meters.
		 */
		public function get drawScale():int { return _drawScale; }

		/**
		 * Set the draw scale that maps pixels to meters.
		 * @param scale (int) The number of pixels to make up a meter. Default = 30
		 */
		public function set drawScale(value:int):void 
		{
			_drawScale = value;
		}
		
		/**
		 * Set the world gravity
		 * @param gravity (beVec2) The gravity in a vector
		 */
		public function set gravity(value:b2Vec2):void 
		{
			_world.SetGravity(value);
		}

		/**
		 * Get Number of iterations before its finished trying to solve a collision
		 */
		public function get velocityIterations():int { return _velocityIterations; }
		
		/**
		 * Set Number of iterations before its finished trying to solve a collision
		 * The recommended number is 10
		 */
		public function set velocityIterations(value:int):void 
		{
			_velocityIterations = value;
		}
		
		/**
		 * Get Number of iterations before its finished trying to solve a collision
		 */
		public function get positionIterations():int { return _positionIterations; }
		
		/**
		 * Set Number of iterations before its finished trying to solve a collision
		 * The recommended number is 10
		 */
		public function set positionIterations(value:int):void 
		{
			_positionIterations = value;
		}		
	}
}