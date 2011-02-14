package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.core.ami.AMIHandler;
	import com.scyllacharybdis.core.ami.AMITask;
	import com.scyllacharybdis.core.loaders.TextureLoaderAction;
	import com.scyllacharybdis.core.loaders.TextureResults;
	import com.scyllacharybdis.core.loaders.XMLLoaderAction;
	import com.scyllacharybdis.core.loaders.XMLResults;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.SpriteObject;
	import com.scyllacharybdis.core.rendering.DoubleBuffer;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 
	 */
	[Component (type="RenderComponent")]
	public class XMLRenderComponent extends TextureRenderComponent
	{
		private var _area:String;
		private var _sprite:SpriteObject = new SpriteObject();

		/**
		 * Load the material
		 * @param	fileName (String) The definision file
		 * @param	area (String) The area to load
		 */
		public final function loadMaterial( fileName:String, area:String ):void
		{
			// Store the area
			_area = area;
			
			// Create the ami task to load the def
			amihandler.dispatchTask( new AMITask( new XMLLoaderAction(fileName), new XMLResults(), this ) );
			
		}
		
		/**
		 * Parse the results from the load action
		 * @param	data
		 */
		public final function xmlLoadSuccess( data:XML ):void
		{
			// Get the texture name
			parseTexture( data.material.texture );
			
			// Get the area definitions
			parseAreas( data.material.areas );			
		}
		
		/**
		 * Handle the xml load failure
		 * @param	data
		 */
		public final function xmlLoadError( data:* ):void
		{
			trace( "xmlLoadError: " + data );
		}
		
		/**
		 * Parse the texture information and load the file
		 * @param	doc
		 */
		private final function parseTexture(texture:XMLList):void
		{
			// Get the texture name
			var textureName:String = texture.attribute("filename");
			if ( textureName != null )
			{
				loadTexture( textureName );
			}			
		}
		
		/**
		 * Parse the areas
		 * @param	areas
		 */
		private final function parseAreas(areas:XMLList):void 
		{
			for each ( var area:XML in areas..area ) 
			{
				// Get the area name
				var name:String = area.attribute("name");
				
				// Is this the right definition
				if ( name == _area ) 
				{
					// Get the attributes
					var top:int= area.attribute("top");
					var left:int = area.attribute("left");
					var width:int = area.attribute("width");
					var height:int = area.attribute("height");
					
					// Store the dimensions of the sprite
					_sprite.setDimensions(top, left, width, height);
					
					// Parse the animations
					parseAnimations(areas..animations);
				}
			}
		}

		/**
		 * Parse the animations
		 * @param	animations
		 */
		private final function parseAnimations(animations:XMLList):void 
		{
			for each ( var animation:XML in animations..animation ) 
			{
				// Get the attributes
				var name:int= animation.attribute("name");
				var frames:int= animation.attribute("frames");
				var rows:int= animation.attribute("rows");
				var cols:int= animation.attribute("cols");
				var width:int= animation.attribute("width");
				var height:int= animation.attribute("height");
				var background:int = animation.attribute("background");
				
				// Add the animation to the sprite
				_sprite.addAnimation( name, frames, rows, cols, width, height, background );
			}
		}	
	}
}