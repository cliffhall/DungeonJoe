/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.view.mediator
{
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
	import com.futurescale.dungeonjoe.controller.constant.view.ViewStates;
	import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
	import com.futurescale.dungeonjoe.view.component.Location;

	import flash.events.MouseEvent;

	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * A Mediator for interacting with the Location display.
	 */
	public class LocationMediator extends Mediator
	{

		public static const NAME:String = "LocationMediator";

		public function LocationMediator( viewComponent:Location )
		{
			super( NAME, viewComponent );
		}

		override public function listNotificationInterests():Array
		{
			return [
				FSMAnnounce.CHANGED_WELCOMING,
				FSMAnnounce.CHANGED_PREPARING_LEVEL,
				FSMAnnounce.CHANGED_SHOWING_SCORE,
				FSMAnnounce.CHANGED_MOVING_CHARACTER,
				FSMAnnounce.CHANGED_BEING_CARRIED,
				CharacterProxy.LEVEL_CHANGED,
			];
		}

		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case FSMAnnounce.CHANGED_WELCOMING:
					location.setState( ViewStates.LOCATION_IDLE );
					break;

				case FSMAnnounce.CHANGED_SHOWING_SCORE:
					location.setState( ViewStates.LOCATION_PLAY);
					location.setLocation( "≈≈" );
					break;

				case FSMAnnounce.CHANGED_MOVING_CHARACTER:
					location.setState( ViewStates.LOCATION_PLAY );
					location.setLocation( note.getBody() as String );
					break;

				case FSMAnnounce.CHANGED_BEING_CARRIED:
					location.setState( ViewStates.LOCATION_PLAY );
					location.setLocation( "??" );
					break;

				case FSMAnnounce.CHANGED_PREPARING_LEVEL:
					location.setState( ViewStates.LOCATION_PLAY );
					location.setLocation( "**" );
					break;

				case CharacterProxy.LEVEL_CHANGED:
					location.setState( ViewStates.LOCATION_PLAY );
					location.setLevel( note.getBody() as String );
					break;
			}
		}

		protected function get location():Location
		{
			return viewComponent as Location;
		}
	}
}