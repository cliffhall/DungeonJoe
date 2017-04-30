/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.command
{
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
	import com.futurescale.dungeonjoe.controller.util.AsyncUtil;
	import com.futurescale.dungeonjoe.model.entity.DungeonItem;
	import com.futurescale.dungeonjoe.model.entity.Room;
	import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
	import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * Move the Character to a given room.
	 * <P>
	 * The location to move the character to must be in
	 * the body of the note.
	 * </P>
	 */
	public class MoveCharacterCommand extends SimpleCommand
	{
		private var dp:DungeonProxy;
		private var cp:CharacterProxy;

		override public function execute( note:INotification ) : void
		{
			// get proxies
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );

			// Get the source room
			var currentLocation:String = cp.character.location;
			if (currentLocation) {
				var srcRoom:Room = dp.dungeon.getRoom( currentLocation );
				srcRoom.removeItem( DungeonItem.JOE );
			}

			// Get the destination room
			var location:String = note.getBody() as String;
			var destRoom:Room = dp.dungeon.getRoom( location );
			destRoom.addItem( cp.character );

			// Move the character into the room
			cp.character.location = destRoom.location;

			if ( ( destRoom.hasDragon() && !cp.character.hasItem( DungeonItem.SWORD ) ) ||
				 ( destRoom.hasPit() && !cp.character.hasItem( DungeonItem.ROPE ) ) ) cp.succumbToThreat();

			// Determine which state to place the character in
			if ( destRoom.hasWyvern() ) {
				AsyncUtil.callLater(sendNotification,[StateMachine.ACTION, destRoom, FSMActions.CAPTURED]);
			} else if ( destRoom.hasPit() ) {
				AsyncUtil.callLater(sendNotification,[StateMachine.ACTION, destRoom, FSMActions.PITFALL]);
			} else {
				AsyncUtil.callLater(sendNotification,[StateMachine.ACTION, destRoom, FSMActions.MOVED]);
			}
		}
	}
}