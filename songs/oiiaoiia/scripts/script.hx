import hxvlc.flixel.FlxVideoSprite;
import openfl.display.BlendMode;
import flixel.addons.effects.FlxTrail;
import flixel.addons.display.FlxBackdrop;
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
startwarsBG.shader = new CustomShader("colorswap");
startwarsBG.shader.gaytime = false;
startwarsBG.shader.uTime = 1;

var theLegitBG = new FunkinSprite().makeSolid(1280, 720, 0xFF000000);
theLegitBG.alpha = 0;
theLegitBG.zoomFactor = 0;
theLegitBG.scrollFactor.set();

var textcamerathing = new FlxCamera();
textcamerathing.bgColor = 0;
textcamerathing.zoom = 0.4;
textcamerathing.alpha = 0;
textcamerathing.addShader(startwarsBG.shader);
var textgroupthing = new FlxGroup();
for (i in 0...4) {
	var textthing = new FlxBackdrop(Paths.image("oiiatext" + (i+1)), FlxAxes.Y, 0, 15);
	textthing.x += 400 * i;
	textthing.x -= 150;
	if (i == 1) textthing.x -= 50;
	if (i == 2) textthing.x += 50;
	textgroupthing.add(textthing);
}
var textwarpthing = new CustomShader("fisheye");
textwarpthing.MAX_POWER = 0.25;
textcamerathing.addShader(textwarpthing);

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
	FlxG.cameras.add(textcamerathing, false);
	FlxG.cameras.add(camGame);
	FlxG.cameras.add(camHUD, false);
	FlxG.camera.addShader(startwarsBG.shader);
	add(beautifulBG);
	beautifulText.screenCenter();
	beautifulText.y -= 25;
	add(beautifulText);
	beautifulKanji.screenCenter();
	beautifulKanji.y += 200;
	add(beautifulKanji);
	startwarsBG.camera = beautifulCamera;
	add(startwarsBG);
	add(smokinghotBG);
	textgroupthing.camera = textcamerathing;
	add(textgroupthing);
}

