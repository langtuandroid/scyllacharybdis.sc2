package com.scyllacharybdis.di
{
	import com.scyllacharybdis.di.Injector;
	import flash.utils.Dictionary;
	import org.as3commons.lang.ClassUtils;
	
	/**
	 * Abstract Module is a baseclass for configuring the injector.
	 * Override the configure to define bindings. 
	 * @author 
	 */
	public class AbstractModule 
	{
		// A list of all mappings
		private var _binding:Dictionary = new Dictionary();
		
		/**
		 * Configure the class bindings.
		 */
		public function configure():void
		{
		}

		/**
		 * Bind a requested class to a implemenation class.
		 * @param	from (Class) The requested class.
		 * @param	to (Class) The used class.
		 */
		protected final function bind( from:Class, to:Class ):void
		{
			var fromString:String = ClassUtils.getFullyQualifiedName( from, true );
			var toString:String = ClassUtils.getFullyQualifiedName(  to, true );
			_binding[fromString] = toString;
		}

		/**
		 * Returns the list of bindings to the injector.
		 * @private
		 */
		public final function getBindings():Dictionary
		{
			return _binding;
		}
		
	}
}