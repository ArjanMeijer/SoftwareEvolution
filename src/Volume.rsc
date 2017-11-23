module Volume

import LineCounter;
import CommentRemover;
import util::FileSystem;
import List;
import IO;
import util::Math;

public int GetVolume(set[loc] projectFiles){
	return score = toInt(sum([RemoveComments(readFile(x))[1] | x <- projectFiles]));
}

public int GetVolumeScore(int volume){
	println("\t\t- Total volume:<volume>");
	
	if(volume < 66000)
		return 5;
	else if(volume < 246000)
		return 4;
	else if(volume < 665000)
		return 3;
	else if(volume < 1310000)
		return 2;
	else
		return 1;
}