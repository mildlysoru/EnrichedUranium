package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.events.NetStatusEvent;
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;

#if cpp
import hxcodec.VideoHandler;
class FlxVideo extends FlxBasic{
	var video:VideoHandler;
	public var finishCallback(get, set):Void->Void;
	public function new(vidSrc:String)
	{
		super();
		video = new VideoHandler();
		video.canSkip = false;

		//video.finishCallback = finishCallback;
		video.playVideo(Paths.file(vidSrc));
	}

	public function set_finishCallback(value:Void->Void):Void->Void{
		video.finishCallback = value;
		return value;
	}

	public function get_finishCallback():Void->Void{
		return video.finishCallback;
	}
}
#else
class FlxVideo extends FlxBasic
{
	var video:Video;
	var netStream:NetStream;

	public var finishCallback:Void->Void;

	/**
	 * Doesn't actually interact with Flixel shit, only just a pleasant to use class    
	 */
	public function new(vidSrc:String)
	{
		super();

		video = new Video();
		video.x = 0;
		video.y = 0;

		FlxG.addChildBelowMouse(video);

		var netConnection = new NetConnection();
		netConnection.connect(null);

		netStream = new NetStream(netConnection);
		netStream.client = {onMetaData: client_onMetaData};
		netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnection_onNetStatus);
		netStream.play(Paths.file(vidSrc));
	}

	public function finishVideo():Void
	{
		netStream.dispose();
		FlxG.removeChild(video);

		if (finishCallback != null)
			finishCallback();
	}

	public function client_onMetaData(metaData:Dynamic)
	{
		video.attachNetStream(netStream);

		video.width = FlxG.width;
		video.height = FlxG.height;
	}

	private function netConnection_onNetStatus(event:NetStatusEvent):Void
	{
		if (event.info.code == 'NetStream.Play.Complete')
			finishVideo();
	}
}
#end