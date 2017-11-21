module CodeParser

import String;
import IO;
import util::ValueUI;
import util::FileSystem;
import lang::java::jdt::m3::Core;
import CommentRemover;
import lang::java::\syntax::Java15;
import lang::java::\syntax::Disambiguate;

start syntax CodeUnit = MethodDec | ConstrDec method;

public M3 GetModel(loc project){
	return createM3FromEclipseProject(project);
}

public lrel[loc,CodeUnit, str] Parse(M3 model){
	return [<x, GetCodeUnit(y), y> | x <- methods(model), y := readFile(x)];
}

public CodeUnit GetCodeUnit(str content){
	str input = RemoveComments(content);
	return [m | /CodeUnit m := parse(#start[CodeUnit], input,allowAmbiguity=true)][0]; 
}
