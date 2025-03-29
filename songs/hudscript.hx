import openfl.display.BlendMode;
import flixel.math.FlxRect;

var moderncamera = new HudCamera();

var internalscore:Int = 0;

var hudes = [
    new FlxSprite().loadGraphic(Paths.image("hud/oiia hud1")),
    new FlxSprite().loadGraphic(Paths.image("hud/oiia hud2")),
    new FlxSprite().loadGraphic(Paths.image("hud/oiia hud3")),
    new FlxSprite().loadGraphic(Paths.image("hud/oiia hud4"))
];

var scorebarlabel = new FlxText(200, 30, 0, "score", 24);
var scorebar = new FlxSprite(187, 62).loadGraphic(Paths.image("hud/scorebar"));
var scorefire = new FlxSprite(-234, -458);
var scorefiretween:FlxTween = null;

var healthbarlabel = new FlxText(430, 612, 0, "health", 24);
var healthbar = new FlxSprite(427, 642).loadGraphic(Paths.image("hud/healthbar"));

var anamorphiceffect = new CustomShader("anamorphic effects");
var anamorphiceffecttween:FlxTween = null;

function postCreate() {
    for (i in [healthBar, healthBarBG, iconP1, iconP2]) i.visible = false;

    FlxG.cameras.add(moderncamera, false);
    moderncamera.bgColor = 0;
    moderncamera.downscroll = camHUD.downscroll;

    for (i in hudes) {
        i.camera = moderncamera;
        i.alpha = 0;
        i.flipY = downscroll;
        add(i);
    }

    scorebar.camera = moderncamera;
    scorebar.clipRect = FlxRect.get(0, 0, 0, scorebar.height);
    scorebar.alpha = 0;
    scorebar.flipY = downscroll;
    add(scorebar);

    scorebarlabel.camera = moderncamera;
    scorebarlabel.font = Paths.font("timeburner.ttf");
    scorebarlabel.alpha = 0;
    add(scorebarlabel);

    scorefire.flipX = true;
    scorefire.frames = Paths.getFrames("hud/scorefire");
    scorefire.animation.addByPrefix("idle", "fireframe", 24);
    scorefire.animation.play("idle");
    scorefire.scale.set(1.2, 1);
    scorefire.updateHitbox();
    scorefire.camera = moderncamera;
    scorefire.blend = BlendMode.ADD;
    scorefire.alpha = 0;
    scorefire.visible = false;
    scorefire.shader = new CustomShader("colorswap");
    scorefire.shader.uTime = 1;
    scorefire.shader.gaytime = false;
    //FlxTween.num(1, 0.4, 2, {}, function(v) {
    //    scorefire.shader.uTime = v;
    //});
    //FlxTween.num(24, 48, 2, {}, function(v) {
    //    scorefire.animation.curAnim.frameRate = v;
    //});
    add(scorefire);
    scorefire.scale.y = 0.6;
    scorefire.origin.y += 20;
    scorefire.colorTransform.blueOffset = scorefire.colorTransform.redOffset = scorefire.colorTransform.greenOffset = 100;

    healthbar.camera = moderncamera;
    healthbar.clipRect = FlxRect.get(0, 0, 0, healthbar.height);
    healthbar.alpha = 0;
    healthbar.flipY = downscroll;
    add(healthbar);

    healthbarlabel.camera = moderncamera;
    healthbarlabel.font = Paths.font("timeburner.ttf");
    healthbarlabel.alpha = 0;
    add(healthbarlabel);

    moderncamera.addShader(anamorphiceffect);
    anamorphiceffect.intensity = 50;
    anamorphiceffect.brightness = 0.06;

    for (i in strumLines.members[0].members) {
        i.x += 50;
        i.camera = moderncamera;
        i.scale.x += 0.2;
        i.scale.y += 0.2;
        i.alpha = 0;
    }
    for (i in strumLines.members[0].notes.members) {
        i.camera = moderncamera;
        i.scale.x += 0.2;
        i.scale.y += 0.2;
        i.alpha = 0;
    }

    if (downscroll) {
        healthbarlabel.y += 40;
        healthbarlabel.x += 10;
        scorebarlabel.y += 43;
        scorebarlabel.x -= 10;

        scorefire.y += 36;
        scorefire.x += 5;
    }
}

