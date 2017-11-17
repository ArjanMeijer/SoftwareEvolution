module Main

import IO;
import util::ValueUI;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import ParseTree;

import IO;
import List;
import String;
import lang::java::\syntax::Java15;
import util::ValueUI;
import CodeParser;
import CommentRemover;
import LineCounter;
import Complexity;
import LineCounterTest;


public void Main() {
	println("SIG Analyser");
	str project = "project://smallsql0.21_src";
	loc projectLocation = toLocation(project);
	
	
	//text(methods(createM3FromEclipseProject(toLocation(project))));
	//text(FilesToUnits(ProjectToFiles(toLocation(project)), project));
	
	M3 model = GetModel(projectLocation);
	list[tuple[loc, loc,str]] methods = Parse(model, project);
	text(methods);
	list[int] lengths = ModuleLengths(methods);
	text(lengths);
	list[int] complexity = [GetComplexity(x) | x <- methods];
	//text(complexity);

}

private list[int] ModuleLengths(list[tuple[loc, loc,str]] modules){
	return [LinesOfCode(x) | <_,_,x> <- modules];
}

private list[int] ModuleComplexity(list[tuple[loc,str]] modules){
	return [];
}