module Complexity

import CodeParser;
import IO;
import List;
import Exception;
import ParseTree;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::\syntax::Java15;
import lang::java::\syntax::Disambiguate;
import util::Math;

public int GetComplexityScore(list[CodeUnit] units){
	return RiskToScore([cyclomaticComplexity(x) | x <- units]);
}

public int RiskToScore(list[int] values)
{
	list[num] risks = [ToRisk(x) | x <- values];
	num moderate = size([x | x <- risks, x == 1.0]) / toReal(size(risks));
	num high = size([x | x <- risks, x == 2.0]) / toReal(size(risks));
	num extreme = size([x | x <- risks, x == 3.0]) / toReal(size(risks));
	
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

private int cyclomaticComplexity(CodeUnit m) {
  int result = 1;
  visit (m) {
    case (Stm)`do <Stm _> while (<Expr _>);`: result += 1;
    case (Stm)`while (<Expr _>) <Stm _>`: result += 1;
    case (Stm)`if (<Expr _>) <Stm _>`: result +=1;
    case (Stm)`if (<Expr _>) <Stm _> else <Stm _>`: result +=1;
    case (Stm)`for (<{Expr ","}* _>; <Expr? _>; <{Expr ","}*_>) <Stm _>` : result += 1;
    case (Stm)`for (<LocalVarDec _> ; <Expr? e> ; <{Expr ","}* _>) <Stm _>`: result += 1;
    case (Stm)`for (<FormalParam _> : <Expr _>) <Stm _>` : result += 1;
    case (Stm)`switch (<Expr _> ) <SwitchBlock _>`: result += 1;
    case (SwitchLabel)`case <Expr _> :` : result += 1;
    case (CatchClause)`catch (<FormalParam _>) <Block _>` : result += 1;
  }
  return result;
}