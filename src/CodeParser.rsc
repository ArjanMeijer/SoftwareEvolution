module CodeParser

import String;
import IO;
import util::ValueUI;
import util::FileSystem;
//import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
//import lang::java::m3::AST;
//import ParseTree;


public M3 GetModel(loc project){
	return createM3FromEclipseProject(project);
}

public list[tuple[loc,loc,str]] Parse(M3 model, str project){
	return [<MethodToFile(x, project), x, readFile(x)> | x <- methods(model)];	
}

public loc MethodToFile(loc method, str project)
{
	return toLocation( project + "/src" + method.parent.path + ".java");
}




/*
public list[loc] ProjectToFiles(loc project)
{
	return [x | /file(x) <- crawl(project), x.extension == "java"];
}

public list[tuple[loc,tuple[loc,str]]] FilesToUnits(list[loc] files, str project)
{
	x = [<x, [GetMethod(y, project)| y <- methods(createM3FromFile(x))]> | x <- files];
	text(x);
	return x;
	//return [];
} 

private tuple[loc, str] GetMethod(loc method, str project)
{
	println(MethodToFile(method,project));
	return <method, readFile(method)>;
}
*/
