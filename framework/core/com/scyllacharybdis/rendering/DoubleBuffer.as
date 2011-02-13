package com.scyllacharybdis.rendering 
{
	import com.scyllacharybdis.interfaces.IDestruct;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 */
	[Singleton]
	public class DoubleBuffer implements IDestruct
	{
		private var _width:int;
		private var _height:int;
		private var _frontBuffer:BitmapData;
		private var _backBuffer:BitmapData;
		private var _origin:Point = new Point(0, 0);
		private var _canvas:DisplayObjectContainer;
		private var _surface:Sprite = new Sprite();
		
		/**
		 * Default constructor
		 * @param	canvas
		 */
		public function DoubleBuffer( canvas:DisplayObjectContainer ) 
		{
			_canvas = value;
			_width = value.stage.stageWidth;
			_height = value.stage.stageHeight;

			// Create the buffers
			_frontBuffer = new BitmapData(_width, _height);
			_backBuffer = new BitmapData(_width, _height);

			// Add the front buffer to a sprite so it can get clicks
			_canvas.addChild(_surface);
			_surface.addChild(new Bitmap(_frontBuffer));			
		}
		
		/**
		 * Default destructor
		 */
		public function destructor()
		{
		}

		/**
		 * Clear the screen
		 */
		public function clear(color:uint):void 
		{
			_backBuffer.fillRect(_backBuffer.rect, color);			
		}
		
		/**
		 * Copy the pixels to the DoubleBuffer
		 * @param	bitmapData
		 * @param	bitmapRect
		 * @param	destPoint
		 * @param	alphaBitmapData
		 * @param	alphaPoint
		 * @param	mergeAlpha
		 */
		public function copyPixels( bitmapData:BitmapData, bitmapRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false ):void
		{
			_backBuffer.copyPixels(bitmapData, bitmapRect, destPoint, alphaBitmapData, alphaPoint, mergeAlpha)
		}
		
		/**
		 * Lock the DoubleBuffer for write
		 */
		public function lock():void
		{
			_backBuffer.lock();
		}
		
		/**
		 * Swap the DoubleBuffer to the front buffer;
		 */
		public function swapBuffers():void
		{
			_frontBuffer.copyPixels(_backBuffer, _backBuffer.rect, _origin);
		}

		/**
		 * Unlock the DoubleBuffer after completing the write
		 */
		public function unlock():void
		{
			_backBuffer.unlock();
		}
		
		/**
		 * Get the draw canvas
		 */
		public function get canvas():DisplayObjectContainer { return _canvas; }
		
	}
}