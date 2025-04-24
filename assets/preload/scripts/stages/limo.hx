import BackgroundDancer;

var fastCarCanDrive:Bool = true;

var limo:FlxSprite;
var grpLimoDancers:FlxGroup;
var fastCar:FlxSprite;

function resetFastCar():Void
{
    fastCar.x = -12600;
    fastCar.y = FlxG.random.int(140, 250);
    fastCar.velocity.x = 0;
    fastCarCanDrive = true;
}

function fastCarDrive()
{
    FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

    fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
    fastCarCanDrive = false;
    new FlxTimer().start(2, function(tmr:FlxTimer)
    {
        resetFastCar();
    });
}

function create()
{
    PlayState.defaultCamZoom = 0.90;

    var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset'));
    skyBG.scrollFactor.set(0.1, 0.1);
    add(skyBG);

    var bgLimo:FlxSprite = new FlxSprite(-200, 480);
    bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo');
    bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
    bgLimo.animation.play('drive');
    bgLimo.scrollFactor.set(0.4, 0.4);
    add(bgLimo);

    grpLimoDancers = new FlxGroup();
    add(grpLimoDancers);

    for (i in 0...5)
    {
        var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
        dancer.scrollFactor.set(0.4, 0.4);
        grpLimoDancers.add(dancer);
    }

    var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay'));
    overlayShit.alpha = 0.5;
    // add(overlayShit);
    // var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);
    // FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);
    // overlayShit.shader = shaderBullshit;

    limo = new FlxSprite(-120, 550);
    limo.frames = Paths.getSparrowAtlas('limo/limoDrive');
    limo.animation.addByPrefix('drive', "Limo stage", 24);
    limo.animation.play('drive');
    limo.antialiasing = true;

    fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol'));

    resetFastCar();
    add(fastCar);

    add(limo);
}

function createPost()
{
    add(fastCar);
}

function beatHit()
{
    /*
    if (ui.PreferencesMenu.getPref('camera-zoom'))
    {
        if (PlayState.curSong.toLowerCase() == 'milf' && PlayState.curBeat >= 168 && PlayState.curBeat < 200 && PlayState.camZooming && FlxG.camera.zoom < 1.35)
        {
            FlxG.camera.zoom += 0.015;
            PlayState.camHUD.zoom += 0.03;
        }

        if (PlayState.camZooming && FlxG.camera.zoom < 1.35 && PlayState.curBeat % 4 == 0)
        {
            FlxG.camera.zoom += 0.015;
            PlayState.camHUD.zoom += 0.03;
        }
    }
    */

    for (dancer in grpLimoDancers)
    {
        dancer.dance();
    };

    if (FlxG.random.bool(10) && fastCarCanDrive)
        fastCarDrive();
}