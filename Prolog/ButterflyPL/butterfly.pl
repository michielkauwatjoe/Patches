
initialise :-
	asserta(phi(1.618034)),
	asserta(documentheight(612)),
	asserta(documentwidth(1000)),
	asserta(iterations(10)).

run :-
	initialise,
	open('pattern00.svg', write, File),
	header(File),
	body(File),
	footer(File),
	close(File).

header(File) :-
	documentheight(Height),
	documentwidth(Width),

	write(File,'<?xml version="1.0" standalone="no"?>'),
	nl(File),
	write(File,'<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">'),
	nl(File),
	write(File,'<svg width="'),
	write(File, Width),	
	write(File,'px" height="'),
	write(File, Height),	
	write(File,'px" version="1.1" xmlns="http://www.w3.org/2000/svg">'),
	nl(File).

footer(File) :-
	nl(File),
	write(File,'</svg>').


body(File) :-
	documentwidth(Width),
	documentheight(Height),
	iterations(N),

	pattern(File,N),

	write(File,'<g transform="translate('),
	write(File,Width),
	write(File,',0) scale(-1,1)">'),
	nl(File),
	pattern(File,N),
	nl(File),
	write(File,'</g>'),

	write(File,'<g transform="translate(0,'),
	write(File,Height),
	write(File,') scale(1,-1)">'),
	nl(File),
	pattern(File,N),
	nl(File),
	write(File,'</g>'),

	write(File,'<g transform="translate('),
	write(File,Width),
	write(File,','),
	write(File,Height),
	write(File,') scale(-1,-1)">'),
	nl(File),
	pattern(File,N),
	nl(File),
	write(File,'</g>').


pattern(_,0).

pattern(File,N):-
	documentheight(Height),
	documentwidth(Width),
	linecoordinates(N,Width,Height,List),
	svgpath1(List,Path),
	nl(File),
	write(File,Path),
	N1 is N-1,
	pattern(File,N1).

linecoordinates(0,_,_,[]).

linecoordinates(N,W,H,[[X,Y]|Tail]):-
	random_ratio(W,X),
	random_ratio(H,Y),
	N1 is N-1,
	linecoordinates(N1,X,Y,Tail).


random_ratio(V1,V2):-
	I is random(2),
	random_ratio(I,V1,V2).

random_ratio(0,V1,V2):-
	ratio0(V1,V2).
	
random_ratio(1,V1,V2):-
	ratio1(V1,V2).

random_ratio(2,V1,V2):-
	ratio2(V1,V2).

random_ratio(3,V1,V2):-
	ratio3(V1,V2).

ratio0(V1,V2) :-
	phi(Phi),
	TmpVal is V1 - (V1 / Phi),
	round(TmpVal, V2).

ratio1(V1,V2) :-
	phi(Phi),
	TmpVal is V1 / Phi,
	round(TmpVal, V2).

ratio2(V1,V2) :-
	phi(Phi),
	TmpVal is V1 + (V1 / Phi),
	round(TmpVal, V2).

ratio3(V1,V2) :-
	phi(Phi),
	TmpVal is 2 * V1 + (V1 / Phi),
	round(TmpVal, V2).

svgpath1(List, Path):-
	svgpath2(List,'<path d="M ',Path).

svgpath2([[X,Y]|[]],Path1,Path2) :-
	string_to_atom(StrX, X),
	string_to_atom(StrY, Y),
	random_strokewidth(Stroke),
	concatenate([Path1, StrX, ' ', StrY, ' ','" stroke="black" stroke-width="',Stroke,'" fill="none" />'], Path2).

svgpath2([[X,Y]|Tail], Path1, Path3) :-
	string_to_atom(StrX, X),
	string_to_atom(StrY, Y),
	concatenate([Path1, StrX, ' ', StrY, ' ','L '], Path2),
	svgpath2(Tail,Path2,Path3).


random_curvecoordinate(C):-
	C is (random(3) +1) / 10.

random_strokewidth(Stroke):-
	I is random(3),
	random_strokewidth(I,Stroke).

random_strokewidth(0,0.1).
random_strokewidth(1,0.5).
random_strokewidth(2,1).

concatenate([],"").

concatenate([Str|[]],Str).

concatenate([Str1,Str2|T],Return) :-
	string_concat(Str1,Str2,Str3),
	concatenate([Str3|T],Return).







