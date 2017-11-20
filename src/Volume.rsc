module Volume

import LineCounter;
import CommentRemover;
import util::FileSystem;
import List;
import IO;

public str VolumeScore(loc project){
	num score = GetVolume(project);
	if(score < 66000)
		return "++";
	else if(score < 246000)
		return "+";
	else if(score < 665000)
		return "o";
	else if(score < 1310000)
		return "-";
	else
		return "--";
}

private num GetVolume(loc project){
	return sum([LinesOfCode(RemoveComments(readFile(x))) | /file(x) <- crawl(project), x.extension == "java"]);
}