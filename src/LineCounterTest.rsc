module LineCounterTest

import LineCounter;
import IO;

test bool ConcatCodeLinesTest() {
	lines = ["Pieter", "Henk", "Arjan", "Niels"];
	concatValue = "{ENDOFLINE}";
	
	return ConcatList(lines, concatValue) == "Pieter{ENDOFLINE}Henk{ENDOFLINE}Arjan{ENDOFLINE}Niels{ENDOFLINE}";
}

