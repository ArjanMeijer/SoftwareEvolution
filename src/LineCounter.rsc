module LineCounter

import String;
import List;
import Complexity;

public int GetUnitSizeScore(list[int] counts){
	return RiskToScore(counts);
}

public int LinesOfCode(str lines){
	return size([line | line <- split("\n", lines)]); 
}