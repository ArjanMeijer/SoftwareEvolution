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
	list[lrel[int,int,bool]] index = CreateIndex(moduleContents);
	println("\t\t - Created index");
	real duplicatedLines = 0.0;
	for(line <- index)
	{
		// line = lrel[int,int,bool]
		list[lrel[int,int]] duplicates = [RDuplicate(line, t, index, 0) | t <- line];
			for(lrel[int,int] dList <- duplicates)
				for(tuple[int,int] d <- dList)
					if(d[0] > 0 && d[1] > 0 && index[d[0]][d[1]][2] != true)
					{
						index[d[0]][d[1]][2] = true;					
						duplicatedLines += 1;
					};
	};
	return duplicatedLines/toReal(size(index));
}


private lrel[int,int] RDuplicate(lrel[int,int,bool] values, tuple[int,int,bool] target, list[lrel[int,int,bool]] index, int currentLevel){
	lrel[int,int] result = [];
	values -= target;
	same = [];
	
	if(target[0] != -1)
		same = [index[x][y] | <x,y,z> <- values, x == target[0] && x != -1];
	
	if(size(same) <= 0)
	{
		if(currentLevel >= 6)
			return [<target[0],target[1]>];
		else
			return [];
	};

	lrel[int,int] res = RDuplicate(same, index[target[0]][target[1]], index, currentLevel + 1);
	if(size(res) > 0)
		result += (res + [<target[0],target[1]>]);
	return result;
}

private list[lrel[int,int,bool]] CreateIndex(list[str] modules){
	list[lrel[int,int,bool]] index = [];
	list[str] lIndex = [];
	for(m <- modules)
	{
		list[str] lines = split("\n", m);
		tuple[int,int, bool] last = <-1,-1,false>;
		int i = size(lines) - 1;
		
		while(i >= 0)
		{
			str line = trim(lines[i]);
			if(size(line) > 1)
			{
				int pos = indexOf(lIndex, line);
				if(pos == -1){
					lIndex += line;
					index += [[]];
					pos = size(index) - 1;
				};
				index[pos] += [last];
				last = <pos, size(index[pos]) -1, false>;
			};
			i -= 1;
		};
	};
	return index;
}