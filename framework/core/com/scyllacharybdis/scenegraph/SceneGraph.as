package com.scyllacharybdis.scenegraph 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.GameObject;
	import com.scyllacharybdis.core.physics.PhysicsContactListener;
	import com.scyllacharybdis.core.rendering.Renderer;
	import com.scyllacharybdis.interfaces.IDestruct;
	import com.scyllacharybdis.rendering.Renderer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.casalib.math.geom.Point3d;

	/**
	 * ...
	 * @author ...
	 */
	[Singleton]
	public class SceneGraph implements IDestruct
	{
		private var _updateTimer:Timer = new Timer(1/30 * 1000, 0); 
		private var _gameObjects:Dictionary = new Dictionary(true);
		private var _renderer:Renderer;
		
		/**
		 * The default constructor
		 * @param	renderer
		 */
		public function SceneGraph( renderer:Renderer )
		{
			// Store the renderer
			_renderer = renderer;
			
			// Set this to be the click handler
			_renderer.window.clickHandler = this;
			
			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, update);
			_updateTimer.start();
			
		}
		
		/**
		 * Default destructor
		 */
		public function destructor()
		{
			_renderer = null;
			
			_updateTimer.stop();
			_updateTimer.removeEventListener(TimerEvent.TIMER, update);
			
		}				
		
		/**
		 * Update the graph
		 * @param	event
		 * @private
		 */
		public function update(event:TimerEvent):void
		{
			// Create a render qute
			var renderables:Array = new Array();
			
			// Loop threw all the game objects
			for each ( var gameObj:GameObject in _gameObjects )
			{
				// Check to make sure its enabled
				if ( gameObj.enabled == true )
				{
					// Update the components
					gameObj.update(event);
					
					// Get the render component
					var renderable:RenderComponent = gameObj.getComponent(RenderComponent) as RenderComponent;
					if ( renderable != null )
					{
						// Add to the render stack
						renderables.push(renderable);
					}
				}				
			}

			// Render everything
			_renderer.render( renderables );
		}
		
		/**
		 * Add the game object and its children to the scene
		 */
		public final function addGameObjectToScene(gameObj:GameObject):void
		{
			if ( gameObj == null )
			{
				return;
			}
			gameObj.engine_start();
			addGameObject(gameObj);
			addChildrenToScene(gameObj);
		}
		
		/**
		 * Remove the game objects and its children from the scene
		 */
		public final function removeGameObjectToScene(gameObj:GameObject):void
		{
			if ( gameObj == null )
			{
				return;
			}
			gameObj.engine_stop();
			removeChildrenFromScene(gameObj);
			removeGameObject(gameObj);
		}
		
		/**
		 * Add all its children to the scene
		 * @param	gameObj
		 */
		private final function addChildrenToScene(gameObj:GameObject):void
		{
			for each ( var child:GameObject in gameObj.children )
			{
				addGameObjectToScene(child);
			}			
		}

		/**
		 * Remove all its children from the scene
		 * @param	gameObj
		 */
		private final function removeChildrenFromScene(gameObj:GameObject):void
		{
			for each ( var child:GameObject in gameObj.children )
			{
				removeGameObjectToScene(child);
			}				
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onClick(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onClick(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onDoubleClick(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onDoubleClick(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseDown(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseMove(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseMove(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseOut(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseOut(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseOver(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseOver(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseUp(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseUp(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseWheel(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseWheel(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onRollOver(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onRollOver(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onRollOut(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onRollOut(e);
				}
			}
		}		
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onKeyDown(e:KeyboardEvent):void 
		{
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onKeyUp(e:KeyboardEvent):void 
		{
		}
		
		/**
		 * Add a gameobject to the scene
		 * @param	gameObj
		 */
		private final function addGameObject( gameObj:GameObject ):void 
		{
			_gameObjects[gameObj] = gameObj;
		}

		/**
		 * Remove a game object from the scene
		 * @param	gameObj
		 */
		private final function removeGameObject( gameObj:GameObject ):void
		{
			delete _gameObjects[gameObj];
		}		
		
		/**
		 * Get game objects helper function
		 * @param	x
		 * @param	y
		 * @return
		 * @private
		 */
		private function getObjectsAt(x:Number, y:Number):Array 
		{
			var list:Array = new Array();
			for each ( var gameObj:GameObject in _gameObjects )
			{
				var renderComponent:RenderComponent = gameObj.getComponent(RenderComponent);
				if ( renderComponent != null )
				{
					var rect:Rectangle = renderComponent.getWorldRectange();
					if ( rect != null )
					{
						if ( rect.contains( x, y ) ) 
						{
							list.push( gameObj );
						}
					}
				}
			}
			return list;
		}
	}
}