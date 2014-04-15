////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product. If you have received this file from a source
//  other than BANANA TREE DESIGN, then your use, modification, or distribution
//  of this file requires the prior written permission of BANANA TREE DESIGN
//  and Pascal ECHEMANN.
//
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.tween.core {

	// -----------------------------------------------------------
	// Easing.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 09/03/2010 12:12
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>Easing</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 <code>Easing</code> objects.
	 * 
	 * 	<p>"Ease-in" and "ease-out" in digital animation typically refers
	 * 	to a mechanism for defining the 'physics' of the transition between
	 * 	two animation states, eg. the linearity of a tween. <code>Easing</code>
	 * 	objects define "ease-in", "ease-out" and the possibility to use both
	 * 	mechanisms for defining the <code>equation</code> property that
	 * 	represents the 'physics' of the transition between animation states.</p>
	 * 
	 * 	<p>SPAS 3.0 default <code>Easing</code> equations are all based upon Robert 
	 * 	Penner's Easing Equations: <code>v1.3 - Oct. 29, 2002 - (c) 2002 Robert
	 * 	Penner</code>.</p>
	 * 
	 * 	@see http://www.robertpenner.com/profmx
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Easing {
		
		/**
		 * 	Returns a reference to the function that is tipically used by
		 * 	<code>ITween</code> instances to interpolate values between two
		 * 	states of an animation.
		 */
		function get equation():Function;
	}
}