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
	 * Take the item.
	 */
	public class TakingItemCommand extends SimpleCommand
	{
		private var dp:DungeonProxy;
		private var cp:CharacterProxy;

		override public function execute( note:INotification ) : void
		{
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );

			var room:Room = dp.dungeon.getRoom(cp.character.location);
			var type:String = note.getBody() as String;

			switch (type)
			{
				case DungeonItem.BALL:
				case DungeonItem.SWORD:
				case DungeonItem.ROPE:
				case DungeonItem.DAMSEL:
				case DungeonItem.TREASURE:
					dp.removeItem(type,room.location);
					cp.takeItem(type);
					break;
			}

			AsyncUtil.callLater( sendNotification,[ StateMachine.ACTION, room, FSMActions.TAKEN ] );
		}
	}
}