function update(elapsed) {
    scorebar.clipRect.width = lerp(scorebar.clipRect.width, FlxMath.lerp(0, scorebar.width, Math.min(100, internalscore) / 100), 0.2);
    scorebar.clipRect = scorebar.clipRect;

    healthbar.clipRect.width = lerp(healthbar.clipRect.width, FlxMath.lerp(0, healthbar.width, health/2), 0.2);
    healthbar.clipRect = healthbar.clipRect;

    scorefire.shader.money = Conductor.curBeatFloat;
}

function onNoteHit(e) {
    if (e.note.splash == "modern") e.showRating = false;
    if (e.rating == "bad") {
        scripts.call("onPlayerMiss");
    }
    if (e.rating == "sick") internalscore += 1;
    else return;

    if (internalscore == 125) {
        FlxTween.cancelTweensOf(scorefire);FlxTween.cancelTweensOf(scorefire.colorTransform);FlxTween.cancelTweensOf(scorefire.scale);anamorphiceffecttween?.cancel();
        FlxTween.tween(scorefire, {alpha: 0.7}, 0.05, {ease: FlxEase.sineOut});
        FlxTween.tween(scorefire.colorTransform, {blueOffset: 20, redOffset: 20, greenOffset: 20}, 0.4, {ease: FlxEase.backOut});
        FlxTween.tween(scorefire.scale, {y: 1}, 0.4, {ease: FlxEase.elasticOut});
        anamorphiceffecttween = FlxTween.num(200, 50, 1, {ease: FlxEase.sineOut}, function(v){
            anamorphiceffect.intensity = v;
        });
    }
    if (internalscore == 150) {
        FlxTween.cancelTweensOf(scorefire);FlxTween.cancelTweensOf(scorefire.scale);scorefiretween?.cancel();anamorphiceffecttween?.cancel();
        FlxTween.tween(scorefire, {alpha: 0.8}, 0.05, {ease: FlxEase.sineOut});
        FlxTween.tween(scorefire.scale, {y: 1.5}, 0.2, {ease: FlxEase.sineOut}).then(FlxTween.tween(scorefire.scale, {y: 1.2}, 0.2, {ease: FlxEase.backOut}));
        scorefiretween = FlxTween.num(0.6, 0.4, 0.2, {}, function(v) {
            scorefire.shader.uTime = v;
        });
        anamorphiceffecttween = FlxTween.num(300, 50, 1, {ease: FlxEase.sineOut}, function(v){
            anamorphiceffect.intensity = v;
        });
    }
    if (internalscore == 175) {
        scorefire.animation.curAnim.frameRate = 30;
        FlxTween.cancelTweensOf(scorefire.scale);scorefiretween?.cancel();FlxTween.cancelTweensOf(scorefire);anamorphiceffecttween?.cancel();
        FlxTween.tween(scorefire.scale, {y: 1.5}, 0.2, {ease: FlxEase.sineOut}).then(FlxTween.tween(scorefire.scale, {y: 1.2}, 0.2, {ease: FlxEase.backOut}));
        scorefiretween = FlxTween.num(1, 0.1, 0.2, {}, function(v) {
            scorefire.shader.uTime = v;
        });
        anamorphiceffecttween = FlxTween.num(500, 100, 1, {ease: FlxEase.sineOut}, function(v){
            anamorphiceffect.intensity = v;
        });
    }
    if (internalscore == 200) {
        scorefire.animation.curAnim.frameRate = 45;
        FlxTween.cancelTweensOf(scorefire.scale);scorefiretween?.cancel();anamorphiceffecttween?.cancel();
        FlxTween.tween(scorefire, {alpha: 1}, 0.05, {ease: FlxEase.sineOut});
        FlxTween.tween(scorefire.scale, {y: 1.9}, 0.2, {ease: FlxEase.sineOut}).then(FlxTween.tween(scorefire.scale, {y: 1.2}, 0.2, {ease: FlxEase.backOut}));
        scorefire.colorTransform.blueOffset = scorefire.colorTransform.redOffset = scorefire.colorTransform.greenOffset = 255;
        FlxTween.tween(scorefire.colorTransform, {blueOffset: 20, redOffset: 20, greenOffset: 20}, 0.9, {ease: FlxEase.backOut});
        scorefire.shader.gaytime = true;
        anamorphiceffecttween = FlxTween.num(720, 120, 1, {ease: FlxEase.sineOut}, function(v){
            anamorphiceffect.intensity = v;
            anamorphiceffect.brightness = FlxMath.lerp(0.06, 0.2, (v - 100) / 1100);
        });
    }
}

