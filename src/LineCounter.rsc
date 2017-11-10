module LineCounter

import IO;
import util::FileSystem;
import String;
import List;

public int CountLines(list[str] lines){
	return size(RemoveComments(lines));
}

// Returns a list of tuples <loc file, list[str] lines>
public rel[loc, list[str]] ReadFiles (loc dir) {
	set[loc] files = visibleFiles(dir);

	return {<x, readFileLines(x)>|x <- files};
}

public list[str] RemoveComments(list[str] lines){

	// Initialize withoutComments and remove all the // comments.
	list[str] withoutComments = [x | x <- lines, !startsWith(x, "//")];
	
	str lineSplitter = "{ENDOFLINE}";
	str concattedCode = ConcatList(lines, lineSplitter);

	// Remove all the test between /* */
	str codeWithoutComments = RemoveFromString(concattedCode, "/*", "*/");
	
	// Split the string so we get our lines of code back.
	withoutComments = split(lineSplitter, codeWithoutComments);

	// Reomve all the empty lines.
	return [x| x <- withoutComments, x != ""];
}

public str ConcatList(list[str] lines, str concatValue){
	str result  = "";
	
	for(line <- lines) {
		result += line + concatValue;
	};

	return result;
}

public str RemoveFromString(str subject, str begin, str end)
{
	str result = "";	
	list[str] splitted = split(begin, subject);

	for(x <- splitted){
		if (contains(x, end)){
			y = split(end, x);
			
			if(size(y) > 1){
				x = y[1];
			}
		}
		
		result += x;
	};
	
	return result;
}






