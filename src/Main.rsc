module Main

import util::ValueUI;
import util::FileSystem;
import util::Math;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import ParseTree;
import CodeDuplication;

import IO;
import List;
import String;
import CodeParser;
import CommentRemover;
import LineCounter;
import Complexity;
import LineCounterTest;
import CommentCodeRatio;
import Volume;
import TestAnalyzer;
import DateTime;

public void Main() {
	println("SIG Analyser - Assignment \nBy Niels Boerkamp and Arjan Meijer.");
	println("Implementation of the SIG model as described in:\n\t\"A Practical Model for Measuring Maintainability\"");
	println("\t By Ilja Heitlager, Tobias Kuipers and Joost Visser");
	println("\n\n");
	
	loc project = |project://smallsql0.21_src|;
	
	println("--- Progress ---");
	println("\t-- Creating M3 Model");
	M3 model = GetModel(project);
	
	println("\t-- Parsing Units");
	lrel[str,CodeUnit,str] units = Parse(model);
		
	println("\t-- Calculating Volume Score");
	int volumeScore = GetVolumeScore(project);
	
	println("\t-- Calculating Unit Complexity Score");
	int unitComplexityScore = GetComplexityScore([x | <_,x,_> <- units]);

	println("\t-- Calculating Code Duplication Score");
	int codeDuplicationScore =  GetDuplicationScore([x | <_,_,x> <- units]);

	println("\t-- Calculating Unit Size Score");
	int unitSizeScore = GetUnitSizeScore([RemoveComments(x) | <_,_,x> <- units]);
	
	println("\t-- Calculating Test score");
	int testingScore = GetTestScore([<x,y> | <x,_,y> <- units]);
	
	println("\t-- Calculating Overall Score");
	int overallScore = AvgScore([volumeScore, unitComplexityScore, codeDuplicationScore, unitSizeScore, testingScore]);
	
	int analyzabilityScore = AvgScore([volumeScore, codeDuplicationScore, unitSizeScore, testingScore]);
	int changeabilityScore = AvgScore([unitComplexityScore, codeDuplicationScore]);
	int stabilityScore = AvgScore([testingScore]);
	int testabilityScore = AvgScore([unitComplexityScore, unitSizeScore, testingScore]);
	
	println("\n--- Results ---");
	println("\tOverall Score: \t\t" + ScoreToString(overallScore));
	println("\tVolume Score: \t\t" + ScoreToString(volumeScore));
	println("\tUnit Complexity Score:  " + ScoreToString(unitComplexityScore));
	println("\tCode Duplication Score: " + ScoreToString(codeDuplicationScore));
	println("\tUnit Size Score:  \t" + ScoreToString(unitSizeScore));
	println("\tUnit Testing Score:  \t" + ScoreToString(testingScore));
	
	println("\n--- Specifications ---");
	println("\tAnalyzability Score: \t" + ScoreToString(analyzabilityScore));
	println("\tChangeability Score: \t" + ScoreToString(changeabilityScore));
	println("\tStability Score: \t" + ScoreToString(stabilityScore));
	println("\tTestability Score: \t" + ScoreToString(testabilityScore));
}

private int AvgScore(list[int] scores)
{
	return round(sum([toReal(x) | x <- scores])/toReal(size(scores)));
}

private str ScoreToString(int score)
{
	return ["","--", "-", "o", "+", "++"][score];
}