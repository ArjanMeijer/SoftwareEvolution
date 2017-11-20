module CommentCodeRatio

import LineCounter;
import CommentRemover;

public num GetCommentCodeRatio(str lines){
	return LinesOfCode(RemoveComments(lines))/LinesOfCode(lines);
}