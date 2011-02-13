package com.scyllacharybdis.memory 
{
	import com.scyllacharybdis.interfaces.IStartStop;
	import com.scyllacharybdis.interfaces.IDestruct;

	/**
	 * ...
	 * @author 
	 */
	public function deallocate( obj:Object ):void
	{
		// Stop the object if it can be
		if ( obj is IStartStop ) 
		{
			obj.stop();
		}
		
		// Destroy the object if it can be
		if ( obj is IDestruct ) 
		{
			obj.destrutor();
		}
		
	}
}