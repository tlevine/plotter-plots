raised-ranch.ps:
	Rscript plot.r

raised-ranch.hpgl: raised-ranch.ps
	pstoedit -f plot-hpgl raised-ranch.ps raised-ranch.hpgl
