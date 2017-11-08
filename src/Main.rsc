module Main

import IO;
import lang::java::jdt::m3::Core;

public void Main() {
	println("Hello world!");
	
	m = createM3FromEclipseProject(|project://smallsql0.21_src|);
	println(m);
}