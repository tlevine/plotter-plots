raised-ranch.ps:
	Rscript plot.r

raised-ranch.hpgl: raised-ranch.ps
	pstoedit -f "hpgl:-penplotter" raised-ranch.ps raised-ranch.hpgl

brussels-berlin.hpgl:
	pstoedit -f "hpgl:-penplotter" brussels-berlin.ps brussels-berlin.hpgl
