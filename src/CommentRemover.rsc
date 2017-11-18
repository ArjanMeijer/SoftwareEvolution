module CommentRemover

import String;
import List;
import IO;
import util::ValueUI;
import util::FileSystem;


public str RemoveComments(str line){
	str lineSplitter = "\n";
	list[str] lines = split(lineSplitter, line);
	// Initialize withoutComments and remove all the // comments.
	list[str] withoutComments = [RemoveDSComment(trim(x)) | x <- lines];
	str concattedCode = ConcatList(withoutComments);

	// Remove all the test between /* */
	return RemoveFromString(concattedCode, "/*", "*/");
}

public str RemoveDSComment(str line)
{
	list[str] chars = split("", line);
	bool isString = false;
	bool isComment = false;
	str result = "";
	str lastChar = "";
	for(c <- chars){
		if(c == "\"" && !isComment)
			isString = !isString;
		
		if(!isString && lastChar == "/" && c == "/")
			isComment = true;
		
		if(!isComment)
			result += lastChar;
		lastChar = c;
	};
	
	if(!isComment)
		result += lastChar;
	return result;
}

public str ConcatList(list[str] lines){
	str result  = "";
	for(line <- lines)
		result += line;
	return result;
}

public str RemoveFromString(str subject, str begin, str end)
{
	list[str] parts = split(end, subject);
	str result = "";
	for(part <- parts){
		if(!startsWith(part,begin))
		{
			if(contains(part, begin))
			{
				result += split(begin,part)[0];
			}else{
				result += part;
			};
		};
	};
	return result;
}