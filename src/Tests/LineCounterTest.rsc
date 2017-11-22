module Tests::LineCounterTest

import LineCounter;
import IO;

test bool LinesOfCodeTest() {
	str file = "firstline\nsecondline\nthirdline";
	return LinesOfCode(file) == 3;
}

test bool LinesOfCodeTestSlashTrick() {
	// The line counter shouldn't trigger on the second slash, since it is not followed by a n.
	str file = "firstline\nsecondline\thirdline";
	
	return LinesOfCode(file) == 2;
}