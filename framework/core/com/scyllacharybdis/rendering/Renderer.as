package com.scyllacharybdis.rendering 
{
	import com.scyllacharybdis.interfaces.IDestruct;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	/**
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.rendering.Window")]
	public final class Renderer implements IDestruct
	{
		private var _window:Window = null;
		private var _dirty:Boolean = true;
		
		/**
		 * The default constructor
		 * @param	window
		 */
		public function Renderer( window:Window ):void
		{
			_window = window;
		}
		
		/**
		 * Default destructor
		 */
		public function destructor()
		{
			_window = null;
		}		
		
		/**
		 * Render the frame
		 */
		public final function render(renderables:Array):void
		{
			// Sort the renderables array (bigger numbers are closer to the screen) 
			renderables.sortOn( "comparator", Array.NUMERIC );
			
			_window.beginRendering();
			_window.surface.clear(0x000000FF);
			
			// Render children in order
			for ( var i:int = 0; i < renderables.length; i++ )
			{
				renderables[i].render(_window.surface);
			}
			
			_window.endRendering();
		}
		
		/**
		 * Get the window used by the renderer
		 */
		public function get window():Window
		{
			return _window;
		}
	}
}