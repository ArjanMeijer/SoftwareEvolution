module Complexity

import CodeParser;
import IO;
import List;
import ParseTree;
import util::FileSystem;
import util::ValueUI;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import util::Math;

public int GetComplexityScore(set[loc] projectFiles){
	return RiskToScore(Shrink([FileScore(y) | x <- projectFiles, y := createAstFromFile(x, false)]));
}

private list[int] FileScore(value x){
	list[int] complexities = [];
	visit(x){
		case \method(_,_,_,_,i) : complexities += cyclomaticComplexity(i);
	}
	return complexities;
}

public list[int] Shrink(list[list[int]] values)
{
	list[int] res = [];
	for(list[int] val <- values)
		res += val;
	return res;
}

private void CreateFile(list[int] values){
	map[int,int] scores = ();
	for(val <- values)
	{
		if(val notin scores)
			scores += (val:1);
		else
			scores[val] += 1;
	}
	str fileContent = "";
	for(line <- ["<z> : <scores[z]>"| z <- [0 .. max(values)], z in values])
		fileContent += "\t\t\t <line> \n";
	println(fileContent);
}

public int RiskToScore(list[int] values)
{
	CreateFile(values);
	list[num] risks = [ToRisk(x) | x <- values];
	num low = size([x | x <- risks, x == 0.0])/ toReal(size(risks));
	num moderate = size([x | x <- risks, x == 1.0]) / toReal(size(risks));
	num high = size([x | x <- risks, x == 2.0]) / toReal(size(risks));
	num extreme = size([x | x <- risks, x == 3.0]) / toReal(size(risks));
	
	println("\t\t- Categories & percentages");
	println("\t\t    Low         (1 -10):      <low * 100>");
	println("\t\t    Moderate    (10-20):      <moderate * 100>");
	println("\t\t    High        (20-50):      <high * 100>");
	println("\t\t    Extreme     ( \> 50):      <extreme * 100>");
	
	
	if(moderate <= .25 && high <= 0 && extreme <= 0)
		return 5;
	else if(moderate <= 0.3 && high <= 0.05 && extreme <= 0)
		return 4;
	else if(moderate <= 0.4 && high <= 0.1 && extreme <= 0)
		return 3;
	else if(moderate <= 0.5 && high <= 0.15 && extreme <= 0.05)
		return 2;
	else
		return 1;
}

public num ToRisk(int i)
{
	if( i <= 10)
		return 0.0;
	else if (i <= 20)
		return 1.0;
	else if (i <= 50)
		return 2.0;
	else
		return 3.0;
}

private int cyclomaticComplexity(value m) {
  int result = 1;
  visit (m) {
    case \do(b,c): result += 1;
    case \while(c,b): result += 1;
    case \if(c,t,e): result += AnalyzeIf(c);
    case \if(c,t): result += AnalyzeIf(c);
    case \for(i,c,u,b): result += 1;
    case \for(i,u,b): result += 1;
    case \switch (e,s): result += 1;
    case \case (e) : result += 1;
    case \try (b,c) : result += 1;
    case \try (b,c,f) : result += 1;
    case \catch (e,b) : result += 1;
  }
  return result;
}

private int AnalyzeIf(value c){
	result = 1;
	visit(c){
		case \infix(lhs, op, rhs) : result += (op == "&&" || op == "||")? 1 : 0;
	}	
	return result;
}