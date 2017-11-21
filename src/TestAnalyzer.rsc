module TestAnalyzer

import IO;
import CodeParser;
import util::ValueUI;
import lang::java::\syntax::Java15;
import lang::java::\syntax::Disambiguate;

public void GetPercentage(lrel[CodeUnit,str] units)
{
	text([y | x <- units, /MethodDecHead m := x, /Id y := m]);
}