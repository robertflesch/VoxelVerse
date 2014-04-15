package com.voxelengine.utils
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.TimerEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.utils.Timer;
 
    /**
     * Reference: http://wonderfl.net/c/5hBU
     * ...
     * @author Andrew van der Westhuizen
     */
    public class SmokeSmoke extends Bitmap {
        private static const ZERO_POINT:Point = new Point();
        private const mat:Matrix = new Matrix();
        private const tbl:Array = new Array();
 
        private var cnt:int = 0;
        private var ar:Array = new Array();
        private var emitterX:int;
        private var emitterY:int;
        private var smokeSize:int;
        private var verticalClimb:Number;
 
        private var animationTimer:Timer;
        private var emitterTimer:Timer;
 
        public function SmokeSmoke(width:int, height:int, smokeSize:int = 100, verticalClimb:Number = 2, fps:int = 30) {
            super(new BitmapData(width, height, true, 0));
 
            this.verticalClimb = verticalClimb;
            this.smokeSize = smokeSize;
            tbl.push(createSmokyCircle(smokeSize, smokeSize));
            tbl.push(createSmokyCircle(smokeSize, smokeSize));
            tbl.push(createSmokyCircle(smokeSize, smokeSize, 0));
 
            animationTimer = new Timer(1000 / Math.min(60, Math.max(1, fps)));
            animationTimer.addEventListener(TimerEvent.TIMER, animate);
            animationTimer.start();
        }
 
        public function startEmitter(x:int, y:int, smokesPerSecond:int = 5):void {
            emitterX = x;
            emitterY = y;
            emitterTimer = new Timer(1000 / Math.min(60, Math.max(1, smokesPerSecond)));
            emitterTimer.addEventListener(TimerEvent.TIMER, emitSmoke);
            emitterTimer.start();
        }
 
        private function emitSmoke(e:TimerEvent):void {
            var r:Number = (cnt & 15) >> 2;
            addSmoke(emitterX + Math.cos(r * Math.PI / 4) * 24, emitterY + Math.sin(r * Math.PI / 4) * 24);
        }
 
        public function stopEmitter():void {
            emitterTimer.stop();
            emitterTimer.removeEventListener(TimerEvent.TIMER, emitSmoke);
        }
 
        public function addSmoke(x:int, y:int):void {
            var r:Number = 0.4 + Math.random() * 0.4;
            ar.push([x + Math.random() * 20, y + Math.random() * 20, r, 0, 0.06, 0, tbl[(int)(Math.random() * 3)], 0, Math.random() * 0.02 - 0.01]);
        }
 
        private function animate(e:TimerEvent):void {
            bitmapData.lock();
            bitmapData.fillRect(bitmapData.rect, 0x0);
 
            var arNext:Array = new Array();
            for each (var obj:Array in ar) {
                obj[1] -= verticalClimb;
                obj[2] += 0.005;
                obj[3] += obj[4];
                obj[5] += 0.03;
                obj[7] += obj[8];
                if (obj[3] > 1.3)
                    obj[4] = -0.007;
                if (obj[3] < 0)
                    obj[3] = 0;
                if (obj[5] > 1)
                    obj[5] = 1;
                mat.identity();
                mat.translate(-50, -50);
                mat.scale(obj[2], obj[2]);
                mat.rotate(obj[7]);
                mat.translate(obj[0], obj[1]);
                bitmapData.draw(obj[6], mat, new ColorTransform(obj[5], obj[5], obj[5], obj[3]));
                if (obj[1] > -smokeSize && obj[3] > 0)
                    arNext.push(obj);
            }
            bitmapData.unlock();
            ar = arNext;
            cnt++;
        }
 
        private function createSmokyCircle(w:int, h:int, col:int = 0xffffff):BitmapData {
            var buf:BitmapData = new BitmapData(w, h);
            var buf2:BitmapData = new BitmapData(w, h);
            var buf3:BitmapData = new BitmapData(w, h);
            var sh:Shape = new Shape();
            var colors:Array = [0xd0d0d0, 0xa0a0a0, 0x000000];
            var alphas:Array = [1, 1, 1];
            var ratios:Array = [0, 127, 255];
            var matrix:Matrix = new Matrix();
 
            buf.perlinNoise(w, w, 4, Math.random() * 0xffff, true, true, 4);
            matrix.createGradientBox(w, h, 0, 0, 0);
            sh.graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix);
            sh.graphics.drawRect(0, 0, w, h);
            sh.graphics.endFill();
 
            buf3.draw(sh);
            buf.draw(buf3, null, null, BlendMode.MULTIPLY);
 
            colors = [col, 0, 0];
            alphas = [1, 1, 1];
            ratios = [0, 192, 255];
            matrix.createGradientBox(w, h, 45);
            sh.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
            sh.graphics.drawRect(0, 0, w, h);
            sh.graphics.endFill();
 
            buf2.perlinNoise(buf2.width, buf2.height, 4, Math.random() * 0xffff, true, false, 7, true);
            buf2.draw(sh, null, null, BlendMode.ADD);
 
            buf2.copyChannel(buf, buf.rect, ZERO_POINT, 4, 8);
            return buf2;
        }
 
        public function destroy():void {
            emitterTimer.stop();
            emitterTimer.removeEventListener(TimerEvent.TIMER, emitSmoke);
 
            animationTimer.stop();
            animationTimer.removeEventListener(TimerEvent.TIMER, animate);
        }
 
    }
 
}