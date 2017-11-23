module Tests::CodeDuplicationTest

import IO;
import CommentRemover;
import CodeDuplication;

test bool CodeDuplicationTest() {

	loc file = |project://SIGAnalayser/src/Tests/TestFiles/testFile.java|;
	
	
	code = [RemoveComments(readFile(file))[0]];
	
	println(GetDuplication(code));
	
	return 21 == GetDuplication(code);
}