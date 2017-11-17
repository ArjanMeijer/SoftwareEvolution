module LineCounter

import String;
import List;

public int LinesOfCode(str lines){
	return size([line | line <- split("\n", lines), size(line) > 2]); 
}