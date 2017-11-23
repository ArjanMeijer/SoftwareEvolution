module Tests::CodeDuplicationTest

import IO;
import CommentRemover;
import CodeDuplication;

test bool CodeDuplicationTest() {
	loc file = |project://SIGAnalayser/src/Tests/TestFiles/testFile.java|;
	code = [RemoveComments(readFile(file))[0]];	
	return 21 == GetDuplication(code);
}

test bool CodeDuplicationTest() {
	loc file = |project://SIGAnalayser/src/Tests/TestFiles/testFile2.java|;
	code = [RemoveComments(readFile(file))[0]];	
	return 14 == GetDuplication(code);
}