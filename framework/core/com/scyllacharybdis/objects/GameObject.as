package com.scyllacharybdis.objects 
{
	import com.scyllacharybdis.memory.deallocate;
	import com.scyllacharybdis.scenegraph.SceneGraph;
	import org.casalib.math.geom.Point3d;
	import org.casalib.util.ArrayUtil;
	
	/**
	 */
	[Requires ("com.scyllacharybdis.core.scenegraph.SceneGraph")]	
	public final class GameObject extends ContainerObject
	{
		
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _parent:GameObject = null;
		private var _children:Array = new Array();
		private var _enabled:Boolean = true;	
		private var _sceneGraph:SceneGraph;
		private var _started:Boolean = false;
		
		private var _position:Point3d = new Point3d();
		private var _scale:Point3d = new Point3d();
		private var _rotation:Number = 0;
	
		public function GameObject( sceneGraph:SceneGraph ):void
		{
			_sceneGraph = sceneGraph;
		}
		
		public override function destructor():void
		{
			// Destroy the children
			for each ( var gameObj:GameObject in _children )
			{
				delete _children[gameObj];
				
				deallocate( gameObj );
			}
			
			_children = null;
			_parent = null;
			
			_sceneGraph = null;
			
			super.destructor();
		}
		
		/**
		 * Get the parent game object
		 */
		public function get parent():GameObject { return _parent; }
		
		/**
		 * Set the parent game object
		 * @param gameObj (GameObject) The parent game object
		 */
		public function set parent( value:GameObject ):void { _parent = value; }
		
		/**
		 * Get the children game objects
		 */
		public function get children():Array { return _children; }
		
		/**
		 * Is the object enabled
		 */
		public function get enabled():Boolean { return _enabled; }
		
		/**
		 * Set if the object is enabled or not
		 * @param value (Boolean) Enabled
		 */
		public function set enabled( value:Boolean ):void 
		{
			_enabled = value;
		}

		/**
		 * Add a child game object.
		 * @param	child (GameObject)
		 */
		public final function addChild( child:GameObject ):void
		{
			// Attach to the tree
			child.parent = this;
			_children.push( child );
			
			if ( _started == true ) 
			{
				_sceneGraph.addGameObjectToScene( child );
			}
			
			child.enabled = _enabled;
		}

		/**
		 * Remove a child game object.
		 * @param	child (GameObject)
		 */
		public final function removeChild( child:GameObject ):void
		{
			// Stop the child before removing it
			if ( child.enabled )
			{
				child.enabled = false;
				_sceneGraph.removeGameObjectToScene( child );
			}
			
			// Remove the child from the list
			ArrayUtil.removeItem( _children, child );
		}
		

		
		/**
		 * Get the local coordinates position.
		 */
		public function get position():Point3d 
		{ 
			return _position;
		}

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
		public function set position( value:Point3d ):void 
		{ 
			_position = value; 
		}
		
		/**
		 * Get the renderobjects local coordinates scale.
		 */
		public function get scale():Point3d 
		{ 
			return _scale;
		}

		/**
		 * Set the renderobjects local coordinates scale.
		 */
		public function set scale( value:Point3d ):void 
		{ 
			_scale = value; 
		}
		
		/**
		 * Get the local coordinates rotation
		 */		
		public function get rotation():Number 
		{ 
			return _rotation;
		}
		
		/**
		 * Set the local coordinates rotation
		 */
		public function set rotation( value:Number):void 
		{ 
			_rotation = value; 
		}
	}
}