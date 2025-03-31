import hxvlc.flixel.FlxVideoSprite;
import openfl.display.BlendMode;
import flixel.addons.effects.FlxTrail;
var oiiaoiia = false;
var anamorphiceffect = new CustomShader("anamorphic effects");
anamorphiceffect.intensity = 10;
anamorphiceffect.brightness = 0.06;
var anamorphiceffecttween:FlxTween = null;

var discoCat = new FunkinSprite(0, 0);
discoCat.frames = Paths.getFrames("kitty");
discoCat.animation.addByPrefix("idle", "spinner", 260);
discoCat.animation.play("idle");
discoCat.zoomFactor = 0;
discoCat.scrollFactor.set();
discoCat.alpha = 0;

var smokinghotBG = new FlxVideoSprite();
smokinghotBG.bitmap.onFormatSetup.add(function()
{
	if (smokinghotBG.bitmap != null && smokinghotBG.bitmap.bitmapData != null)
	{
		smokinghotBG.screenCenter();
		smokinghotBG.scrollFactor.set();
	}
});
smokinghotBG.load(Paths.video("ezgif-54ccea6fe5116f"),['input-repeat=65535']);
smokinghotBG.alpha = 0;


var startwarsBG = new FlxVideoSprite();
startwarsBG.bitmap.onFormatSetup.add(function()
{
	if (startwarsBG.bitmap != null && startwarsBG.bitmap.bitmapData != null)
	{
		startwarsBG.screenCenter();
		startwarsBG.scrollFactor.set();
	}
});
startwarsBG.load(Paths.video("ezgif-85b3f75cc19312"),['input-repeat=65535']);
startwarsBG.alpha = 0;

var theLegitBG = new FunkinSprite().makeSolid(1280, 720, 0xFF000000);
theLegitBG.alpha = 0;
theLegitBG.zoomFactor = 0;
theLegitBG.scrollFactor.set();

var beautifulCamera = new FlxCamera();
beautifulCamera.bgColor = 0;
var beautifulBG = new FlxVideoSprite();
beautifulBG.bitmap.onFormatSetup.add(function()
{
	if (beautifulBG.bitmap != null && beautifulBG.bitmap.bitmapData != null)
	{
		beautifulBG.screenCenter();
		beautifulBG.camera = beautifulCamera;
	}
});
beautifulBG.alpha = 0;
beautifulBG.load(Paths.video("youtube_IuAeVYSk5Bc_1920x1080_h264 (online-video-cutter.com) (remux)"),['input-repeat=65535']);
var beautifulText = new FlxText(0, 0, 0, "Beautiful Moment", 74);
beautifulText.font = Paths.font("amsterdam.ttf");
beautifulText.camera = beautifulCamera;
beautifulText.alpha = 0;
var beautifulKanji = new FlxText(0, 0, 0, "死の前の九十四のシーン", 32);
beautifulKanji.font = Paths.font("kanji.ttf");
beautifulKanji.camera = beautifulCamera;
beautifulKanji.alpha = 0;

var rainbowTrail:FlxTrail = null;
//rainbowTrail.visible = false;

function create() {
	FlxG.cameras.remove(camGame, false);
	FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.add(beautifulCamera, false);
	FlxG.cameras.add(camGame);
	FlxG.cameras.add(camHUD, false);
	add(beautifulBG);
	beautifulText.screenCenter();
	beautifulText.y -= 25;
	add(beautifulText);
	beautifulKanji.screenCenter();
	beautifulKanji.y += 200;
	add(beautifulKanji);
	add(smokinghotBG);
	startwarsBG.camera = beautifulCamera;
	add(startwarsBG);
}

function postCreate() {
	insert(0, theLegitBG);
	add(discoCat);
	discoCat.setGraphicSize(1280, 720);
	discoCat.screenCenter();
    FlxG.camera.bgColor = 0xFFFFFFFF;
    FlxG.camera.followLerp = 1.0;
    FlxG.camera.addShader(anamorphiceffect);
	camFollow.x = dad.getCameraPosition().x;
	camFollow.y = dad.getCameraPosition().y;
	FlxG.camera.snapToTarget();
    FlxG.camera.follow();
	FlxG.camera.zoom = 0.6;
	defaultCamZoom = 0.6;
	rainbowTrail = new FlxTrail(dad, null, 5, 10, 0.3, 0.05);
	rainbowTrail.offset.x = 100;
	rainbowTrail.beforeCache = dad.beforeTrailCache;
	rainbowTrail.afterCache = dad.afterTrailCache;
	if (PlayState.chartingMode) {
		oiiaoiia = true;
		startCountdown();
		startTimer.cancel();
	}
	else {
		FlxG.sound.play(Paths.sound("begin"));
		dad.playAnim("idle alt");
		dad.animation.curAnim.frameRate = 100;
		new FlxTimer().start(1.7, function() {
			dad.playAnim("idle");
			new FlxTimer().start(1.1, function() {
				FlxTween.tween(FlxG.camera, {zoom: 1.3}, 8, {ease: FlxEase.sineInOut});
				defaultCamZoom = 1.3;
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
					});
				});
			});
		});
	}
}

