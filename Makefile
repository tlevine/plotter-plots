raised-ranch.ps:
	Rscript plot.r

raised-ranch.hpgl: raised-ranch.ps
	# pstoedit -f gmfa raised-ranch.ps raised-ranch.gmfa
	# HPGL_ASSIGN_COLORS=yes HPGL_VERSION=2 plot -T hpgl raised-ranch.gmfa > raised-ranch.hpgl 
	pstoedit -f "plot-hpgl:HPGL_VERSION=2" raised-ranch.ps raised-ranch.hpgl
