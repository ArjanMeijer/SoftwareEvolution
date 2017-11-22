module Tests::CommentRemoverTests

import CommentRemover;
import IO;

test bool RemoveCommentTest() {	
	str code = "// blah blah blah";
	return <"", 0> == RemoveComments(code);
}

test bool RemoveCommentTest() {	
	str code = "// blah blah blah\nblah\n/*\nblahblah\n*/";
	return <"blah\n", 1> == RemoveComments(code);
}