function onStartCountdown(event) {
	if (!oiiaoiia) {
        event.cancel();
        return;
    }
}

function flarePlay() {
	FlxTween.num(0, 100, 0.1, {ease: FlxEase.sineOut}, function(v){
		anamorphiceffect.intensity = v;
	})
	.then(FlxTween.num(100, 10, 0.1, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(10, 80, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 80, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(100, 30, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 80, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}));
}

function update() {
	rainbowTrail.color = FlxColor.fromHSB(FlxMath.wrap(Conductor.songPosition,0,360), 1,1);
}

function beatHit() {
	switch(curBeat) {
		case 0,32: flarePlay();
		
		case 4:
			FlxTween.cancelTweensOf(FlxG.camera);
			defaultCamZoom = 1;
			smokinghotBG.play();
			smokinghotBG.blend = BlendMode.SCREEN;
			FlxTween.tween(smokinghotBG, {alpha: 0.7}, (Conductor.crochet/1000) * 8, {ease: FlxEase.sineOut});

		case 16,168:
			FlxTween.tween(discoCat, {alpha: 0.3}, 0.2);

		case 18,170:
			FlxTween.tween(discoCat, {alpha: 0}, 0.2);
			
		case 69:
			startHUDSequence();
			FlxTween.tween(smokinghotBG, {alpha: 0}, (Conductor.crochet/1000) * 4, {ease: FlxEase.sineInOut});

		case 84:
			defaultCamZoom = 0.6;
			startwarsBG.play();
			startwarsBG.alpha = 1;
			
		case 148:
			startwarsBG.alpha = 0;
			startwarsBG.pause();
			FlxG.camera.alpha = 0;
			FlxG.camera.scroll.y += 100;
			FlxG.camera.zoom = 1;
			defaultCamZoom = 1;
			befallTheCurrentHUD();

		case 154:
			FlxTween.tween(beautifulBG, {alpha: 1}, (Conductor.crochet/1000) * 8, {ease: FlxEase.sineOut});
			beautifulBG.play();
			FlxTween.tween(FlxG.camera.scroll, {y: FlxG.camera.scroll.y - 100}, (Conductor.crochet/1000) * 30);

		case 160:
			FlxTween.tween(FlxG.camera, {alpha: 0.8}, (Conductor.crochet/1000) * 16);
			FlxTween.tween(FlxG.camera, {zoom: 0.6}, (Conductor.crochet/1000) * 24);
			FlxTween.tween(beautifulText, {alpha: 1}, (Conductor.crochet/1000) * 8, {ease: FlxEase.sineOut});
			FlxTween.tween(beautifulKanji, {alpha: 1}, (Conductor.crochet/1000) * 8, {ease: FlxEase.sineOut});

		case 184:
			startHUDSequence();
			FlxTween.tween(beautifulBG, {alpha: 0}, (Conductor.crochet/1000) * 4, {ease: FlxEase.sineOut});
			FlxTween.tween(beautifulText, {alpha: 0}, (Conductor.crochet/1000) * 4, {ease: FlxEase.sineOut});
			FlxTween.tween(beautifulKanji, {alpha: 0}, (Conductor.crochet/1000) * 4, {ease: FlxEase.sineOut});
			FlxG.camera.alpha = 1;
	}
}

function destroy() {
	beautifulBG.pause();
	beautifulBG.destroy();
}

function stepHit() {
	if (curStep > 143 && curStep < 270) {
		FlxTween.completeTweensOf(theLegitBG);
		FlxTween.tween(theLegitBG, {alpha: 1-((270 - curStep) / 127)}, (Conductor.stepCrochet/1000)/2)
		.then(FlxTween.tween(theLegitBG, {alpha: 0}, (Conductor.stepCrochet/1000)/2));
	}
	if (curStep == 270) FlxG.camera.bgColor = 0;
}