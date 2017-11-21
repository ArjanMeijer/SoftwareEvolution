module Volume

import LineCounter;
import CommentRemover;
import util::FileSystem;
import List;
import IO;

public int GetVolumeScore(loc project){
	num score = GetVolume(project);
	if(score < 66000)
		return 5;
	else if(score < 246000)
		return 4;
	else if(score < 665000)
		return 3;
	else if(score < 1310000)
		return 2;
	else
		return 1;
}

private num GetVolume(loc project){
	return sum([LinesOfCode(RemoveComments(readFile(x))) | /file(x) <- crawl(project), x.extension == "java"]);
}