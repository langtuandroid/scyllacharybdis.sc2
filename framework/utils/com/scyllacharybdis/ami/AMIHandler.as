package com.scyllacharybdis.ami 
{
	import com.scyllacharybdis.core.events.EventHandler;
	import com.scyllacharybdis.core.objects.BaseObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.events.EventHandler")]
	public final class AMIHandler extends BaseObject
	{
		private var _taskList:Dictionary = new Dictionary( true );
		private var _eventHander:EventHandler;
		
		public final override function engine_awake():void
		{
			_eventHander = getDependency(EventHandler);
			
			_eventHander.addEventListener("AMI_SUCCESS", this, success );
			_eventHander.addEventListener("AMI_FAILED", this, failed );

			super.engine_awake();
		}
		
		public final override function engine_destroy():void 
		{
			super.engine_destroy();

			_eventHander.removeEventListener("AMI_SUCCESS", this, success );
			_eventHander.removeEventListener("AMI_FAILED", this, failed );
		}
		
		/**
		 * Dispatch a task
		 * @param	task
		 */
		public final function dispatchTask( task:AMITask ):void
		{
			// Set the event handler
			task.action.eventHandler = _eventHander;
			
			if ( ! (task.action is AMIUniqueAction) ) 
			{
					// Execute the action
					task.execute();
					
					// Early out
					return;
			}
			
			var uniqueTask:AMIUniqueAction = task.action as AMIUniqueAction;
			
			// Make sure the dictionary is created
			if ( _taskList[uniqueTask] == null ) 
			{
				_taskList[uniqueTask] = new Dictionary(true);
			}
			
			if ( _taskList[uniqueTask][uniqueTask.key] == null )
			{
				_taskList[uniqueTask][uniqueTask.key] = new Array();
			}
			
			// Add the task to the array
			_taskList[uniqueTask][uniqueTask.key].push( task );

			if ( _taskList[uniqueTask][uniqueTask.key].length == 1 )
			{
				// Execute the action
				uniqueTask.execute();
			}
		}

		/**
		 * Handle task success event
		 * @param	message
		 */
		private final function success(message:Dictionary):void 
		{
			var task:AMITask = message["task"];
			if ( ! (task.action is AMIUniqueAction) ) 
			{
				// Call the success method
				task.success( message["data"] );

				// Early out
				return;
			}
			
			var uniqueTask:AMIUniqueAction = task.action as AMIUniqueAction;
			
			// Get the array
			var list:Array = _taskList[uniqueTask][uniqueTask.key];
			
			// Loop until all the messages have been returned 
			while ( list.length ) 
			{
				// Shift the task off the list
				var taskObj:AMITask = list.shift();
				
				// Call the success method
				taskObj.success( message["data"] );
			}

			// Delete everything in the list
			_taskList[uniqueTask][uniqueTask.key] = null;
			
		}

		/**
		 * Handle task failed event
		 * @param	message
		 */
		private final function failed(message:Dictionary):void 
		{
			var task:AMITask = message["task"];
			if ( ! (task.action is AMIUniqueAction) ) 
			{
				// Call the failed method
				task.failed( message["data"] );

				// Early out
				return;
			}

			var uniqueTask:AMIUniqueAction = task.action as AMIUniqueAction;

			// Get the array
			var list:Array = _taskList[uniqueTask][uniqueTask.key];
			
			// Loop until all the messages have been returned 
			while ( list.length ) 
			{
				// Shift the task off the list
				var taskObj:AMITask = list.shift();
				
				// Call the failed method
				taskObj.failed( message["data"] );
			}

			// Delete everything in the list
			_taskList[uniqueTask][uniqueTask.key] = null;
		}
	}
}