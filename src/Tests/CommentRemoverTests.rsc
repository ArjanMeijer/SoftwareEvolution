module Tests::CommentRemoverTests

import CommentRemover;
import IO;

test bool RemoveCommentTest1() {	
	str code = "// blah blah blah";
	return <"", 0> == RemoveComments(code);
}

test bool RemoveCommentTes2() {	
	str code = "// blah blah blah\nblah\n/*\nblahblah\n*/";
	return <"blah\n", 1> == RemoveComments(code);
}

test bool RemoveCommentTest3() {
	str code = "/* comment */
				public string ToString() {
					// some inline comment
					
				}";
	return <"\npublic string ToString() {\n\n}",3> == RemoveComments(code);
}