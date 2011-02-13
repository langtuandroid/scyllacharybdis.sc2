package com.scyllacharybdis.ami 
{
	/**
	 * ...
	 * @author 
	 */
	public class AMIResults 
	{
		private var _task:AMITask;
		
		/**
		 * Override to implement task success
		 * @param	data
		 */
		public function success(data:*):void
		{
		}
		
		/**
		 * Override to implement task failed
		 * @param	data
		 */
		public function failed(data:*):void
		{
		}		

		/**
		 * Get the parent task
		 */
		public final function get task():AMITask { return _task; }

		/**
		 * Set the parent task
		 */
		public final function set task(task:AMITask):void 
		{
			_task = task;
		}
	}
}