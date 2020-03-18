/* Documentation for UnrolledLinkedList */
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
  	proc insert(data: eltType){
  		
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
  	
  	iter these() {
    var tmp = first;
    while tmp != nil {
    	for element in tmp!.elements {
    		yield element;
    	}
      tmp = tmp!.next;
    }
  	}
  }






}
