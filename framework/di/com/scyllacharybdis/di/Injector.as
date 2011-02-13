package com.scyllacharybdis.di
{
	import com.scyllacharybdis.di.AbstractModule;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.utils.Dictionary;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.bytecode.reflect.ByteCodeTypeCache;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.reflect.MetaData;
	import org.as3commons.reflect.MetaDataArgument;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.TypeCache;

	/**
	 * Dependency Injector
	 */
	public class Injector 
	{
		private static var _classNames:Dictionary = new Dictionary(true);
		private static var _singletonNames:Dictionary = new Dictionary(true);
		private static var _componentNames:Dictionary = new Dictionary(true);
		private static var _initialized:Boolean = false;

		private var _displayObject:DisplayObjectContainer;
		private var _module:AbstractModule;
		
		/**
		 * Injector constructor
		 * @param module (AbstractModule) The configuration for the injector.
		 * @param displayObject (DisplayObjectContainer) The main display object.
		 */
		public function Injector(module:AbstractModule, displayObject:DisplayObjectContainer) 
		{
			// Store the parameters
			_displayObject = displayObject;
			_module = module;
			
			// Scan the classes and metadata
			scanClasses( _displayObject.loaderInfo );
			
			// Configure the injector
			_module.configure();
		}
		
		/**
		 * Get an instance of an object
		 * @param	type (Class) The class to create
		 * @return (*) The newly created class
		 */
		public function getInstance( classType:Class ):*
		{
			// Get the configuration bindings
			var bindings:Dictionary = _module.getBindings();

			// Get the fully qalified name
			var classString:String = ClassUtils.getFullyQualifiedName( classType, true );
			//trace( "Before: " + classString );
			
			// Check to see if this class has been mapped
			if ( bindings[classString] != null ) 
			{
				// Replace the name with the minded one
				classString =  bindings[classString];
			}
			
			//trace( "After: " + classString );
			
			// Get the whole cache
			var typeCache:TypeCache = ByteCodeType.getTypeProvider().getTypeCache();
			
			// Get the cache for the class
			var type:ByteCodeType = typeCache.get( classString ) as ByteCodeType; 
			
			// Setup a dependency array
			var depArray:Array = new Array();

			// Get the parameters
			var paramArray:Array = type.constructor.parameters;

			// Loop threw all the parameters
			for each(var param:Parameter in paramArray)
			{
				// Get the parameter class
				var paramType:Class = param.type.clazz;
				
				// Convert the class to a string
				var paramString:String  = ClassUtils.getFullyQualifiedName( paramType, true );
				
				// Create the dependency and store it to be injected later
				depArray.push( getInstance( paramType ) );
			}
			// Create the new instances with deps and return it.
			return ClassUtils.newInstance( ClassUtils.forName(classString), depArray );
		}
		
		/**
		 * Scan all the classes and cache the results
		 * @private
		 * @param	loaderInfo (LoaderInfo) The root of the class
		 */
		private function scanClasses(loaderInfo:LoaderInfo):void
		{
			// Check to make sure its not already initialized
			if ( _initialized == true )
			{
				// Leave the method
				return;
			}
			
			// Store the state
			_initialized = true;
			
			// Load the bytecode
			ByteCodeType.fromLoader(loaderInfo);
			
			// Get the cache
			var typeCache:TypeCache = ByteCodeType.getTypeProvider().getTypeCache();
			
			// Loop threw all the classes
			for each (var key:String in typeCache.getKeys() ) 
			{
				// Split the package names on dot
				var packageNameArray:Array = key.split(".");
				
				// Skip the extra classes
				if ( packageNameArray[1] == "as3commons" || packageNameArray[0] == "Main" || packageNameArray[0] == "avmplus" ) 
				{
					continue;
				}				
				
				// Store the class names
				_classNames[key] = key;

				// Get the cache
				var type:ByteCodeType = typeCache.get(key) as ByteCodeType; 

				// Get the singleton data
				var singletonArray:Array = type.getMetaData("Singleton");
				
				// Check to see if there is any singleton metadata
				if ( singletonArray != null ) 
				{
					// Store the key 
					_singletonNames[key] = null;
				}
				
				// Get the component data
				var componentArray:Array = type.getMetaData("Component");
				
				// Loop threw all the metadata
				for each(var metadata:MetaData in componentArray)
				{
					// Get the arguments
					var arg:MetaDataArgument = metadata.getArgument("type");
					
					// Store them in an hashmap
					_componentNames[key] = arg.value;
				}
			}			
		}
	}
}