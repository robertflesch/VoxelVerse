////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// KnobButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/04/2010 22:51
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.RotationConstraint;
	import org.flashapi.swing.constants.RotationDirection;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.KnobEvent;
	import org.flashapi.swing.exceptions.IndexOutOfBoundsException;
	import org.flashapi.swing.geom.Geometry;
	import org.flashapi.swing.plaf.libs.KnobButtonUIRef;
	import org.flashapi.swing.skin.Skinable;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("KnobButton.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>KnobButton</code> changes value due to user
	 * 	interaction.
	 *
	 *  @eventType org.flashapi.swing.event.KnobEvent.KNOB_UPDATE
	 */
	[Event(name = "knobUpdate", type = "org.flashapi.swing.event.KnobEvent")]
	
	/**
	 *  Dispatched when the user starts rotating the <code>KnobButton</code>
	 * 	instances.
	 *
	 *  @eventType org.flashapi.swing.event.KnobEvent.KNOB_UPDATE_START
	 */
	[Event(name = "knobUpdateStart", type = "org.flashapi.swing.event.KnobEvent")]
	
	/**
	 *  Dispatched when the user stops rotating the <code>KnobButton</code>
	 * 	instances by releasing the mouse button.
	 *
	 *  @eventType org.flashapi.swing.event.KnobEvent.KNOB_UPDATE_FINISHED
	 */
	[Event(name = "knobUpdateFinished", type = "org.flashapi.swing.event.KnobEvent")]
	
	/**
	 * 	<img src="KnobButton.png" alt="KnobButton" width="18" height="18"/>
	 * 
	 * 	The <code>KnobButton</code> class creates a circular knob button that is used
	 * 	to control a value. The user clicks the button and drags the mouse to adjust
	 * 	the value.
	 * 
	 * 	@see org.flashapi.swing.plaf.KnobButtonUI
	 * 
	 *  @includeExample KnobButtonExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.3
	 * */
	public class KnobButton extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>KnobButton</code> instance with the
		 * 					specofoed parameters.
		 * 
		 * 	@param	radius	The radius of the <code>KnobButton</code> instance, in
		 * 					pixels.
		 * 	@param	knobButtonMode	[Not implemented yet.]
		 * 							A <code>KnobButtonMode</code> constant that specifies
		 * 							the type of mode choosed to let the user change
		 * 							the value of the <code>KnobButton</code> instance.
		 * 							default value is <code>KnobButtonMode.CIRCULAR</code>.
		 */
		public function KnobButton(radius:Number = 50, knobButtonMode:String = "circular") {
			super();
			initObj(radius, knobButtonMode);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/*override public function set backgroundColor(value:*):void {
			spas_internal::lafDTO.backgroundColor = getColor(value);
			super.backgroundColor = value;
		}*/
		
		private var _radius:Number;
		/**
		 * 	Sets or gets the radius of the knob button, in pixels.
		 * 
		 * 	@default 50
		 */
		public function get radius():Number {
			return _radius;
		}
		public function set radius(value:Number):void {
			setCenter(value);
			setRefresh();
		}
		
		private var _thumbColor:*;
		/**
		 * 	Sets or gets the thumb color of the knob button.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a>
		 * 	recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a>
		 * 	section of the document to get valid SVG color keyword names.</p>
		 * 
		 *  <p>The default value is returned by the <code>lookAndFeel.getBackgroundColor()</code>
		 * 	property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get thumbColor():* {
			return _thumbColor;
		}
		public function set thumbColor(value:*):void {
			if (value == Color.DEFAULT) _thumbColor = NaN;
			else if (!isNaN(value)) _thumbColor = getColor(value);
			else _thumbColor = value; 
			fixThumbColor();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  knob methods
		//
		//--------------------------------------------------------------------------
		
		private var _value:Number = 0;
		/**
		 * 	Sets or gets the value of this <code>KnobButton</code> instance, from
		 * 	<code>0</code> to <code>1</code>.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #minimum
		 * 	@see #maximum
		 */
		public function get value():Number {
			return _value;
		}
		public function set value(value:Number):void {
			_value = value;
			initKnob();
		}
		
		private var _min:Number = 0;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Sets or gets the minimum value of this <code>KnobButton</code> instance.
		 * 	Values are <code>0</code> to <code>maximum</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 	<code>IndexOutOfBoundsException</code> if the specified value is
		 * 	greater than <code>maximum</code> or lower than <code>0</code>.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #value
		 * 	@see #maximum
		 */
		public function get minimum():Number {
			return _min;
		}
		public function set minimum(value:Number):void {
			//TODO: localization for error messages:
			if (value < 0 || value > _max) throw new IndexOutOfBoundsException();
			_min = value;
			initKnob();
		}
		
		private var _max:Number = 1;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Sets or gets the minimum value of this <code>KnobButton</code> instance.
		 * 	Values are <code>minimum</code> to <code>1</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 	<code>IndexOutOfBoundsException</code> if the specified value is
		 * 	greater than <code>1</code> or lower than <code>minimum</code>.
		 * 
		 * 	@default 1
		 * 
		 * 	@see #minimum
		 * 	@see #value
		 */
		public function get maximum():Number {
			return _max;
		}
		public function set maximum(value:Number):void {
			//TODO: localization for error messages:
			if (value > 1 || value < _min) throw new IndexOutOfBoundsException();
			_max = value;
			initKnob();
		}
		
		private var _minRot:Number = 0;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Sets or gets the minimum value for rotating this <code>KnobButton</code>,
		 * 	instance, in degrees.
		 * 	Values are <code>0</code> to <code>maxRot</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 	<code>IndexOutOfBoundsException</code> if the specified value is
		 * 	greater than <code>maxRot</code> or lower than <code>0</code>.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #maxRot
		 * 	@see #rotationConstraint
		 */
		public function get minRot():Number {
			return _minRot;
		}
		public function set minRot(value:Number):void {
			//TODO: localization for error messages:
			if (value < 0 || value > _maxRot) throw new IndexOutOfBoundsException();
			_minRot = value;
			initKnob();
		}
		
		private var _maxRot:Number = 360;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Sets or gets the maximum value for rotating this <code>KnobButton</code>,
		 * 	instance, in degrees.
		 * 	Values are <code>minRot</code> to <code>360</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 	<code>IndexOutOfBoundsException</code> if the specified value is
		 * 	greater than <code>360</code> or lower than <code>minRot</code>.
		 * 
		 * 	@default 360
		 * 
		 * 	@see #minRot
		 * 	@see #rotationConstraint
		 */
		public function get maxRot():Number {
			return _maxRot;
		}
		public function set maxRot(value:Number):void {
			//TODO: localization for error messages:
			if (value > 360 || value < _minRot) throw new IndexOutOfBoundsException();
			_maxRot = value;
			initKnob();
		}
		
		private var _direction:String = RotationDirection.CLOCKWISE;
		/**
		 * 	Sets or gets the sense of revolution for this <code>KnobButton</code>,
		 * 	instance. Possible values are <code>RotationDirection.CLOCKWISE</code>
		 * 	or <code>RotationDirection.COUNTER_CLOCKWISE</code>.
		 * 
		 * 	A clockwise motion is one that proceeds 'like the clock's hands'; a
		 * 	counterclockwise motion specifies the opposite sense of revolution.
		 * 
		 * 	@default RotationDirection.CLOCKWISE
		 */
		public function get rotationDir():String {
			return _direction;
		}
		public function set rotationDir(value:String):void {
			_direction = value;
			initKnob();
		}
		
		private var _knobMode:String;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Sets or gets the mode of the button.
		 * 
		 * 	@default KnobButtonMode.CIRCULAR
		 */
		public function get knobButtonMode():String {
			return _knobMode;
		}
		public function set knobButtonMode(value:String):void {
			_knobMode = value;
		}
		
		private var _rotConstraint:String = RotationConstraint.ANCHORED;
		/**
		 * 	A <code>RotationConstraint</code> class constant that indicates whether
		 * 	the rotation of the <code>KnobButton</code> instance is constrained
		 * 	within the [<code>minRot</code>-<code>maxRot</code>] range
		 * 	(<code>RotationConstraint.ANCHORED</code>), or not
		 * 	(<code>RotationConstraint.FREE</code>).
		 * 
		 * 	@default RotationConstraint.ANCHORED
		 * 
		 * 	@see #minRot
		 * 	@see #maxRot
		 */
		public function get rotationConstraint():String {
			return _rotConstraint;
		}
		public function set rotationConstraint(value:String):void {
			_rotConstraint = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			var skinObj:Object = getSkinObj();
			spas_internal::lafDTO.currentTarget = _track;
			skinObj.drawTrack();
			spas_internal::lafDTO.currentTarget = _btn;
			skinObj.drawButton();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			fixThumbColor();
			super.setSpecificLafChanges();
		}
		
		/**
		 * @private
		 */
		override public function set skin(value:Skinable):void {
			if ($hasSkin) {
				_track.removeChildAt(0);
				_btn.removeChildAt(0);
			}
			super.skin = value;
			if($skinObject) {
				_track.graphics.clear();
				_btn.graphics.clear();
				var bmp:Bitmap = $skinObject.getTrackBitmap();
				_track.addChildAt(bmp, 0);
				bmp = $skinObject.getButtonBitmap();
				_btn.addChildAt($skinObject.getButtonBitmap(), 0);
			}
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  private properties
		//
		//--------------------------------------------------------------------------
		
		private var _track:Sprite;
		private var _btn:Sprite;
		private var _btnCont:Sprite;
		private const CENTER:Point = new Point();
		private var _rotMat:Matrix;
		
		//--------------------------------------------------------------------------
		//
		//  private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(radius:Number, knobButtonMode:String):void {
			_rotMat = new Matrix();
			createContainers();
			setCenter(radius);
			initKnob();
			initLaf(KnobButtonUIRef);
			spas_internal::setSelector(Selectors.KNOB_BUTTON);
			spas_internal::isInitialized(1);
			//if (spas_internal::isComponent) this.display();
		}
		
		private function createContainers():void {
			_track = new Sprite();
			spas_internal::uioSprite.addChild(_track);
			_btnCont = new Sprite();
			_btn = new Sprite();
			_btnCont.addChild(_btn);
			spas_internal::uioSprite.addChild(_btnCont);
			$evtColl.addEvent(_btn, MouseEvent.MOUSE_DOWN, startUpdate);
		}
		
		private function setCenter(rad:Number):void {
			spas_internal::lafDTO.radius = CENTER.x = CENTER.y = _radius = rad;
			spas_internal::lafDTO.origin = CENTER;
		}
		
		private function fixThumbColor():void {
			spas_internal::lafDTO.thumbColor = (isNaN(_thumbColor)) ?
				lookAndFeel.getThumbColor() : _thumbColor;
		}
		
		private function startUpdate(e:MouseEvent):void {
			setRange();
			_invalidateRotationchange = false;
			computeAngle();
			_value = _currAngle / _range;
			rotate(_currAngle);
			_lastmouseAngle = _mouseAngle;
			this.dispatchEvent(new KnobEvent(KnobEvent.KNOB_UPDATE_START));
			$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, stopUpdate);
		}
		
		private function stopUpdate(e:MouseEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, stopUpdate);
			this.dispatchEvent(new KnobEvent(KnobEvent.KNOB_UPDATE_FINISHED));
		}
		
		//--> Private knob management:
		
		private var _mouseAngle:Number;
		private var _range:Number;
		private var _lastmouseAngle:Number = 0;
		private var _invalidateRotationchange:Boolean;
		private var _currDirection:String;
		private var _currAngle:Number;
		
		private function setRange():void {
			_range = _maxRot - _minRot;
		}
		
		private function initKnob():void {
			setRange();
			/*var initRatio:Number = (_value - _min) / (_max - _min);
			if (_direction == RotationDirection.CLOCKWISE) {
				_mouseAngle = (_minRot+(_range*initRatio))%360;
			} else {
				_mouseAngle = (_minRot-(_range*initRatio))%360;
				if (_mouseAngle < 0) _mouseAngle += 360;
			}*/
			rotate(_range * _value);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void {
			computeAngle();
			var v:Number = _currAngle / _range;
			
			var angleDiff:Number = _mouseAngle - _lastmouseAngle;
			_invalidateRotationchange = (Math.abs(angleDiff) > 180);
			
			if (_invalidateRotationchange) {
				if (_rotConstraint == RotationConstraint.FREE) {
					_invalidateRotationchange = false;
					_value = v;
					rotate(_currAngle);
					
					//--> Dispatch KnobEvent.REVOLUTION_COMPLETE
					dispatchUpdateEvent();
				} else {
					fixInvalidValues();
					dispatchUpdateEvent();
				}
				
				return;
			}
			
			if (!_invalidateRotationchange) {
				if (angleDiff > 0)
					_currDirection = RotationDirection.COUNTER_CLOCKWISE
				else if (angleDiff < 0)
					_currDirection = RotationDirection.CLOCKWISE;
				else if (angleDiff == 0) return;
			}
			
			_value = v;
			rotate(_currAngle);
			_lastmouseAngle = _mouseAngle;
			dispatchUpdateEvent();
			
		}
		
		private function fixInvalidValues():void {
			if (_currDirection == RotationDirection.CLOCKWISE) {
				if(_direction == RotationDirection.CLOCKWISE) {
					_value = 1;
					rotate(_maxRot);
				} else {
					_value = 0;
					rotate(_minRot);
				}
			} else if (_currDirection == RotationDirection.COUNTER_CLOCKWISE) {
				if(_direction == RotationDirection.CLOCKWISE) {
					_value = 0;
					rotate(_minRot);
				} else {
					_value = 1;
					rotate(_maxRot);
				}
			}
		}
		
		private function computeAngle():void {
			var dX:Number = _btnCont.mouseX - CENTER.x;
			var dY:Number = _btnCont.mouseY - CENTER.y;
			_mouseAngle = Math.atan2(dY, -dX) / (Math.PI / 180) + 90;
			if (_mouseAngle < 0) _mouseAngle += 360;
			_currAngle = _direction == RotationDirection.CLOCKWISE ?
				360 - _mouseAngle : _mouseAngle;
		}
		
		private function dispatchUpdateEvent():void {
			this.dispatchEvent(new KnobEvent(KnobEvent.KNOB_UPDATE));
		}
		
		private function rotate(angle:Number):void {
			_rotMat.identity();
			var p:Point = _rotMat.transformPoint(CENTER);
			_rotMat.tx -= p.x;
			_rotMat.ty -= p.y;
			_rotMat.rotate(Geometry.degreeToRadian(angle));
			_rotMat.tx += p.x;
			_rotMat.ty += p.y;
			_btn.transform.matrix = _rotMat;
		}
	}
}