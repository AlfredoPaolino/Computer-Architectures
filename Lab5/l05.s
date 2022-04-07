.data

v1: .double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2

v2: .double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2

v3: .double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2
	
v4: .double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2

.text
	daddui r1,r0,0
	daddui r2,r0,10

cycle: 	l.d f1,v1(r2);
	   		l.d f2,v2(r2);
	   		l.d f3,v3(r2);
	   		mul.d f5,f3,f4
	  		div.d f6, f1, f2
			add.d f7, f6, f5
			s.d f7,v4(r1)
			daddui r1,r1,8
			daddi r2,r2,-1
	  		bnez r2,cycle;

ending: halt;

;1232 cc
