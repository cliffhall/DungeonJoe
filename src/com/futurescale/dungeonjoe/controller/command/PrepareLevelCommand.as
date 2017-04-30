/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.command
{
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
	import com.futurescale.dungeonjoe.controller.util.AsyncUtil;
	import com.futurescale.dungeonjoe.model.entity.Dungeon;
	import com.futurescale.dungeonjoe.model.entity.DungeonItem;
	import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
	import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * Prepare the dungeon, character and playfield for a given level.
	 */
	public class PrepareLevelCommand extends SimpleCommand
	{
		private var dp:DungeonProxy;
		private var cp:CharacterProxy;
		private var location:String;
		private var timer:Timer;
		private var screenTime:Number = 5000;

		override public function execute( note:INotification ) : void
		{
			// get proxies
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );

			// advance the character to the next level (first, if starting)
			var level:String = cp.getLevel();

			// prepare dungeon for current level
			dp.createDungeon();

			// Choose a random empty room to start
			location = dp.dungeon.getRandomEmptyRoom().location;

			switch (level)
			{

				// LEVEL_1:
				// Character starts with rope
				// Dungeon has 8 pits, 2 wyverns, 1 dragon
				case CharacterProxy.LEVEL_1:
					createRope( location );
					createSword( );
					createBall( );
					createBooty();
					createDragon();
					createPits(8);
					createWyverns(2);
					timer = AsyncUtil.callbackAfter(beginPlay, screenTime);
					break;

				// LEVEL_2:
				// Character starts with rope
				// Dungeon has 10 pits, 4 wyverns, 1 dragon
				case CharacterProxy.LEVEL_2:
					createRope( location );
					createSword( );
					createBall();
					createBooty();
					createDragon();
					createPits(10);
					createWyverns(4);
					timer = AsyncUtil.callbackAfter(beginPlay, screenTime);
					break;

				// LEVEL_3:
				// Character starts with rope
				// Dungeon has 12 pits, 8 wyverns, 1 dragon
				case CharacterProxy.LEVEL_3:
					createRope( location );
					createSword( );
					createBall();
					createBooty();
					createDragon();
					createPits(12);
					createWyverns(8);
					timer = AsyncUtil.callbackAfter(beginPlay, screenTime);
					break;

				// LEVEL_4:
				// Character starts with rope
				// Dungeon has 14 pits, 10 wyverns, 1 dragon
				case CharacterProxy.LEVEL_4:
					createRope( location );
					createSword( );
					createBall();
					createBooty();
					createDragon();
					createPits(14);
					createWyverns(10);
					timer = AsyncUtil.callbackAfter(beginPlay, screenTime);
					break;

				// GAME_OVER:
				// Last Level Played, Player Wins!
				case CharacterProxy.GAME_OVER:
					AsyncUtil.callLater(sendNotification,[ StateMachine.ACTION, null, FSMActions.WIN ]);
					break;
			}

		}

		private function beginPlay( event:TimerEvent ):void
		{
			timer = AsyncUtil.stopCalling( timer, beginPlay );

			// Start the wyverns move timer
			dp.beginPlay();

			// Start the character's health timer
			cp.beginPlay();

			// move the character
			sendNotification( StateMachine.ACTION, location, FSMActions.MOVE );
		}

		public function createPits( count:Number ):void
		{
			for (var i:int=0; i<count; i++){
				dp.addItem( new DungeonItem( DungeonItem.PIT ),true );
			}
		}

		public function createWyverns( count:Number ):void
		{
			for (var i:int=0; i<count; i++){
				dp.addItem( new DungeonItem( DungeonItem.WYVERN ), true );
			}
		}

		public function createDragon( ):void
		{
			dp.addItem( new DungeonItem( DungeonItem.DRAGON ) );
		}

		public function createSword( ):void
		{
			dp.addItem( new DungeonItem( DungeonItem.SWORD ) );
		}

		public function createRope( location:String="" ):void
		{
			dp.addItem( new DungeonItem( DungeonItem.ROPE ), false, location );
		}

		public function createBall( ):void
		{
			dp.addItem( new DungeonItem( DungeonItem.BALL  ) );
		}

		public function createBooty( ):void
		{
			dp.addItem( new DungeonItem( DungeonItem.DAMSEL )  );
			dp.addItem( new DungeonItem( DungeonItem.TREASURE ) );
		}

	}
}