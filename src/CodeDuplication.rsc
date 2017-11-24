module CodeDuplication

import List;
import String;
import Set;
import IO;
import util::ValueUI;
import util::Math;

public int GetDuplicationScore(list[str] unitLines, int volume)
{
	int duplications = GetDuplication(unitLines);
	println("\t\t- Duplicated lines:      <duplications>");
	num res = toReal(duplications)/toReal(volume);
	println("\t\t- Duplicated percentage: <res * 100>");
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

public int GetDuplication(list[str] moduleContents)
{
	list[lrel[int,int,bool]] index = CreateIndex(moduleContents);
	println("\t\t- Created Index");
	int duplicatedLines = 0;
	for(int i <- [0 .. size(index)])
		for(int j <- [0.. size(index[i])])
		{
			lrel[int,int] duplicates = RDuplicate(index[i], index[i][j], <i,j>, index, 1);
			for(tuple[int,int] d <- duplicates)
				if(index[d[0]][d[1]][2] != true)
				{
					index[d[0]][d[1]][2] = true;
					duplicatedLines += 1;
				};
		};
	return duplicatedLines;
}


private lrel[int,int] RDuplicate(lrel[int,int,bool] values, tuple[int,int,bool] target, tuple[int,int] current, list[lrel[int,int,bool]] index, int currentLevel){
	values -= target;
	same = [];
	
	if(target[0] != -1 && target[1] != -1 && target != index[target[0]][target[1]])
		same = [index[x][y] | <x,y,_> <- values, x == target[0]];
	
	if(size(same) == 0)
	{
		if(currentLevel >= 6)
			return [current];
	} else {
		lrel[int,int] res = RDuplicate(same, index[target[0]][target[1]], <target[0],target[1]>, index, currentLevel + 1);
		if(size(res) > 0)
			return (res + [current]);
	};
	return [];
}

private list[lrel[int,int,bool]] CreateIndex(list[str] modules){
	list[lrel[int,int,bool]] index = [];
	map[str,int] lineHash = ();
	int lineIndex = 0;

	for(body <- modules)
	{
		list[str] lines = split("\n", body);
		for(int i <- [0 .. size(lines)])
		{
			if(lines[i] notin lineHash)
			{
				lineHash += (lines[i]:lineIndex);		
				index += [[]];
				lineIndex += 1;	
			};
			
			index[lineHash[lines[i]]] += [<-1,-1,false>];
			if(i > 0)
				index[lineHash[lines[i-1]]][size(index[lineHash[lines[i-1]]])-1] = <lineHash[lines[i]], size(index[lineHash[lines[i]]]) - 1, false>;	
		};
	};
	return index;
}