raised-ranch.ps:
	Rscript plot.r

raised-ranch.hpgl: raised-ranch.ps
	pstoedit -f "hpgl:-penplotter" raised-ranch.ps raised-ranch.hpgl
	sed -i '1 s/^.*$$/IN;SC0,15522,0,10504;PU;LT;/' raised-ranch.hpgl