function postCreate() {
	insert(0, theLegitBG);
	add(discoCat);
	discoCat.setGraphicSize(1280, 720);
	discoCat.screenCenter();
    FlxG.camera.bgColor = 0xFFFFFFFF;
    FlxG.camera.followLerp = 1.0;
    FlxG.game.addShader(anamorphiceffect);
	camFollow.x = dad.getCameraPosition().x;
	camFollow.y = dad.getCameraPosition().y;
	FlxG.camera.snapToTarget();
    FlxG.camera.follow();
	FlxG.camera.zoom = 0.6;
	defaultCamZoom = 0.6;
	rainbowTrail = new FlxTrail(dad, null, 5, 10, 1, 0.05);
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
	.then(FlxTween.num(10, 80, 0.02, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.02, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 80, 0.02, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.02, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.03, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.05, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.08, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(80, 30, 0.12, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 100, 0.17, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(100, 30, 0.2, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 80, 0.3, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(100, 30, 0.5, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}))
	.then(FlxTween.num(30, 80, 0.7, {ease: FlxEase.sineInOut}, function(v){
		anamorphiceffect.intensity = v;
	}));
}

function update() {
	rainbowTrail.color = FlxColor.fromHSB(FlxMath.wrap(Conductor.songPosition,0,360), 1,1);
	startwarsBG.shader.money = Conductor.songPosition/200;
}

function beatHit() {
	for (it=>i in textgroupthing.members) {
		FlxTween.cancelTweensOf(i.velocity);
		i.velocity.y = it % 2 == 0 ? 500 : -500;
		FlxTween.tween(i.velocity, {y: it % 2 == 0 ? 15 : -15}, Conductor.crochet/1000, {ease: FlxEase.sineOut});
	}
	switch(curBeat) {
		case 0,32,216: flarePlay();
		
		case 4:
			FlxTween.cancelTweensOf(FlxG.camera);
			defaultCamZoom = 1;
			smokinghotBG.play();
			smokinghotBG.blend = BlendMode.SCREEN;
			FlxTween.tween(smokinghotBG, {alpha: 0.7}, (Conductor.crochet/1000) * 8, {ease: FlxEase.sineOut});

		case 16,168,200:
			FlxTween.tween(discoCat, {alpha: 0.3}, 0.2);

		case 18,170,202:
			FlxTween.tween(discoCat, {alpha: 0}, 0.2);
			
		case 69:
			startHUDSequence();
			FlxTween.tween(smokinghotBG, {alpha: 0}, (Conductor.crochet/1000) * 4, {ease: FlxEase.sineInOut});

		case 84:
			dad.shader = new CustomShader("colorizer");
			dad.shader.colors = [-0.5, -0.3, 0];
			defaultCamZoom = 0.6;
			startwarsBG.play();
			startwarsBG.alpha = 1;
			FlxTween.num(0.2, 0.06, 0.7, {ease: FlxEase.sineInOut}, function(v){
				anamorphiceffect.brightness = v;
			});
			FlxTween.num(200, 50, 0.7, {ease: FlxEase.sineInOut}, function(v){
				anamorphiceffect.intensity = v;
			});

		case 100:
			FlxTween.tween(textcamerathing, {alpha: 0.5}, 0.3, {ease: FlxEase.sineOut});
			FlxTween.num(0.5, 0.25, 0.3, {ease: FlxEase.circOut}, function(val) {
				textwarpthing.MAX_POWER = val;
			});
			FlxTween.tween(smokinghotBG, {alpha: 0.3}, (Conductor.crochet/1000) * 16, {ease: FlxEase.sineInOut});
			smokinghotBG.camera = beautifulCamera;

		case 116:
			startwarsBG.shader.gaytime = true;
			insert(members.indexOf(dad)-1, rainbowTrail);
			for (i in textgroupthing.members) i.setColorTransform(1, 0.75, 0.75);
			
		case 148:
			FlxTween.tween(smokinghotBG, {alpha: 0}, (Conductor.crochet/1000) * 4, {ease: FlxEase.sineInOut});
			startwarsBG.shader.gaytime = false;
			startwarsBG.alpha = 0;
			startwarsBG.pause();
			FlxG.camera.alpha = 0;
			FlxG.camera.scroll.y += 100;
			FlxG.camera.zoom = 1;
			defaultCamZoom = 1;
			remove(rainbowTrail);
			befallTheCurrentHUD();
			FlxTween.tween(textcamerathing, {alpha: 0}, 0.1, {ease: FlxEase.sineOut});
			FlxTween.num(0.25, 0.8, 0.1, {ease: FlxEase.circOut}, function(val) {
				textwarpthing.MAX_POWER = val;
			});

		case 154:
			FlxTween.tween(beautifulBG, {alpha: 1}, (Conductor.crochet/1000) * 8, {ease: FlxEase.sineOut});
			beautifulBG.play();
			FlxTween.tween(FlxG.camera.scroll, {y: FlxG.camera.scroll.y - 100}, (Conductor.crochet/1000) * 30);
			dad.shader.colors = [0.682,0.728,0.843];

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
			FlxTween.num(1, 0, (Conductor.crochet/1000) * 4, {}, function(val) {
				dad.shader.colors = [0.682 * val,0.728 * val,0.843 * val];
			});
		
		case 220:
			FlxTween.tween(smokinghotBG, {alpha: 0.3}, (Conductor.crochet/1000) * 16, {ease: FlxEase.sineInOut});
	}
}

function destroy() {
	beautifulBG.pause();
	beautifulBG.destroy();
	FlxG.game._filters = [];
}

function stepHit() {
	if (curStep > 143 && curStep < 270) {
		FlxTween.completeTweensOf(theLegitBG);
		FlxTween.tween(theLegitBG, {alpha: 1-((270 - curStep) / 127)}, (Conductor.stepCrochet/1000)/2)
		.then(FlxTween.tween(theLegitBG, {alpha: 0}, (Conductor.stepCrochet/1000)/2));
	}
	if (curStep == 270) FlxG.camera.bgColor = 0;
	if (curStep > 880 && curStep < 976) {
		theLegitBG.setColorTransform(1, 1, 1, 255, 255, 255);
		FlxTween.completeTweensOf(theLegitBG);
		FlxTween.tween(theLegitBG, {alpha: 1-((976 - curStep) / 96)}, (Conductor.stepCrochet/1000)/2)
		.then(FlxTween.tween(theLegitBG, {alpha: 0}, (Conductor.stepCrochet/1000)/2));
	}
	if (curStep > 975 && curStep < 1008) {
		FlxTween.completeTweensOf(theLegitBG);
		FlxTween.tween(theLegitBG, {alpha: 1-((975 - curStep) / 33)}, (Conductor.stepCrochet/1000)/4)
		.then(FlxTween.tween(theLegitBG, {alpha: 0}, (Conductor.stepCrochet/1000)/4))
		.then(FlxTween.tween(theLegitBG, {alpha: 1-((975 - curStep) / 33)}, (Conductor.stepCrochet/1000)/4))
		.then(FlxTween.tween(theLegitBG, {alpha: 0}, (Conductor.stepCrochet/1000)/4));
	}
}