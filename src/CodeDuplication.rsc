module CodeDuplication

import List;
import String;
import IO;
import util::ValueUI;
import util::Math;

public int GetDuplicationScore(list[str] unitLines)
{
	num res = GetDuplication(unitLines);
	if(res <= 0.03)
		return 5;
	else if (res <= 0.05)
		return 4;
	else if(res <= 0.1)
		return 3;
	else if (res <= 0.2)
		return 2;
	else
		return 1;
}

private num GetDuplication(list[str] moduleContents)
{
	lrel[str, lrel[int,int,bool]] index = CreateIndex(moduleContents);
	real duplicatedLines = 0.0;
	for(line <- index)
	{
			list[lrel[int,int]] duplicates = [RDuplicate(line[1], t, index, 0) | t <- line[1]];
			
			for(lrel[int,int] dList <- duplicates)
				for(tuple[int,int] d <- dList)
				{
					if(d[0] > 0 && d[1] > 0 && index[d[0]][1][d[1]][2] != true)
					{
						lrel[int,int,bool] tVals = index[d[0]][1];
						tVals[d[1]][2] = true;
						index[d[0]][1] = tVals;
						
						duplicatedLines += 1;
					};
				};
	};
	return duplicatedLines/toReal(size(index));
}


private lrel[int,int] RDuplicate(lrel[int,int,bool] values, tuple[int,int,bool] target, lrel[str,lrel[int,int,bool]] index, int currentLevel){
	lrel[int,int] result = [];
	values -= target;
	same = [];
	
	if(target[0] != -1)
		same = [index[x][1][y] | <x,y,z> <- values, x == target[0] && x != -1];
	
	if(size(same) <= 0)
	{
		if(currentLevel >= 6)
			return [<target[0],target[1]>];
		else
			return [];
	};

	lrel[int,int] res = RDuplicate(same, index[target[0]][1][target[1]], index, currentLevel + 1);
	if(size(res) > 0)
		result += (res + [<target[0],target[1]>]);
	return result;
}

private lrel[str, lrel[int,int,bool]] CreateIndex(list[str] modules){
	lrel[str, lrel[int,int,bool]] index = [];
	list[str] lIndex = [];
	for(m <- modules)
	{
		list[str] lines = split("\n", m);
		tuple[int,int, bool] last = <-1,-1,false>;
		int i = size(lines) - 1;
		while(i >= 0)
		{
			str line = trim(lines[i]);
			int pos = indexOf(lIndex, line);
			if(pos == -1){
				lIndex += line;
				index += <line, []>;
				pos = size(index) - 1;
			};
			index[pos][1] += [last];
			last = <pos, size(index[pos][1]) -1, false>;
			i -= 1;
		};
	};
	return index;
}