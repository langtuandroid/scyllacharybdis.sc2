package com.scyllacharybdis.components
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.ComponentObject;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	/**
	 * 
	 */
	[Component (type="SoundComponent")]
	public class SoundComponent extends ComponentObject
	{
		private var _sound:Sound;
		
		/** 
		 * Engine constructor
		 * @private
		 */

		public final override function engine_awake():void
		{
			super.engine_awake();
		}
	
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start(): void 
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
			super.engine_destroy();
		}
		
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}
		
		/**
		 * Load a sound file
		 * @param	value (String) The filename
		 */
		public function loadSound( value:String ):void 
		{ 
			_sound = new Sound( new URLRequest("sounds/" + value) ); 
		}
		
		/**
		 * Play the sound
		 * @param	loopCount (int) The number of times you want it to loop.
		 */
		public function playSound( loopCount:int = 1 ):void 
		{
			if ( _sound == null )
			{
				return;
			}
			_sound.play(0, loopCount, null );
		}
		
		/**
		 * Load progress handler
		 * @param	event (ProgressEvent)
		 */
        private function progressHandler(event:ProgressEvent):void 
		{
            var loadTime:Number = event.bytesLoaded / event.bytesTotal;
            var LoadPercent:uint = Math.round(100 * loadTime);
              
            trace("Sound file's size in bytes: " + event.bytesTotal + "\n" 
				+ "Bytes being loaded: " + event.bytesLoaded + "\n" 
				+ "Percentage of sound file that is loaded " + LoadPercent + "%.\n"
			);
        }

		/**
		 * Load file error handler
		 * @param	errorEvent (IOErrorEvent)
		 */
        private function errorHandler(errorEvent:IOErrorEvent):void 
		{
            trace("The sound could not be loaded: " + errorEvent.text );
        }		
	}
}