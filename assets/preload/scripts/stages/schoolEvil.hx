flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.chainable.FlxWaveMode;

function create()
{
    var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
    var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

    var posX = 400;
    var posY = 200;

    var bg:FlxSprite = new FlxSprite(posX, posY);
    bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool');
    bg.animation.addByPrefix('idle', 'background 2', 24);
    bg.animation.play('idle');
    bg.scrollFactor.set(0.8, 0.9);
    bg.scale.set(6, 6);
    add(bg);
}