module Main

import util::ValueUI;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import ParseTree;

import IO;
import List;
import String;
import CodeParser;
import CommentRemover;
import LineCounter;
import Complexity;
import LineCounterTest;


public void Main() {
	println("SIG Analyser");
	loc project = |project://smallsql0.21_src|;
	
	M3 model = GetModel(project);
	num volume = GetVolume(project);
	println(volume);
	lrel[loc,CodeUnit, str] methods = Parse(model);
	list[int] lengths = ModuleLengths(methods);
	list[int] complexity = ModuleComplexity(methods);
}

private list[int] ModuleLengths(lrel[loc,CodeUnit, str] modules){
	return [LinesOfCode(RemoveComments(x)) | <_,_,x> <- modules];
}

private list[int] ModuleComplexity(lrel[loc,CodeUnit, str] modules){
	return [GetComplexity(x) | <_,x,_> <- modules];
}

private num GetVolume(project){
	return 0;//sum({LinesOfCode(RemoveComments(readFile(x))) | /file(x) <- crawl(project), x.extension == "java"});
}