module Main

import util::ValueUI;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import ParseTree;
import CodeDuplication;

import IO;
import List;
import String;
import CodeParser;
import CommentRemover;
import LineCounter;
import Complexity;
import LineCounterTest;
import CommentCodeRatio;
import Volume;

public void Main() {
	println("SIG Analyser");
	loc project = |project://smallsql0.21_src|;
	loc largeProject = |project://hsqldb-2.3.1|;
	
	M3 model = GetModel(project);
	lrel[loc,CodeUnit, str] methods = Parse(model);
	
	res = GetDuplication([trim(RemoveComments(x[2])) | x <- methods]);
	println(res);
	
	/*str volume = VolumeScore(project);
	list[num] lengths = ModuleLengths(methods);
	list[num] complexity = ModuleComplexity(methods);
	list[num] codeCommentRatio = CodeCommentRatio(methods);*/
}

private list[num] ModuleLengths(lrel[loc,CodeUnit, str] modules){
	return [LinesOfCode(RemoveComments(x)) | <_,_,x> <- modules];
}

private list[num] ModuleComplexity(lrel[loc,CodeUnit, str] modules){
	return [GetComplexity(x) | <_,x,_> <- modules];
}

private list[num] CodeCommentRatio(lrel[loc,CodeUnit,str] modules){
	return [GetCommentCodeRatio(x) | <_,_,x> <- modules];
}