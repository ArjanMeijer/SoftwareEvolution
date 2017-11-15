module Main

import IO;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import util::ValueUI;

import LineCounter;
import Complexity;
import LineCounterTest;


public void Main() {
	println("SIG Analyser");
	
	loc file = |project://smallsql0.21_src/src/smallsql/tools|;

	//text(GetUnits(["{", "/*", "author: Arjan Meijer", "*/", "public void Test(){", "println(\"Hello world!\");", "}", "public void Nope(){","someMethodCall(someInput);", "and a calculation", "}", "}" ]));
	
	list[str] code = ["{", "/*", "author: Arjan Meijer", "*/", "public void Test(){", "println(\"Hello world!\");", "}", "public void Nope(){","someMethodCall(someInput);", "and a calculation", "}", "}" ];
	str conccated = ConcatList(code, "");
	
	println(GetComplexity(conccated));
	
	
	
	loc folder = |project://smallsql0.21_src/src/smallsql/|;

	int volume = GetVolume(folder);
	println("Volume: <volume>");
}