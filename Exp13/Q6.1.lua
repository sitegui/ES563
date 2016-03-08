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

    --define este imã como Grupo 7
    mi_selectnode(-2.5,2.5)
    mi_selectnode(2.5,2.5)
    mi_selectnode(2.5,-2.5)
    mi_selectnode(-2.5,-2.5)
    mi_setnodeprop("Neodimio N37", 7) 
    mi_clearselected()
    mi_selectsegment(-2.5,2.5,2.5,2.5)
    mi_selectsegment(2.5,2.5,2.5,-2.5)
    mi_selectsegment(2.5,-2.5,-2.5,-2.5)
    mi_selectsegment(-2.5,-2.5,-2.5,2.5)
    mi_setsegmentprop("Neodimio N37", 1,1,0,7) 
    mi_clearselected()
	
    --Definição dos materiais dos imãs e do ar
    --mi setblockprop("blockname", automesh, meshsize, "incircuit", magdirection, group, turns)	
    mi_addblocklabel(0,0)
	mi_selectlabel(0,0)
    mi_setblockprop("Neodimio N37",1,0,0,90,0) -- 1 = mesh automatico
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

	mi_saveas("Q6.1.fem")

    file = openfile("Q6.1.txt", "w")
    
    write(file, format("Dist(mm)\tB_n\n"))

    for n = 0, 4 do
        mi_createmesh()
        mi_analyse(0)
        mi_loadsolution(0)

        mo_showcontourplot(-1)
        mo_smooth("on")
        mo_showdensityplot(1, 0, 0, 0.7, "bmag")

        mo_seteditmode("contour")
        mo_addcontour(-2.5,2.5+2*n)
        mo_addcontour(2.5,2.5+2*n)
        B_n = mo_lineintegral(0)
        
        write(file, format("%d\t%f\n", 2*n, B_n))

        mo_clearcontour()
        mi_purgemesh()
    end

    closefile(file)
