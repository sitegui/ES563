	MagneticProblem=0
	newdocument(MagneticProblem)
	mi_probdef(0,"millimeters","planar","1e-008",30) --definições do plano e medidas. afastamento em Z de 30mm(profundidade)


	--Definição dos materiais a serem utilizados
    --mi addmaterial("materialname", mu x, mu y, H c, J, Cduct, Lam d, Phi hmax,lam fill, LamType, Phi hx, Phi hy,NStrands,WireD)
	mi_addmaterial("Neodimio N37",1.048,1.048,950000,0,0.667,0,0,1,0,0,0,0,0)
    mi_addmaterial("Ar",1,1,0,0,0,0,0,1,0,0,0,0,0)

	----Primeiro imã (centro em 0,0)
	mi_addnode(-2.5,2.5)
    mi_addnode(2.5,2.5)
    mi_addnode(2.5,-2.5)
    mi_addnode(-2.5,-2.5)
	mi_addsegment(-2.5,2.5,2.5,2.5)
	mi_addsegment(2.5,2.5,2.5,-2.5)
	mi_addsegment(2.5,-2.5,-2.5,-2.5)
	mi_addsegment(-2.5,-2.5,-2.5,2.5)

	--Segundo imã (centro em 0,11)
    mi_addnode(-2.5,8.5)	    
    mi_addnode(2.5,8.5)
    mi_addnode(2.5,13.5)
    mi_addnode(-2.5,13.5)
    mi_addsegment(-2.5,13.5,2.5,13.5)
    mi_addsegment(2.5,13.5,2.5,8.5)
    mi_addsegment(2.5,8.5,-2.5,8.5)
    mi_addsegment(-2.5,8.5,-2.5,13.5)
    --define este imã como Grupo 7
    mi_selectnode(-2.5,8.5)	      
    mi_selectnode(2.5,8.5)
    mi_selectnode(2.5,13.5)
    mi_selectnode(-2.5,13.5)    
    mi_setnodeprop("Neodimio N37", 7) 
    mi_clearselected()
    mi_selectsegment(-2.5,13.5,2.5,13.5)
    mi_selectsegment(2.5,13.5,2.5,8.5)
    mi_selectsegment(2.5,8.5,-2.5,8.5)
    mi_selectsegment(-2.5,8.5,-2.5,13.5)
    mi_setsegmentprop("Neodimio N37", 1,1,0,7) 
    mi_clearselected()
    
	
    --Definição dos materiais dos imãs e do ar
    --mi setblockprop("blockname", automesh, meshsize, "incircuit", magdirection, group, turns)	
    mi_addblocklabel(0,0)
	mi_selectlabel(0,0)
    mi_setblockprop("Neodimio N37",1,0,0,90,0) -- 1 = mesh automatico
	mi_clearselected()

	mi_addblocklabel(0,11)
	mi_selectlabel(0,11)
    mi_setblockprop("Neodimio N37",1,0,0,90,7)
	mi_clearselected()

    mi_addblocklabel(-10,16)
	mi_selectlabel(-10,16)
	mi_setblockprop("Ar",1,0,0,0,0)
	mi_clearselected()	
	
    --Definição da fronteira
    mi_addnode(-40,5)
    mi_addnode(40,5)
    mi_addarc(-40,5,40,5,180,1)
    mi_selectarcsegment(-40,5)
    mi_mirror(-40,5,40,5,3)
    mi_clearselected()    
    mi_addboundprop("Open",0,0,0,0,0,0,0,0,0)
    mi_selectarcsegment(-40,4)
    mi_selectarcsegment(-40,6)
    mi_setarcsegmentprop(1,"Open",0,0)
	mi_clearselected()

	mi_zoomnatural()
	
	mi_saveas("Relatorio.fem")

    file = openfile("Relatorio.txt", "w")
    write(file, format("Dist(mm)\tF_x\tF_y\tT\n"))

    for n = 6, 23 do
        mi_createmesh()
        mi_analyse(0)
        mi_loadsolution(0)

        mo_showcontourplot(-1)
        mo_smooth("on")
        mo_showdensityplot(1, 0, 0, 0.7, "bmag")
        mo_savebitmap(format("Relatorio_%02d.bmp", n))

        mo_seteditmode("area")
        mo_selectblock(0,0)
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
