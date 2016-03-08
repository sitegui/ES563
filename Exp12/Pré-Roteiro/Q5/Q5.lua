file = openfile("Q5.txt", "w")
write(file, format("Dist(mm)\tF_x\tF_y\tT\n"))

for n = 1, 10 do
	mi_createmesh()
	mi_analyse(0)
	mi_loadsolution(0)

	mo_showcontourplot(-1)
	mo_smooth("on")
	mo_showdensityplot(1, 0, 0, 0.7, "bmag")
	mo_savebitmap(format("Q5_%02d.bmp", n))

	mo_seteditmode("area")
	mo_selectblock(0, 0)
	F_x = mo_blockintegral(18)
	F_y = mo_blockintegral(19)
	T = mo_blockintegral(22)

	write(file, format("%d\t%f\t%f\t%f\n", n, F_x, F_y, T))

	mo_clearcontour()
	mi_purgemesh()

	mi_selectgroup(7)
	mi_movetranslate(0, 1, 4)
end

closefile(file)
