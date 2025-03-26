var oiiaoiia = false;
var anamorphiceffect = new CustomShader("anamorphic effects");
var anamorphiceffecttween:FlxTween = null;

function postCreate() {
    FlxG.camera.bgColor = 0xFFFFFFFF;
    FlxG.camera.followLerp = 1.0;
    FlxG.camera.addShader(anamorphiceffect);
    //FlxG.camera.snapToTarget();
    //FlxG.camera.follow();
    FlxG.sound.play(Paths.sound("begin"));
	dad.playAnim("idle alt");
	dad.animation.curAnim.frameRate = 100;
	new FlxTimer().start(1.7, function() {
		dad.playAnim("idle");
		new FlxTimer().start(1.1, function() {
            FlxTween.tween(FlxG.camera, {zoom: 1.4}, 14, {ease: FlxEase.sineInOut});
            defaultCamZoom = 1.4;
            FlxTween.tween(FlxG.camera.scroll, {y: FlxG.camera.scroll.y + 50}, 14, {ease: FlxEase.sineInOut});
            FlxG.camera.follow();
			dad.playAnim("idle alt");
			dad.animation.curAnim.frameRate = 60;
			new FlxTimer().start(2.1, function() {
				dad.playAnim("idle");
				new FlxTimer().start(.4, function() {
					oiiaoiia = true;
					startCountdown();
					startTimer.cancel();
					FlxTween.tween(camHUD, {alpha: 1}, 0.1);
					FlxG.camera.follow();
				});
			});
		});
	});
}

function onStartCountdown(event) {
	if (!oiiaoiia) {
        event.cancel();
        return;
    }

    FlxTween.tween(anamorphiceffect, {})
}