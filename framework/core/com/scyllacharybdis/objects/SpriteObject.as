package com.scyllacharybdis.objects 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class SpriteObject  implements IDestruct
	{
		private var _loaded:Boolean = false;
		private var _bitmapData:BitmapData;
		private var _rectangle:Rectangle;
		private var _playing:String = null;
		private var _animated:Boolean;
		private var _animations:Dictionary = new Dictionary(true);
		
		/**
		 * Is the sprite loaded
		 */
		public function get loaded():Boolean { return _loaded; }
		
		/**
		 * Get the bitmap data
		 */
		public function get bitmapData():BitmapData { return _bitmapData; }
	
		/**
		 * Get the rectangle
		 */
		public function get rectangle():Rectangle 
		{ 
			if ( ! _animated ) 
			{
				return _rectangle;
			}
			
			if ( _playing )
			{
				return _animations[ _playing ]["rectangle"];
			}
			
			return null; 
		}
		
		public function playAnimation(animationName:String):void
		{
			if ( _animations[animationName] == null ) 
			{ 
				stop();
				return;
			}
			_playing = animationName; 
		}
		
		public function stopAnimation():void
		{
			_playing = null;
		}

		/**
		 * Loader function to get the texture data
		 * @param	textureData
		 */
		public function setTexture(textureData:BitmapData):void 
		{
			// Has the rectangle been setup
			if ( _rectangle == null )
			{
				// Set the rectangle to the full texture
				setDimensions(textureData.rect.top, textureData.rect.left, textureData.rect.width, textureData.rect.height);
			}
			
			// Create the bitmap
			_bitmapData = new BitmapData(_rectangle.width, _rectangle.height, true, 0xFFFFFFFF);
			
			// copy the texture information
			_bitmapData.copyPixels(textureData, _rectangle, new Point(_rectangle.x, _rectangle.y), null, null, false);
			
			// Set the sprite to loaded
			_loaded = true;
		}
		
		/**
		 * Loader function to get the dimensions
		 * @param	top
		 * @param	left
		 * @param	width
		 * @param	height
		 */
		public function setDimensions(top:int, left:int, width:int, height:int):void 
		{
			// Create the full rectangle
			_rectangle = new Rectangle(top, left, width, height );
		}
		
		/**
		 * Loader function to get the animations
		 * @param	name
		 * @param	frames
		 * @param	rows
		 * @param	cols
		 * @param	width
		 * @param	height
		 * @param	background
		 */
		public function addAnimation(name:int, frames:int, rows:int, cols:int, width:int, height:int, background:int):void 
		{
			_animations[name] = new Dictionary(true);
			_animations[name]["frames"] = frames;
			_animations[name]["rows"] = rows;
			_animations[name]["cols"] = cols;
			_animations[name]["rectangle"] = new Rectangle(0, 0, width, height);
			_animations[name]["background"] = background;
		}
	}

}