@ procedure map
@ parametres : t1 adresse de tableau, n taille de la séquence, t2 adresse de tableau, f adresse de la fonction
@ algorithme : 
@ i : Entier de type EntN
@ i <- 0
@ tant que i != n
@ 	t2[i] <- f(t1[i])
@	i <- i + 1
@ allocation des registres : t1 dans r0, n dans r1, t2 dans r2, f dans r3

         .text
         .global  map
map:
		push {lr}
		push {r0, r1, r2, r3, r4, r5, r6}
		mov r5, #0					@ i <- 0
while_map:	cmp r5, r1					@ tant que i != n
		beq fin_while_map
		push {r3}
		mov r6, r3					@ r6 = *f
		ldrb r3, [r0, r5]				@ r3 = t1[i]
		blx r6						@ r4 = f(t1[i])
		pop {r3}
		strb r4, [r2, r5]				@ t2[i] <- f(t1[i])
		add r5, r5, #1					@ i <- i + 1
		b while_map
fin_while_map:	pop {r0, r1, r2, r3, r4, r5, r6}
		pop {lr}
		bx lr