function onPlayerMiss() {
    scorefire.animation.curAnim.frameRate = 24;
    internalscore = 0;
    FlxTween.cancelTweensOf(scorefire);FlxTween.cancelTweensOf(scorefire.colorTransform);FlxTween.cancelTweensOf(scorefire.scale);scorefiretween?.cancel();anamorphiceffecttween?.cancel();
    FlxTween.tween(scorefire, {alpha: 0}, 0.3, {ease: FlxEase.sineOut});
    FlxTween.tween(scorefire.colorTransform, {blueOffset: 255, redOffset: 255, greenOffset: 255}, 0.4, {ease: FlxEase.backOut});
    FlxTween.tween(scorefire.scale, {y: 0.6}, 0.4, {ease: FlxEase.elasticOut});
    scorefire.shader.uTime = 1;
    scorefire.shader.gaytime = false;
    anamorphiceffect.intensity = 50;
    anamorphiceffect.brightness = 0.06;
}

public function startHUDSequence() {
    scorefire.visible = true;

    var totalOfHuds = [for (i in hudes) i];
    totalOfHuds.push(healthbarlabel);
    totalOfHuds.push(scorebar);
    totalOfHuds.push(healthbar);
    totalOfHuds.push(scorebarlabel);
    FlxG.random.shuffle(totalOfHuds);
    var curTweeny = FlxTween.tween(totalOfHuds[0], {alpha: 1}, 0.001, {ease: FlxEase.sineInOut});
    var stupidVAlue = 4;
    for (jay in 0...stupidVAlue) {
        var booidelay:Int = 0;
        for (it=>i in totalOfHuds) {
            curTweeny = curTweeny.then(FlxTween.tween(i, {alpha: 0}, 0.01, {ease: FlxEase.sineInOut, startDelay: (stupidVAlue-jay) / 100}))
            .then(FlxTween.tween(i, {alpha: 1}, 0.01, {ease: FlxEase.sineInOut, startDelay: (stupidVAlue-jay) / 300, onComplete: () -> i.alpha = 1}));
        }
    }
}

function startNotesSequence() {
    var totalOfHuds = [for (i in strumLines.members[0].members) i];
    var curTweeny = FlxTween.tween(totalOfHuds[0], {alpha: 1}, 0.001, {ease: FlxEase.sineInOut});
    var stupidVAlue = 4;
    for (jay in 0...stupidVAlue) {
        var booidelay:Int = 0;
        for (it=>i in totalOfHuds) {
            curTweeny = curTweeny.then(FlxTween.tween(i, {alpha: 0}, 0.01, {ease: FlxEase.sineInOut, startDelay: (stupidVAlue-jay) / 100}))
            .then(FlxTween.tween(i, {alpha: 1}, 0.01, {ease: FlxEase.sineInOut, startDelay: (stupidVAlue-jay) / 300, onComplete: () -> i.alpha = 1}));
        }
    }
    for (i in strumLines.members[0].notes.members) i.alpha = 1;
}

function befallThyPootyHUD() {
    FlxTween.tween(camHUD, {y: -20}, 1, {ease: FlxEase.sineOut}).then(FlxTween.tween(camHUD, {y: 2000, angle: 20, alpha: 0}, 8, {ease: FlxEase.sineInOut}));
    internalscore = 0;
    scripts.call("onPlayerMiss");
}

public function befallTheCurrentHUD() {
    var totalOfHuds = [for (i in hudes) i];
    totalOfHuds.push(healthbarlabel);
    totalOfHuds.push(scorebar);
    totalOfHuds.push(healthbar);
    totalOfHuds.push(scorebarlabel);
    for (i in totalOfHuds) i.alpha = 0;
}

function onStrumCreation(strumEvent) {
    if (strumEvent.player == 0) {
        strumEvent.__doAnimation = false;
        strumEvent.strum.scale.set(1.4, 1.4);
	    strumEvent.sprite = "hud/noteskin";
    }
}
function onNoteCreation(e) {
    if (e.strumLineID == 0) {
        e.note.splash = "modern";
        e.noteSprite = "hud/noteskin";
    }   
}