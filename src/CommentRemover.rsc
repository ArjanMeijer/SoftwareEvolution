module CommentRemover

import String;
import List;

public str RemoveComments(str line){

	str lineSplitter = "\n";
	list[str] lines = split(lineSplitter, line);
	// Initialize withoutComments and remove all the // comments.
	list[str] withoutComments = [x | x <- lines, !contains(x, "//")];
	str concattedCode = ConcatList(lines, lineSplitter);

	// Remove all the test between /* */
	return RemoveFromString(concattedCode, "/*", "*/");
}

public str ConcatList(list[str] lines, str concatValue){
	str result  = "";
	for(line <- lines)
		result += line + concatValue;
	return result;
}

public str RemoveFromString(str subject, str begin, str end)
{
	str result = "";	
	list[str] splitted = split(begin, subject);

	for(x <- splitted){
		if (contains(x, end)){
			y = split(end, x);
			
			if(size(y) > 1)
				x = y[1];
		};
		result += x;
	};
	
	return result;
}