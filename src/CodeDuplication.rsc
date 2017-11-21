module CodeDuplication

import List;
import String;
import IO;
import util::ValueUI;
import util::Math;
public num GetDuplication(list[str] moduleContents)
{
	lrel[str, lrel[tuple[int,int],bool]] index = CreateIndex(moduleContents);
	real duplicatedLines = 0.0;
	for(line <- index)
	{
		list[lrel[int,int]] duplicates = [RDuplicate(line[1], t, index, 0) | t <- line[1]];
		for(lrel[int,int] dList <- duplicates)
			for(tuple[int,int] d <- dList)
			{
				if(d[0] > 0 && d[1] > 0 && index[d[0]][1][d[1]][1] != true)
				{
					println(index[d[0]][1][d[1]]);

					lrel[tuple[int,int],bool] tVals = index[d[0]][1];
					tVals[d[1]][1] = true;
					index[d[0]][1] = tVals;

					duplicatedLines += 1;
				};
			};
	};
	return duplicatedLines/toReal(size(index));
}


private lrel[int,int] RDuplicate(lrel[tuple[int,int],bool] values, tuple[tuple[int,int],bool] target, lrel[str,lrel[tuple[int,int],bool]] index, int currentLevel){
	lrel[int,int] result = [];
	values -= target;
	same = [index[x][1][y] | <<x,y>,z> <- values, x == target[0][0] && x != -1];
	if(size(same) <= 0)
	{
		if(currentLevel >= 6)
			return [target[0]];
		else
			return [];
	};

	lrel[int,int] res = RDuplicate(same, index[target[0][0]][1][target[0][1]], index, currentLevel + 1);
	if(size(res) > 0)
		result += (res + [target[0]]);
	return result;
}




private lrel[str, lrel[tuple[int,int],bool]] CreateIndex(list[str] modules){
	lrel[str, lrel[tuple[int,int],bool]] index = [];
	list[str] lIndex = [];
	for(m <- modules)
	{
		list[str] lines = split("\n", m);
		tuple[int,int] last = <-1,-1>;
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
			index[pos][1] += [<last, false>];
			last = <pos, size(index[pos][1]) -1>;
			i -= 1;
		};
	};
	return index;
}


