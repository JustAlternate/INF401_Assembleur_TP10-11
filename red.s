@fonction red   

@parametres : 
@- t : l'adresse d'un TabEnt8 
@- n : taille de la sequence en EntN
@- vi : valeur initiale en Ent8
@- g : la fonction passé en FoncRedEnt8

@algorithme :

@red(t, n, vi, g) :
@  i : entier du type EntN
@  acc : entier du type Ent32
@  i <- 0
@  acc <- vi
@  tant que i != n
@    acc <- g(acc, t[i])
@    i <- i + 1
@  retour acc

@allocation des registres : 

@- t dans r0
@- n dans r1
@- vi dans r2
@- g dans r3
@- res dans r4

         .text
         .global  red
red:

	push {lr}
	push {r0, r1, r2, r3, r5}

	@ t dans r0
	@ n dans r1
	@ vi dans r2
	@ g dans r3

	MOV r4, #0        @ i = 0
	MOV r5, r2        @ acc = vi  PEUT ETRE PROBLEME ICI
	tant_que_red:

		cmp  r4, r1
		beq fin_red
		
		push {r0, r1, r4}
		LDRB r1, [r0, r4]    @ r1 = t[i]
		MOV r0, r5           @ r0 = acc
		blx r3
		MOV r5, r2           @ On met le resultat dans acc
		pop {r0, r1, r4}     @ On recup tout les registres
		
		ADD r4, r4, #1		
		b tant_que_red
	fin_red:
		MOV r4, r5           @ res dans r4
		pop {r0, r1, r2, r3, r5}
		pop {lr}
		
		bx lr
		
