module LineCounterTest

import LineCounter;
import IO;

test bool ConcatCodeLinesTest() {
	lines = ["Pieter", "Henk", "Arjan", "Niels"];
	concatValue = "{ENDOFLINE}";
	
	return ConcatList(lines, concatValue) == "Pieter{ENDOFLINE}Henk{ENDOFLINE}Arjan{ENDOFLINE}Niels{ENDOFLINE}";
}

test bool RemoveFromStringTest(){
	str testString =	 "hallo mijnaam /* blahblah */is Pieter./*blah*/ Henk is boos dat zijn naam niet genoemd wordt.";
	str cleanString = RemoveFromString(testString, "/*", "*/");

	return "hallo mijnaam is Pieter. Henk is boos dat zijn naam niet genoemd wordt." == cleanString;
}

test bool RemoveCommentsTest(){
	
	list[str] code = ["", "/*", "author: Arjan Meijer", "*/", "public void Test(){", "println(\"Hello world!\");", "}" ];
	list[str] withoutComments = RemoveComments(code);
	
	return ["public void Test(){","println(\"Hello world!\");","}"] == withoutComments;
}

test bool CountLinesTest() {
	list[str] code = ["", "/*", "author: Arjan Meijer", "*/", "public void Test(){", "println(\"Hello world!\");", "}" ];

	return CountLines(code) == 3;
}