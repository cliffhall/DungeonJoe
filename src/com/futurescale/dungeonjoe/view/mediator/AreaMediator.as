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
	import com.futurescale.dungeonjoe.controller.util.AsyncUtil;
	import com.futurescale.dungeonjoe.model.entity.DungeonItem;
	import com.futurescale.dungeonjoe.model.entity.Room;
	import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
	import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
	import com.futurescale.dungeonjoe.view.component.Area;
	import com.futurescale.dungeonjoe.view.component.Icon;

	import flash.events.Event;

	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * A Mediator for interacting with the Area display.
	 */
	public class AreaMediator extends Mediator
	{
		public static const NAME:String = "AreaMediator";

		public function AreaMediator( viewComponent:Area )
		{
			super( NAME, viewComponent );
		}

		override public function onRegister():void
		{
			dp = DungeonProxy(facade.retrieveProxy(DungeonProxy.NAME));
			area.addEventListener( Area.MOVE_NORTH,   onMove );
			area.addEventListener( Area.MOVE_SOUTH,   onMove );
			area.addEventListener( Area.MOVE_EAST,    onMove );
			area.addEventListener( Area.MOVE_WEST,    onMove );
			area.addEventListener( Area.DONE_VIEWING, onDoneViewing );
			area.addEventListener( Icon.ITEM_NEARBY,  onNearby );
			area.addEventListener( Icon.TAKE,         onTake );

		}

		private function onDoneViewing( event:Event ):void
		{
			sendNotification( StateMachine.ACTION, area.currentRoom, FSMActions.USED );
		}

		private function onTake( event:Event ):void
		{
			sendNotification( StateMachine.ACTION,  Icon(event.target).type, FSMActions.TAKE_ITEM );
		}

		private function onMove( event:Event ):void
		{
			switch ( event.type )
			{
				case Area.MOVE_NORTH:
					sendNotification( StateMachine.ACTION,  Room(area.adjacentRooms[0]).location, FSMActions.MOVE );
					break;

				case Area.MOVE_SOUTH:
					sendNotification( StateMachine.ACTION,  Room(area.adjacentRooms[1]).location, FSMActions.MOVE );
					break;

				case Area.MOVE_EAST:
					sendNotification( StateMachine.ACTION,  Room(area.adjacentRooms[2]).location, FSMActions.MOVE );
					break;

				case Area.MOVE_WEST:
					sendNotification( StateMachine.ACTION,  Room(area.adjacentRooms[3]).location, FSMActions.MOVE );
					break;
			}
		}

		private function onNearby( event:Event ):void
		{
			AsyncUtil.callLater( sendNotification,[ Icon.ITEM_NEARBY,  event.target ] );
		}

		override public function listNotificationInterests():Array
		{
			return [
				FSMAnnounce.CHANGED_WELCOMING,
				FSMAnnounce.CHANGED_PREPARING_LEVEL,
				FSMAnnounce.CHANGED_SHOWING_SCORE,
				FSMAnnounce.EXIT_PREPARING_LEVEL,
				FSMAnnounce.CHANGED_WAITING_IN_ROOM,
				FSMAnnounce.CHANGED_WAITING_IN_PIT,
				FSMAnnounce.CHANGED_BEING_CARRIED,
				DungeonProxy.WYVERN_MOVED,
				CharacterProxy.ITEM_USED,
			];
		}

		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() ) {

				case FSMAnnounce.CHANGED_WELCOMING:
				case FSMAnnounce.CHANGED_SHOWING_SCORE:
				case FSMAnnounce.CHANGED_PREPARING_LEVEL:
					area.setState( ViewStates.DUNGEON_AREA_IDLE );
					break;

				case FSMAnnounce.EXIT_PREPARING_LEVEL:
					area.setState( ViewStates.DUNGEON_AREA_PLAY );
					break;

				case FSMAnnounce.CHANGED_WAITING_IN_ROOM:
				case FSMAnnounce.CHANGED_WAITING_IN_PIT:
					var room:Room = Room( note.getBody() );
					area.arriveInRoom( room, dp.dungeon.getAdjacentRooms( room ) );
					break;

				case DungeonProxy.WYVERN_MOVED:
					area.arriveInRoom( area.currentRoom, area.adjacentRooms );
					break;

				case CharacterProxy.ITEM_USED:
					if (note.getType() == DungeonItem.BALL) {
						area.startViewing();
					}
					break;
			}
		}


		private function get area():Area
		{
			return viewComponent as Area;
		}

		private var dp:DungeonProxy;
	}
}