/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.constant.embed
{
	/**
	 * Constants used to embed sounds into the application.
	 */
	public class EmbeddedSounds
	{

		// sounds we hear from adjacent rooms

		[Embed(source="assets/sound/nearby-wyvern.mp3")]
		public static const NEARBY_WYVERN:Class;

		[Embed(source="assets/sound/nearby-dragon.mp3")]
		public static const NEARBY_DRAGON:Class;

		[Embed(source="assets/sound/nearby-pit.mp3")]
		public static const NEARBY_PIT:Class;

		// sounds we hear as Joe moves from room to room

		[Embed(source="assets/sound/moving-treasure.mp3")]
		public static const MOVING_TREASURE:Class;

		[Embed(source="assets/sound/moving-joe.mp3")]
		public static const MOVING_JOE:Class;

		[Embed(source="assets/sound/moving-damsel.mp3")]
		public static const MOVING_DAMSEL:Class;

		[Embed(source="assets/sound/moving-damsel.mp3")]
		public static const MOVING_WYVERN:Class;

	}
}