raised-ranch.ps:
	Rscript plot.r

raised-ranch.hpgl: raised-ranch.ps
	pstoedit -xshift -210 -yshift -148.5 -f "hpgl:-penplotter" raised-ranch.ps raised-ranch.hpgl
