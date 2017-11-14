module Main

import IO;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import util::ValueUI;

import LineCounter;
import LineCounterTest;


public void Main() {
	println("SIG Analyser");
	
	// We don't need the M3 model yet.
	// m = createM3FromEclipseProject(|project://smallsql0.21_src|);
	
	loc file = |project://smallsql0.21_src/src/smallsql/tools|;
 //	x = createM3FromDirectory(file);
	//text(x);
	
	text(GetUnits(["{", "/*", "author: Arjan Meijer", "*/", "public void Test(){", "println(\"Hello world!\");", "}", "public void Nope(){","someMethodCall(someInput);", "and a calculation", "}", "}" ]));
	
	loc folder = |project://smallsql0.21_src/src/smallsql/|;
	//loc folder = |project://hsqldb-2.3.1|;
	
	int volume = GetVolume(folder);
	println("Volume: <volume>");
}