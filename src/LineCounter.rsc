module LineCounter

import String;
import List;

public num LinesOfCode(str lines){
	return size([line | line <- split("\n", lines), size(line) > 2]); 
}