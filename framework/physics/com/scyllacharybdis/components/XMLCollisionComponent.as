package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.core.ami.AMIHandler;
	import com.scyllacharybdis.core.ami.AMITask;
	import com.scyllacharybdis.core.loaders.XMLLoaderAction;
	import com.scyllacharybdis.core.loaders.XMLResults;
	
	/**
	 * ...
	 * @author 
	 */
	[Component (type="CollisionComponent")]
	public class XMLCollisionComponent extends CollisionComponent
	{
		private var _bodyName:String;
		
		/**
		 * Load the physics information from an xml file
		 * @param	fileName (String) Filename of the xml file
		 * @param	bodyName (String) The body name that you are trying to load from the file
		 */
		public final function loadPhysics( fileName:String, bodyName:String):void
		{
			// Store the body name
			_bodyName = bodyName;
			
			// Dispatch the xml loader task
			amihandler.dispatchTask( new AMITask( new XMLLoaderAction(fileName), new XMLResults(), this ) );
			
		}
		
		/**
		 * Parse the results from the load action
		 * @param	data
		 */
		public final function xmlLoadSuccess( data:XML ):void
		{
			parseBodies( data.physics.bodies );
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
		 * Parse the physics bodies 
		 * @param	bodies
		 */
		private final function parseBodies(bodies:XMLList):void 
		{
			for each ( var body:XML in bodies..body )
			{
				var name:String = body.attribute("name");
				if ( name == _bodyName ) 
				{
					// Get the attributes
					var width:int = body.attribute("width");
					var height:int = body.attribute("height");
					var dynamtic:Boolean = body.attribute("dynamtic");
					
					// Create the physics body
					createBody( width, height, dynamtic );

					// Parse the shapes
					parseShapes( body..shapes );
				}
			}
		}
		
		/**
		 * Parse physics shapes from xml
		 * @param	shapes
		 */
		private final function parseShapes(shapes:XMLList):void 
		{
			for each ( var shape:XML in shapes..shape ) 
			{
				// Get the global attributes
				var friction:Number = shape.attribute("friction");
				var density:Number = shape.attribute("density");
				var restitution:Number = shape.attribute("restitution");
				
				if ( shape.attribute("type") == "circle" ) 
				{
					// Get the circle attributes
					var x:int = shape.attribute("x");
					var y:int = shape.attribute("y");
					var radius:int = shape.attribute("radius");
					
					// Create the physics circle shape
					createCircleShape(radius, friction, density, restitution);
				} 
				else if ( shape.attribute("type") == "polygon" ) 
				{
					// Get the polygon attributes
					var top:int = shape.attribute("top");
					var left:int = shape.attribute("left");
					var width:int = shape.attribute("width");
					var height:int = shape.attribute("height");
					
					// Create the physics polygon shape
					createPolygonShape( width, height, friction, density, restitution);
				}
				else
				{
					trace("Shape has to be a polygon or circle: " + shape.attributes() );
				}
			}
		}
	}
}