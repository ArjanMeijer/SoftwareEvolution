module TestAnalyzer

import IO;
import CodeParser;
import util::ValueUI;
import lang::java::\syntax::Java15;
import lang::java::\syntax::Disambiguate;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import String;
import List;
import util::Math;

public int GetTestScore(lrel[str,str] units){
	num score = GetPercentage(units);
	if(score <= 0.2)
		return 1;
	else if(score <= 0.6)
		return 2;
	else if(score <= 0.8)
		return 3;
	else if(score <= 0.95)
		return 4;
	else
		return 5;
}

public num GetPercentage(lrel[str, str] contents)
{
	list[str] methods = [];
	list[str] tests = [];
	for(tuple[str,str] val <- contents)
		if(startsWith(val[0], "test"))
			tests += val[1];
		else
			methods += val[0];
	
	list[str] notUsed = methods;
	for(str t <- tests)
		notUsed = [x | x <- notUsed, !contains(t, x)];
	println("\t\t- Test found:        <size(tests)>");
	println("\t\t- Methods found:     <size(methods)>");
	println("\t\t- Tested methods:    <size(methods) - size(notUsed)>");
	num res = 1.0 - (toReal(size(notUsed))/toReal(size(methods)));
	println("\t\t- Tested percentage: <res * 100>");
	return res;
}


