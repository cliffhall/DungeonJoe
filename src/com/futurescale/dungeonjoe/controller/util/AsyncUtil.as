/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.util
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import mx.core.Application;
	import mx.core.FlexGlobals;

	public class AsyncUtil
	{
			public static function callLater(method:Function, args:Array=null):void
			{
				FlexGlobals.topLevelApplication.callLater(method, args);
			}

			public static function callbackAfter( method:Function, timeout:Number ):Timer
			{
				var timer:Timer = new Timer(timeout,0);
				timer.addEventListener(TimerEvent.TIMER, method);
				timer.start();
				return timer;
			}

			public static function stopCalling( timer:Timer, method:Function):Timer
			{
				timer.stop();
				timer.removeEventListener( TimerEvent.TIMER, method );
				timer = null;
				return timer;
			}

	}
}