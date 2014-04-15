/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2009 DevelopmentArc LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 * ***** END MIT LICENSE BLOCK ***** */
package com.developmentarc.core.utils
{
	/**
	 * A Singleton Class that enables any item to be used as
	 * a Singleton reference.  This Class creates a new instance
	 * of the requested Class type and then stores the reference
	 * in a static table.  When an instance of a previously requested
	 * Class is made, the perviously generated instance is returned.
	 * 
	 * <p>This class acts as a Singlton facade to the InstanceFactory
	 * Class. </p>
	 * 
	 * @author James Polanco
	 * 
	 */
	public class SingletonFactory extends InstanceFactory
	{
		/* STATIC PROPERTIES */
		/**
		 * @private
		 * The static instance of the class. 
		 */
		static protected var __instance:SingletonFactory;
		
		/**
		 * Used to get access to an instance of the Class type
		 * requested.  This method first determines if the Class
		 * type has been requested before.  If the Class has never
		 * been requested, the method creates a new instance of the
		 * Class, stores it in a table and then returns a reference
		 * to the Class.
		 * 
		 * <p>If the Class type has been requested previously, the
		 * method returns the previously generated instance. </p>
		 *  
		 * @param type The Class of the instance to return.
		 * @return The generated instance of the Class.
		 * 
		 */
		static public function getSingletonInstance(type:Class):*
		{
			return instance.getInstance(type);
		}
		
		/**
		 * Used to remove a specific instance type from the factory.
		 * This method checks to see if the requeted type has an intance
		 * in the table, and if so the instance is removed.  This enables
		 * getInstance() to create a new instance the next time the method
		 * is called.  If the instance type does not exist, nothing occurs.
		 *  
		 * @param type The type of instance to look for and remove.
		 * 
		 */
		static public function clearSingletonInstance(type:Class):void
		{
			instance.clearInstance(type);
		}
		
		/**
		 * Used to remove all current instances from the Factory.
		 * 
		 */
		static public function clearAllSingletonInstances():void
		{
			instance.clearAllInstances();
		}
		
		/**
		 * Returns the current instance of the SingletonFactory.
		 * 
		 * @return Current instance of the factory.
		 * 
		 */
		static protected function get instance():SingletonFactory
		{
			if(!__instance) __instance = new SingletonFactory(SingletonLock);
			return __instance;
		}
		
		/**
		 * Enables extended Classes to access the lock.
		 *  
		 * @return The lock Class.
		 * 
		 */
		static protected function get lock():Class
		{
			return SingletonLock;
		}
		
		/**
		 * Constructor -- DO NOT CALL.
		 * @private 
		 * @param lock
		 * 
		 */
		public function SingletonFactory(lock:Class)
		{
			super();
			
			// only extendend classes can call the instance directly
			if(!lock is SingletonLock) throw new Error("Invalid use of SingletonFactory constructor, do not call directly.", 9001);
		}
	}
}

class SingletonLock
{
	public function SingletonLock() {}
}