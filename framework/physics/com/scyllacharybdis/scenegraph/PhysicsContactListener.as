package com.scyllacharybdis.scenegraph 
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.objects.GameObject;

	/**
	 */
	[Singleton]
	public final class PhysicsContactListener extends b2ContactListener
	{
		/**
		 * A colision has happened 
		 * @param	contact (b2Contact) The contact point
		 */
		public override function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var obj1:b2Fixture = contact.GetFixtureA();
			var obj2:b2Fixture = contact.GetFixtureB();

			var gameObj1:GameObject = obj1.GetUserData();
			var gameObj2:GameObject = obj2.GetUserData();

			var script1:ScriptComponent = gameObj1.getComponent( ScriptComponent );
			var script2:ScriptComponent = gameObj2.getComponent( ScriptComponent );
			
			if ( script1 != null ) {
				script1.onBeginContact( gameObj2 );
			}
			
			if ( script2 != null ) {
				script2.onBeginContact( gameObj1 );
			}
		}
		
		/**
		 * A colision has stoped 
		 * @param	contact (b2Contact) The contact point
		 */
		public override function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
			var obj1:b2Fixture = contact.GetFixtureA();
			var obj2:b2Fixture = contact.GetFixtureB();

			var gameObj1:GameObject = obj1.GetUserData();
			var gameObj2:GameObject = obj2.GetUserData();

			var script1:ScriptComponent = gameObj1.getComponent( ScriptComponent );
			var script2:ScriptComponent = gameObj2.getComponent( ScriptComponent );
			
			if ( script1 != null ) {
				script1.onEndContact( gameObj2 );
			}
			
			if ( script2 != null ) {
				script2.onEndContact( gameObj1 );
			}

		}
	}
}