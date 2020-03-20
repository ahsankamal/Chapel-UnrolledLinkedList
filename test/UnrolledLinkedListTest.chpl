config const testParam: bool = true;

use UnitTest;
use UnrolledLinkedList;

proc testAppend(test: borrowed Test) throws{
	var url = new UnrolledLinkedList(int, 3);
	url.append(100);
	url.append(200);
	url.append(300);
	test.assertEqual(url.size, 3);
	url.append(400);
	url.append(500);
	test.assertEqual(url.size, 5);
}
proc testPop(test: borrowed Test) throws{
	var url = new UnrolledLinkedList(int, 3);
	url.append(100);
	url.append(200);
	url.append(300);
	url.append(400);
	url.append(500);
	test.assertEqual(url.pop(), 500);
	test.assertEqual(url.pop(), 400);
	test.assertEqual(url.pop(), 300);
	test.assertEqual(url.pop(), 200);
	test.assertEqual(url.pop(), 100);
	test.assertEqual(url.pop(), -1);
}


UnitTest.main();