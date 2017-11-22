module CommentCodeRatio

import LineCounter;
import CommentRemover;

public num GetCommentCodeRatio(str lines) = LinesOfCode(RemoveComments(lines))/LinesOfCode(lines);