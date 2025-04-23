import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import shaderslmfao.BuildingShaders.BuildingShader;
import shaderslmfao.BuildingShaders;
import shaderslmfao.ColorSwap;
import ui.PreferencesMenu;
import hxcodec.flixel.FlxVideo;
import BGSprite;
import BackgroundGirls;

var script:Iris;

class Stage extends FlxGroup
{
    public function new(stage:String)
    {
        super();
        if (stage == null || stage == "")
            stage = "stage";
        final getText:String->String = sys.io.File.getContent;
        var importText = "import PlayState;\nimport BGSprite;\nimport flixel.FlxSprite;\nimport Paths;\nimport flixel.FlxG;\nimport Conductor;\nimport flixel.sound.FlxSound;";
		script = new Iris(importText + getText(Paths.script("stages/"+stage)));
		script.set("add", add);
        script.set("remove", remove);
        script.set("insert", insert);
		script.execute();
    }

    public function create()
    {
        script.call("create");
    }

    public function postCreate()
    {
        script.call("postCreate");
    }

    override public function update(elapsed:Float)
    {
        script.call("update", [elapsed]);
    }

    public function beatHit()
    {
        script.call("beatHit");
    }

    public function stepHit()
    {
        script.call("stepHit");
    }
}