import openfl.display.BlendMode;
import flixel.math.FlxRect;

var moderncamera = new FlxCamera();

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
    FlxG.cameras.add(moderncamera, false);
    moderncamera.bgColor = 0;

    for (i in hudes) {
        i.camera = moderncamera;
        i.alpha = 0;
        add(i);
    }

    scorebar.camera = moderncamera;
    scorebar.clipRect = FlxRect.get(0, 0, 0, scorebar.height);
    scorebar.alpha = 0;
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
    add(healthbar);

    healthbarlabel.camera = moderncamera;
    healthbarlabel.font = Paths.font("timeburner.ttf");
    healthbarlabel.alpha = 0;
    add(healthbarlabel);

    moderncamera.addShader(anamorphiceffect);
    anamorphiceffect.intensity = 100;
    anamorphiceffect.brightness = 0.06;
}

function update(elapsed) {
    scorebar.clipRect.width = lerp(scorebar.clipRect.width, FlxMath.lerp(0, scorebar.width, Math.min(100, internalscore) / 100), 0.2);
    scorebar.clipRect = scorebar.clipRect;

    healthbar.clipRect.width = lerp(healthbar.clipRect.width, FlxMath.lerp(0, healthbar.width, health/2), 0.2);
    healthbar.clipRect = healthbar.clipRect;

    scorefire.shader.money = Conductor.songPosition / 500;
}

function onNoteHit(e) {
    e.note.splash = "modern";
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
        anamorphiceffecttween = FlxTween.num(300, 100, 1, {ease: FlxEase.sineOut}, function(v){
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
        anamorphiceffecttween = FlxTween.num(400, 100, 1, {ease: FlxEase.sineOut}, function(v){
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
        anamorphiceffecttween = FlxTween.num(600, 100, 1, {ease: FlxEase.sineOut}, function(v){
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
        anamorphiceffecttween = FlxTween.num(1200, 300, 1, {ease: FlxEase.sineOut}, function(v){
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
    anamorphiceffect.intensity = 100;
    anamorphiceffect.brightness = 0.06;
}

function startHUDSequence() {
    var totalOfHuds = [for (i in hudes) i];
    totalOfHuds.push(healthbarlabel);
    totalOfHuds.push(scorebar);
    totalOfHuds.push(healthbar);
    totalOfHuds.push(scorebarlabel);
    FlxG.random.shuffle(totalOfHuds);
    var curTweeny = FlxTween.tween(totalOfHuds[0], {alpha: 1}, 0.001, {ease: FlxEase.sineInOut});
    for (jay in 0...4)
        for (it=>i in totalOfHuds) {
            curTweeny = curTweeny.then(FlxTween.tween(i, {alpha: 0}, 0.001 + (jay * 0.005), {ease: FlxEase.sineInOut})).then(FlxTween.tween(i, {alpha: 1}, 0.01, {ease: FlxEase.sineInOut}));
        }
}

function onStartSong() {
    startHUDSequence();
}