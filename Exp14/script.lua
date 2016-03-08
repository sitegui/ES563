file = openfile("dados.txt", "w")
write(file, format("Dist\tF_r\tF_z\n"))

for n = 0, 66 do
	mi_analyse(0)
	mi_loadsolution(0)

	mo_showdensityplot(1, 0, 0, 0.7, "bmag")
	mo_savebitmap(format("%02d.bmp", n))

	mo_seteditmode("area")
	mo_groupselectblock(1)
	F_r = mo_blockintegral(18)
	F_z = mo_blockintegral(19)

	write(file, format("%d\t%f\t%f\n", n, F_r, F_z))

	mi_selectgroup(1)
	mi_movetranslate(0, -1)
end

mi_selectgroup(1)
mi_movetranslate(0, 67)

closefile(file)