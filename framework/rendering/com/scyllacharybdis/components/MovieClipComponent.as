package com.scyllacharybdis.components
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.rendering.DoubleBuffer;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * 
	 */
	[Component (type="RenderComponent")]
	public class MovieClipComponent extends RenderComponent
	{
		private var _baseclip:MovieClip  = new MovieClip();
		private var _worldRect:Rectangle = new Rectangle();

		/** 
		 * Engine constructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
	
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start(): void 
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
		 * Get the movie clip
		 */
		public final function get baseclip():MovieClip { return _baseclip; }

		/**
		 * Set the movie clip
		 */
		public final function set baseclip( value:MovieClip ):void { _baseclip = value; }
		
		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public final override function render( surface:DoubleBuffer ):void
		{
			// Create a new bitmap
			var bitmapData:BitmapData = new BitmapData(_baseclip.width, _baseclip.height, true, 0x000000FF);
			
			// Draw the baseclip to the bitmap
			bitmapData.draw(_baseclip);
			
			// Copy the pixels to the DoubleBuffer
			surface.copyPixels(bitmapData, bitmapData.rect, new Point(owner.position.x, owner.position.y), null, null, true);
		}
		
		/**
		 * Get the world rectangle
		 * @return
		 */
		public override function getWorldRectange():Rectangle
		{
			_worldRect.x = owner.position.x;
			_worldRect.y = owner.position.y;
			_worldRect.width = _baseclip.width;
			_worldRect.height = _baseclip.height;
			return _worldRect;
		}		
	}
}