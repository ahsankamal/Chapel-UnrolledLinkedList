config const testParam: bool = true;

use UnitTest;
use UnrolledLinkedList;

proc testInsert(test: borrowed Test) throws{
	var url = new UnrolledLinkedList(int, 1);
	url.insert(100);
	url.insert(200);
	url.insert(300);
	url.insert(400);
	url.insert(500);
	test.assertEqual(url.size, 5);
}

UnitTest.main();