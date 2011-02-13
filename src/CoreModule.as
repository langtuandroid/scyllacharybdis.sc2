package  
{
	import com.scyllacharybdis.di.AbstractModule;
	
	/**
	 * The core module definition.
	 * @author 
	 */
	public class CoreModule extends AbstractModule
	{
		public override function configure():void
		{
			// Tell the requested testclass1 to actually use testclass2
			//bind(TestClass1, TestClass2);
		}
	}
}
