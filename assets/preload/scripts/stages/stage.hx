function create()
{
    PlayState.defaultCamZoom = 0.9;

    var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
    add(bg);

    var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
    stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
    stageFront.updateHitbox();
    stageFront.antialiasing = true;
    stageFront.scrollFactor.set(0.9, 0.9);
    stageFront.active = false;
    add(stageFront);

    var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
    stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
    stageCurtains.updateHitbox();
    stageCurtains.antialiasing = true;
    stageCurtains.scrollFactor.set(1.3, 1.3);
    stageCurtains.active = false;

    add(stageCurtains);
}

function beatHit()
{
    if (PlayState.curBeat % 8 == 7 && PlayState.curSong == 'Bopeebo')
    {
        PlayState.boyfriend.playAnim('hey', true);
    }

    if (PlayState.curBeat % 16 == 15 && PlayState.curSong == 'Tutorial' && PlayState.dad.curCharacter == 'gf' && PlayState.curBeat > 16 && PlayState.curBeat < 48)
    {
        PlayState.boyfriend.playAnim('hey', true);
        PlayState.dad.playAnim('cheer', true);
    }
}