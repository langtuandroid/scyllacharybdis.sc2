package com.scyllacharybdis.loaders 
{
	import com.scyllacharybdis.core.ami.AMIResults;

	/**
	 * ...
	 * @author 
	 */
	public class TextureResults extends AMIResults
	{
		/**
		 * Override to implement task success
		 * @param	data
		 */
		public override function success(data:*):void
		{
			task.invoker.textureLoadSuccess( data );
		}
		
		/**
		 * Override to implement task failed
		 * @param	data
		 */
		public override function failed(data:*):void
		{
			task.invoker.textureLoadError( data );
		}			
	}

}