package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.core.ami.AMIHandler;
	import com.scyllacharybdis.core.ami.AMITask;
	import com.scyllacharybdis.core.loaders.TextureLoaderAction;
	import com.scyllacharybdis.core.loaders.TextureResults;
	import com.scyllacharybdis.core.loaders.XMLLoaderAction;
	import com.scyllacharybdis.core.loaders.XMLResults;
	import com.scyllacharybdis.core.memory.deallocate;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.ComponentObject;
	import com.scyllacharybdis.core.objects.SpriteObject;
	import com.scyllacharybdis.core.rendering.DoubleBuffer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 
	 */
	[Component (type="RenderComponent")]
	[Requires ("com.scyllacharybdis.core.ami.AMIHandler")]
	public class TextureRenderComponent extends RenderComponent
	{
		private var _sprite:SpriteObject = new SpriteObject();
		private var _amihandler:AMIHandler;
		private var _worldRect:Rectangle = new Rectangle();
		
		/**
		 * Engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			_amihandler = getDependency(AMIHandler);
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
			deallocate( _sprite );
			deallocate( _amihandler );

			_sprite = null;
			_amihandler = null;
		}

		/**
		 * Load the texture
		 * @param	fileName (String) The texture file
		 */
		public final function loadTexture( fileName:String ):void
		{
			// Dispatch the load texture 
			_amihandler.dispatchTask( new AMITask( new TextureLoaderAction(fileName), new TextureResults(), this ) );
			
		}
		
		/**
		 * Add the renderable to the surface
		 * @param	surface (DoubleBuffer) The render surface
		 */
		public final override function render( surface:DoubleBuffer ):void
		{
			if ( ! _sprite.loaded ) 
			{
				return;
			}

			// Copy the pixels to the DoubleBuffer
			surface.copyPixels(_sprite.bitmapData, _sprite.rectangle, new Point(owner.position.x, owner.position.y), null, null, true)
		}

		/**
		 * Texture load was successfull
		 * @param	data
		 */
		public final function textureLoadSuccess( data:BitmapData ):void
		{
			_sprite.setTexture( data );
		}
		
		/**
		 * Handle the texture load failure
		 * @param	data
		 */		
		public final function textureLoadError( data:* ):void
		{
			trace( "textureLoadError: " + data );
		}
		
		public final function get amihandler():AMIHandler { return _amihandler; }
		
		/**
		 * Get the world rectangle
		 * @return
		 */
		public override function getWorldRectange():Rectangle
		{
			if ( ! _sprite.loaded ) 
			{
				return null;
			}
			_worldRect.x = owner.position.x;
			_worldRect.y = owner.position.y;
			_worldRect.width = _sprite.rectangle.width;
			_worldRect.height = _sprite.rectangle.height;
			return _worldRect;
		}		
	}
}