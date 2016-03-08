
	--Sample Program by Prem Kumar Chittajallu <prem@bhelrnd.co.in>
	-- Upgraded by Luiz Otávio Saraiva Ferreira
	-- DMC/FEM/UNICAMP
	-- June 2015

	--intended for Lua command application demonstration
	--To compute the lift force experienced by a plate due to
	-- a dc U core electro-magnet.
	--Problem Type ; Magnetostatic - 2D(planar)

	--Lua - Pre-processor steps for : DCmagnet
	MagneticProblem=0
	newdocument(MagneticProblem)
	mi_probdef(0,"millimeters","planar","1e-008",25)
	
	--Adding nodes defining the half C-core
	mi_addnode(0,60)
	mi_addnode(-50,60)
	mi_addnode(-50,0)
	mi_addnode(-70,0)
	mi_addnode(-70,60)
	mi_addnode(-50,80)
	mi_addnode(0,80)
		
	--Joining nodes to define half C-core
	mi_addsegment(0,60,-50,60)
	mi_addsegment(-50,60,-50,0)
	mi_addsegment(-50,0,-70,0)
	mi_addsegment(-70,0,-70,60)
	mi_addarc(-50,80,-70,60,90,10)
	mi_addsegment(-50,80,0,80)
	
	--Adding nodes defining left half of keeper
	mi_addnode(0,-20)
	mi_addnode(-90,-20)
	mi_addnode(-90,-30)
	mi_addnode(0,-30)

	--Joining nodes to define left half of keeper
	mi_addsegment(0,-20,-90,-20)
	mi_addsegment(-90,-20,-90,-30)
	mi_addsegment(-90,-30,0,-30)

	--Adding nodes to define Boundary(Left half)
	mi_addnode(0,200)
	mi_addnode(-200,200)
	mi_addnode(-200,-100)
	mi_addnode(0,-100)

	--Joining nodes to define Boundary(Left half)
	mi_addsegment(0,200,-200,200)
	mi_addsegment(-200,200,-200,-100)
	mi_addsegment(-200,-100,0,-100)

	--Adding nodes to define Bottom coil(Half)
	mi_addnode(0,58)
	mi_addnode(-35,58)
	mi_addnode(-35,38)
	mi_addnode(0,38)
	
	--Joining nodes to form Bottom coil(Half)
	mi_addsegment(0,58,-35,58)
	mi_addsegment(-35,58,-35,38)
	mi_addsegment(-35,38,0,38)

	--mirroring to get the top half coil
	mi_selectsegment(-25,58)
	mi_selectsegment(-35,48)
	mi_selectsegment(-25,38)
	mi_mirror(-10,70,10,70,1)
	mi_clearselected()
	
	--Selecting segments for mirroring about Y-axis.
	mi_selectsegment(-25,38)
	mi_selectsegment(-35,48)
	mi_selectsegment(-25,58)
	mi_selectsegment(-25,60)
	mi_selectsegment(-50,30)
	mi_selectsegment(-60,0)
	mi_selectsegment(-70,30)
	mi_selectsegment(-25,80)
	mi_selectsegment(-25,82)
	mi_selectsegment(-35,92)
	mi_selectsegment(-25,102)
	mi_selectsegment(-45,-20)
	mi_selectsegment(-90,-25)
	mi_selectsegment(-45,-30)
	mi_selectsegment(-100,200)
	mi_selectsegment(-200,0)
	mi_selectsegment(-100,-100)
	mi_mirror(0,0,0,20,1)
	mi_clearselected()
	mi_addarc(70,60,50,80,90,10)
	--Geometry, including Boundary completes here.
	
	--Defining Boundary Condition
	mi_addboundprop("outer",0,0,0,0,0,0,0,0,0)
	
	--Defining Excitations
	mi_addcircprop("plus",2500,0,0,0,0)
	mi_addcircprop("minus",-2500,0,0,0,0)

	--Assigning Boundary Condition
	mi_selectsegment(-100,200)
	mi_selectsegment(100,200)
	mi_selectsegment(-200,0)
	mi_selectsegment(-100,-100)
	mi_selectsegment(100,-100)
	mi_selectsegment(200,0)
	mi_setsegmentprop("outer",1,1,0,0)
	mi_clearselected()

	--Defining material
	mi_addmaterial("iron",5000,5000,0,0,0,0,0,0,1,0)
	mi_addmaterial("air",1,1,0,0,0,0,0,0,1,0)
	mi_addmaterial("copper",1,1,0,0,0,0,0,0,1,0)
	
	--Assigning Material Props
	mi_addblocklabel(0,150)
	mi_selectlabel(0,150)
	mi_setblockprop("air",0,10,0,0,0)
	mi_clearselected()

	mi_addblocklabel(0,-25)
	mi_selectlabel(0,-25)
	mi_setblockprop("iron",0,3,0,0,4)
	mi_clearselected()

	mi_addblocklabel(0,70)
	mi_selectlabel(0,70)
	mi_setblockprop("iron",0,4,0,0,0)
	mi_clearselected()

	--Grouping segments forming keeper
	--For simulating movement later
	mi_selectsegment(-45,-20)
	mi_selectsegment(45,-20)
	mi_selectsegment(-90,-25)
	mi_selectsegment(90,-25)
	mi_selectsegment(-45,-30)
	mi_selectsegment(45,-30)
	mi_setsegmentprop(0,1,1,0,4)
	mi_clearselected()
	
	--Assigning excitations
	mi_addblocklabel(0,48)
	mi_selectlabel(0,48)
	mi_setblockprop("copper",0,7.5,"plus",0,0)
	mi_clearselected()

	mi_addblocklabel(0,92)
	mi_selectlabel(0,92)
	mi_setblockprop("copper",0,7.5,"minus",0,0)
	mi_clearselected()

	mi_zoomnatural()
	
	messagebox("Animation begins now !!")
	
	mi_saveas("temp.fem")
	
	mi_seteditmode("group")
	
	for n =1,4 do
		mi_createmesh()
		mi_analyse(0)
		mi_loadsolution(0)
	
		handle=openfile("DCmagnet_result.txt","a");
		mo_zoomnatural()
		mo_hidecontourplot()
		mo_showmesh()
		messagebox("FE mesh")
		mo_hidemesh()

		mo_showcontourplot(-1)
		mo_savebitmap(format("Aplot_%1$d.bmp",n))
		messagebox("Vector potential plot ")
		mo_hidecontourplot()

		mo_smooth("on")
		mo_showdensityplot(1,0,0,0.7,"bmag")
		messagebox("Flux density plot ",n)
		mo_savebitmap(format("Bplot_%1$d.bmp",n))
		mo_hidedensityplot()

		mo_seteditmode("contour")
		mo_addcontour(-92.5,-1.0)
		mo_addcontour(92.5,-1.0)
		mo_addcontour(92.5,-32.5)
		mo_addcontour(-92.5,-32.5)
		mo_addcontour(-92.5,-1.0)
		messagebox("Contour for integration")

		F_x, F_y = mo_lineintegral(3)
	
		showconsole()
		gap = 20-4.5*(n-1)
		print("Gap = ",gap, " mm     Force = ",F_y," N")
		write(handle,format("%1$f \t %2$f \n",gap, F_y))
		
		mo_clearcontour()
		closefile(handle)
	
		mi_purgemesh()
	
		mi_selectgroup(4)
		mi_movetranslate(0,4.5,4)
		messagebox("Move iron block.")
	end
	
	messagebox("Exiting code !!")

	exit()

	

	

	



