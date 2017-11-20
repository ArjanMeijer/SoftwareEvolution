module CommentRemover

import String;

public str RemoveComments(str line){
	list[str] chars = split("", line);
	bool isString = false;
	bool isComment = false;
	bool isMComment = false;
	str result = "";
	str lastChar = "";
	int skip = 0;
	for(c <- chars){
		// Toggle string
		if(c == "\"" && !isComment)
			isString = !isString;
		
		// Start comment check
		if(!isString && lastChar == "/")
		{
			if(c == "/")
				isComment = true;
			if(c == "*")
				isMComment = true;
		// End line comment Check
		} else if(isComment && lastChar == "\n"){
			isComment = false;
			skip = 1;
		// End multilineComment check
		} else if(isMComment && lastChar == "*" && c == "/")
		{
			isMComment = false;
			skip = 2;
		};
		
		// Add character to result
		if(!isComment && !isMComment && skip == 0)
			result += lastChar;
		else if(skip > 0)
			skip -= 1;
		
		// Update Last value
		lastChar = c;
	};
	
	// Add last value to result
	if(!isComment && !isMComment && skip == 0)
		result += lastChar;
	return result;
}