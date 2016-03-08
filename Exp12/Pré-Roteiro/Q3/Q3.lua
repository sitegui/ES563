file = openfile("Q3.txt", "w")
write(file, format("Ang\tF_x\tF_y\tT\n"))
step = 15

for n = 0, 360/step-1 do
	mi_analyse(0)
	mi_loadsolution(0)

	mo_showdensityplot(1, 0, 0, 0.7, "bmag")
	mo_savebitmap(format("Q3_%02d.bmp", n))

	mo_seteditmode("area")
	mo_selectblock(0, 0)
	F_x = mo_blockintegral(18)
	F_y = mo_blockintegral(19)
	T = mo_blockintegral(22)

	write(file, format("%d\t%f\t%f\t%f\n", step*n, F_x, F_y, T))

	mi_selectgroup(7)
	mi_moverotate(0, 15, step)
end

closefile(file)