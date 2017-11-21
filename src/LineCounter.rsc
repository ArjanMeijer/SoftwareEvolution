module LineCounter

import String;
import List;
import Complexity;

public int GetUnitSizeScore(list[str] units){
	return RiskToScore([LinesOfCode(x) | x <- units]);
}

public int LinesOfCode(str lines){
	return size([line | line <- split("\n", lines), size(line) > 2]); 
}