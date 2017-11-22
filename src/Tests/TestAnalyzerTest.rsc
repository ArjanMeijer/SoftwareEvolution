module Tests::TestAnalyzerTest

import TestAnalyzer;

test bool GetPercentageTest() {

	lrel[str, str] contents = [
		<"methodName1", "methodcontent">,
		<"methodName2", "methodcontent">,
		<"methodName3", "methodcontent">,
		<"testMethod1", "methodName1">,	
		<"testMethod2", "methodName2, methodName3">
	];

	return 1.0 == GetPercentage(contents);
}

test bool GetPercentageTest() {

	lrel[str, str] contents = [
		<"methodName1", "methodcontent">,
		<"methodName2", "methodcontent">,
		<"testMethod1", "methodName1">
	];

	return .5 == GetPercentage(contents);
}