/*
 * Copyright 2004-2020 Hewlett Packard Enterprise Development LP
 * Other additional copyright holders may be indicated within.
 *
 * The entirety of this work is licensed under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
  This module contains the implementation of the Unrolled linked list type.
  A list is a lightweight container similar to an array that is suitable for
  building up and iterating over a collection of elements in a structured
  manner.
  
  Unrolled linked list are not parallel safe by default. 
  Appends into a list is O(1).
*/


module UnrolledLinkedList {
	use List;
  	writeln("New library: UnrolledLinkedList");

  class ListNode{
  	type eltType;
  	var numberOfElements: int = 0;
  	var elements: list(eltType);
	var next: unmanaged ListNode(eltType)?;
  }


  record UnrolledLinkedList {
  	type eltType;
  	var nodeSize: int;
  	var size: int;
  	var first: unmanaged ListNode(eltType)?;
  	var last: unmanaged ListNode(eltType)?;

	proc init(type eltType, nodeSize: int){
  		this.eltType = eltType;
  		this.nodeSize = nodeSize;
  	}

    /*
      Add an element to the end of this unrolled linked list.
      :arg data: An element to append.
      :type data: `eltType`
    */
  	proc append(data: eltType){
  		
  		if first==nil{
  			first = new unmanaged ListNode(eltType);
  			first!.elements.append(data);
  			first!.numberOfElements += 1;
  			last = first;
  		}
  		else if last!.numberOfElements < nodeSize {
  			last!.elements.append(data);
  			last!.numberOfElements += 1;
  		}
  		else {
  			var new_node: unmanaged ListNode(eltType)? = new unmanaged ListNode(eltType);
  			var mid: int;
  			if last!.numberOfElements%2 == 1{
				mid = last!.numberOfElements/2+1;
  			}else{
  				mid = last!.numberOfElements/2;
  			}
  			for i in (mid+1)..last!.numberOfElements{
  				new_node!.elements.append(last!.elements[i]);
  				new_node!.numberOfElements += 1;
  			}
  			for i in (mid+1)..last!.numberOfElements{
  				last!.elements.pop();
  			}
  			new_node!.elements.append(data);
  			new_node!.numberOfElements+=1;
  			last!.numberOfElements = mid;
  			last!.next = new_node;
  			last = new_node;
  		}
  		size+=1;
  	}
  	
    /*
    Iterate over unrolled linked list using loop such as for loop.
    */
  	iter these() {
      var tmp = first;
      while tmp != nil {
    	  for element in tmp!.elements {
    		  yield element;
    	  }
        tmp = tmp!.next;
      }
  	}


    /*
      Remove the element at the end of this unrolled linked list and return it.
      .. warning::
        Calling this method on an empty list will return -1.
      :return: The element popped.
      :rtype: `eltType`
    */
    proc pop(): eltType{
      if last!=nil {
        last!.numberOfElements-=1;
        var popped_element = last!.elements.pop();
        if last!.numberOfElements == 0{
            last = nil;
            var tmp = first;
            if tmp == nil{
              last = nil;
            }
            else if tmp!.next == nil && tmp!.numberOfElements == 0{
              last = nil;
              first = nil;
            }
            else{
              while(tmp!.next != nil){
                if tmp!.next!.numberOfElements == 0{
                  tmp!.next = nil;
                }
                else{
                  tmp = tmp!.next;
                }
              }
              last = tmp;
            }
            
          }
        size-=1;
        return popped_element;
        }
      else{
        return -1;
      }
    }
  }

}



