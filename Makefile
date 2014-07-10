raised-ranch.ps:
	Rscript plot.r

raised-ranch.hpgl: raised-ranch.ps
	# [-pencolorsfromfile]
	# read pen colors from file drvhpgl.pencolors in pstoedit data directory
	# [-pencolors number]
	pstoedit -f "hpgl:-pencolors 5" raised-ranch.ps raised-ranch.hpgl
