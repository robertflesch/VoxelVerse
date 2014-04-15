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
	import com.developmentarc.core.datastructures.utils.HashTable;
	
	/**
	 * The InstanceFactory acts as a ClassFactory but only generates
	 * a new instance of an item on the first request.  This Factory 
	 * is similar to a Singleton Pattern, but the instance is not 
	 * stored in a static property, instead the instances are stored locally 
	 * within the InstanceFactory.
	 * 
	 * <p>This class is useful when only a single instance of an item
	 * is required but not on a Framework/Application level.  If you
	 * need a Framework/Application level Singleton instance, use the
	 * SingletonFactory to generate your instance.</p>
	 * 
	 * @author James Polanco
	 * 
	 */
	public class InstanceFactory
	{
		/* PROTECTED PROPERTIES */
		/**
		 * Stores the local instances for the factory. 
		 */
		protected var instanceTable:HashTable;
		
		/**
		 * Constructor. 
		 * 
		 */
		public function InstanceFactory()
		{
			// setup the instance
			instanceTable = new HashTable();
		}
		
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
		public function getInstance(type:Class):*
		{
			var output:*;
			
			// determine if we have this type already
			if(containsInstance(type))
			{
				// we do, return it
				output = instanceTable.getItem(type);
			} else {
				// we don't, create it then return it
				output = new type();
				instanceTable.addItem(type, output);
			}
			return output;
		}
		
		/**
		 * Used to determine if an instance of the provided class already exists
		 * 
		 * @param type The type of instance to look for
		 * @return Boolean True if instance exists, otherwise false.
		 */
		public function containsInstance(type:Class):Boolean {
			return instanceTable.containsKey(type);
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
		public function clearInstance(type:Class):void
		{
			if(instanceTable.containsKey(type))
			{
				// remove the instance
				instanceTable.remove(type);
			}
		}
		
		/**
		 * Used to remove all current instances from the Factory.
		 * 
		 */
		public function clearAllInstances():void
		{
			instanceTable.removeAll();
		}

	}
}