module CodeParser

import String;
import List;
import IO;
import lang::java::jdt::m3::Core;
import CommentRemover;

public M3 GetModel(loc project) = createM3FromEclipseProject(project);

public lrel[str, str] Parse(M3 model) = [<LocToMethod(x), y> | x <- methods(model), y := readFile(x)];

private str LocToMethod(loc l) = split("(",last(split("/", l.path)))[0];