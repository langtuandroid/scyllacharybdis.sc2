package com.scyllacharybdis.rendering 
{
	import com.scyllacharybdis.interfaces.IDestruct;
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	/**
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.rendering.DoubleBuffer")]
	public class Window implements IDestruct
	{
		private var _canvas:DisplayObjectContainer;
		private var _doubleBuffer:DoubleBuffer;
		private var _clickHander:SceneGraph;
		
		/**
		 * The default constructor
		 * @param	window
		 */
		public function Window( doubleBuffer:DoubleBuffer, canvas:DisplayObjectContainer ):void
		{
			_doubleBuffer = doubleBuffer;
			_canvas = canvas;
			addListeners();
		}
		
		/**
		 * Default destructor
		 */
		public function destructor()
		{
			_doubleBuffer = null;
		}		
		
		/**
		 * Get the display context
		 */
		public function get canvas():DisplayObjectContainer { return _canvas; }
		
		/**
		 * Set the display context
		 */
		public function set canvas(value:DisplayObjectContainer):void 
		{
			_canvas = value;
			_doubleBuffer.canvas = value;
			addListeners();
		}
		
		/**
		 * Get the rendering surface
		 */
		public function get surface():DoubleBuffer { return _doubleBuffer; }
		
		/**
		 * Set the rendering surface
		 */
		public function set surface(value:DoubleBuffer):void 
		{
			_doubleBuffer = value;
		}
	
		/**
		 * Get the screen width
		 * @return (int) Screen width in pixels
		 */
		public function getScreenWidth():int
		{
			return _canvas.stage.width;
		}
		
		/**
		 * Get the screen height
		 * @return (int) Screen height in pixels
		 */
		public function getScreenHeight():int
		{
			return _canvas.stage.height;
		}
		
		/**
		 * Begin the rendering phase
		 * Lock the back buffer for rendering
		 */
		public function beginRendering():void 
		{
			_doubleBuffer.lock();
		}
		
		/**
		 * End the rendering phase
		 * Unlocks the back buffer and swaps the double buffer
		 */
		public function endRendering():void 
		{
			_doubleBuffer.swapBuffers();
			_doubleBuffer.unlock();
		}

		/**
		 * Set the click handler ( SceneGraph );
		 */
		public function set clickHandler( value:SceneGraph ):void 
		{
			_clickHander = value;
		}
		
		/**
		 * Add all the listeners to this object
		 */
		private final function addListeners():void
		{
			if ( _canvas == null ) 
			{
				return;
			}
			_canvas.addEventListener( MouseEvent.CLICK, onClick, false, 0, true);
			_canvas.addEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick, false, 0, true );
			_canvas.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
			_canvas.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true );
			_canvas.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
			_canvas.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
			_canvas.addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0, true );
			_canvas.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel, false, 0, true );
			_canvas.addEventListener( MouseEvent.ROLL_OUT, onRollOut, false, 0, true );
			_canvas.addEventListener( MouseEvent.ROLL_OVER, onRollOver, false, 0, true );
			_canvas.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true );
			_canvas.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
		}

		/**
		 * Remove all the listeners from the movie clip
		 */
		private final function removeListeners():void
		{
			if ( _canvas == null ) 
			{
				return;
			}
			_canvas.removeEventListener( MouseEvent.CLICK, onClick );
			_canvas.removeEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
			_canvas.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			_canvas.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_canvas.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			_canvas.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			_canvas.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			_canvas.removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			_canvas.removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			_canvas.removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_canvas.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_canvas.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onClick(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onClick(e);
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onDoubleClick(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onDoubleClick(e);
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseDown(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onMouseDown(e);
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseMove(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onMouseMove(e);
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseOut(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onMouseOut(e);
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseOver(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onMouseOver(e);
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseUp(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onMouseUp(e);
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseWheel(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onMouseWheel(e);
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onRollOver(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onRollOver(e);
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onRollOut(e:MouseEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onRollOut(e);
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onKeyDown(e:KeyboardEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onKeyDown(e);
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onKeyUp(e:KeyboardEvent):void 
		{
			if ( _clickHander == null ) 
			{
				return;
			}
			_clickHander.onKeyUp(e);
		}
		

	}
}