module LineCounter

import IO;
import util::FileSystem;
import String;
import List;

// Returns a list of tuples <loc file, list[str] lines>
public rel[loc, list[str]] ReadFiles (loc dir) {
	set[loc] files = visibleFiles(dir);

	return {<x, readFileLines(x)>|x <- files};
}

public list[str] RemoveComments(list[str] lines){

	// Initialize withoutComments and remove all the // comments.
	withoutComments = [x | x <- lines, !startsWith(x, "//")];

	str concattedString = ConcatList(lines, "{ENDOFLINE}");
	
	
	

	return withoutComments;
}

public str ConcatList(list[str] lines, str concatValue){
	str result  = "";
	
	for(line <- lines) {
		result += line + concatValue;
	};

	return result;
}
