module CommentRemover

import String;
import List;
import IO;

public tuple[str,int] RemoveComments(str line){
	bool isString = false;
	bool isComment = false;
	bool isMComment = false;
	str result = "";
	str lastChar = "";
	int skip = 0;
	int lines = 0;
	int index = 0;
	while(index < size(line)){
		str c = line[index];
		// Toggle string
		if(c == "\"" && !isComment)
			isString = !isString;
		
		// Start comment check
		if(!isString){
			if(lastChar == "/")
			{
				if(c == "/")
					isComment = true;
				else if(c == "*")
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
		};
		
		if(lastChar == "\n" && c == "\n" && skip == 0)
			skip = 1;
		
		// Add character to result
		if(!isComment && !isMComment && skip == 0 && lastChar != "\t" && lastChar != "\r")
		{
			result += lastChar;
			if(lastChar == "\n")
				lines += 1;
		}
		else if(skip > 0)
			skip -= 1;
		
		// Update Last value
		lastChar = c;
		index += 1;
	};
	
	// Add last value to result
	if(!isComment && !isMComment && skip == 0 && lastChar != "\t" && lastChar != "\r")
	{
		result += lastChar;
		if(lastChar == "\n")
			lines += 1;
	}
	return <result, lines>;
}