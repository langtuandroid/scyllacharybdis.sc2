package com.scyllacharybdis.components 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import com.scyllacharybdis.core.ami.AMIHandler;
	import com.scyllacharybdis.core.memory.deallocate;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.ComponentObject;
	import com.scyllacharybdis.core.scenegraph.SceneGraph;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	/**
	 */
	[Component (type="CollisionComponent")]
	[Requires ("com.scyllacharybdis.core.scenegraph.SceneGraph", "com.scyllacharybdis.core.ami.AMIHandler")]
	public class CollisionComponent extends ComponentObject
	{
		private var _body:b2Body;
		private var _physicsWorld:SceneGraph;
		private var _amihandler:AMIHandler;
		
		/** 
		 * Engine constructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			_physicsWorld = getDependency(SceneGraph);
			_amihandler = getDependency(AMIHandler);
			super.engine_awake();
		}
		
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/** 
		 * Engine stop
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		/** 
		 * Engine destructor
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
			deallocate( _amihandler );
			deallocate( _physicsWorld );
		}

		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}
		
		/**
		 * Create the body of the object. The body is the whole object.
		 * @param	x (int) width in pixels
		 * @param	y (int) height in pixels
		 * @param dynamtic (Boolean) Is the object dynamtic
		 */
		public function createBody(width:int, height:int, dynamtic:Boolean):void
		{
			// Create the body definition
			var bodyDef:b2BodyDef = new b2BodyDef();
			
			if ( dynamtic == true ) 
			{
				// Set the object to be dynamic
				bodyDef.type = b2Body.b2_dynamicBody;
			}	
			
			// Get the world scale
			var scale:int = _physicsWorld.drawScale;

			//Set its position in the world. 
			bodyDef.position.Set(width / scale, height / scale);
			
			// Add the gameobject to it
			bodyDef.userData = owner;

			// Create the body
			_body = _physicsWorld.world.CreateBody(bodyDef);

			// Add the game object to it.
			_body.SetUserData( owner );
		}
		
		/**
		 * Create a polygon shape to represent all or part of the body
		 * @param	width (int) Width in pixels
		 * @param	height (int) Height in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( set to 0 for static items )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */
		public function createPolygonShape(width:int, height:int, friction:Number = 0.3, density:Number = 0, restitution:Number = 0.1):void
		{
			// Get the draw scale
			var scale:int = _physicsWorld.drawScale;

			// Create the shape
			var boxShape:b2PolygonShape = new b2PolygonShape();
			
			// Set as a box
			boxShape.SetAsBox(width / scale, height / scale);
			
			// Create the fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;

			// Add the game object to it
			fixtureDef.userData = owner;

			// Attach to the body
			_body.CreateFixture(fixtureDef);	
		}
		
		/**
		 * Create a circle shape to represent all or part of the body
		 * @param	radius (int) Radius of the circle in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( water is around 1, less for wood, greater for metals )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */		
		public function createCircleShape( radius:int, friction:Number = 0.3, density:Number = 1, restitution:Number = 0.1 ):void
		{
			// Get the draw scale
			var scale:int = _physicsWorld.drawScale;
			
			// Create the shape
			var circleShape:b2CircleShape = new b2CircleShape(radius / scale);
			
			// Create the fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;
			
			// Add the game object to it
			fixtureDef.userData = owner;

			// Attach to the body
			_body.CreateFixture(fixtureDef);
			
		}
		
		/**
		 * Get the ami handler
		 */
		public function get amihandler():AMIHandler { return _amihandler; }
	}
}