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

private num GetPercentage(lrel[str, str] contents)
{
	list[str] methods = [];
	lrel[str, str] tests = [];
	for(tuple[str,str] val <- contents)
		if(startsWith(val[0], "test"))
			tests += val;
		else
			methods += val[0];
	
	list[str] notUsed = methods;
	for(tuple[str,str] t <- tests)
		notUsed = [x | x <- notUsed, !contains(t[1], x)];
	return 1 - (toReal(size(notUsed))/toReal(size(methods)));
}


