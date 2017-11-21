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

public lrel[str,CodeUnit, str] Parse(M3 model){
	return [<LocToMethod(x), GetCodeUnit(y), y> | x <- methods(model), y := readFile(x)];
}

private str LocToMethod(loc l)
{
	list[str] parts = split("/", l.path);
	return split("(",parts[size(parts) - 1])[0];
}

public CodeUnit GetCodeUnit(str content){
	str input = RemoveComments(content);
	return [m | /CodeUnit m := parse(#start[CodeUnit], input,allowAmbiguity=true)][0]; 
}
