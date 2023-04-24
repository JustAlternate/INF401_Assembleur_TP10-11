@ Fonction red récursive
@ paramètres à push avant d'appeler la fonction :
@ tab, n, val_init, g
@ algo :
@ red(tab, n, init, g):
@	si n == 0:
@		return init
@	sinon:
@		return red(tab+1, n-1, g(init, mem[tab]), g)

	.text
	.global red

red:
	push {lr}		@ On enregistre l'adresse de retour et l'ancien fp
	push {fp}
	mov fp, sp		@ On enregistre le sommet actuel de la pile pour récupérer les paramètres
	push {r0, r1, r2, r3, r4, r5, r6}	@ Sauvegarde des registres dans la pile

	@ On récupère les arguments de la fonction
	ldr r0, [fp, #12]	@ r3 : adresse de la fonction g
	ldr r1, [fp, #16]	@ r2 : valeur initiale
	ldr r2, [fp, #20]	@ r1 : taille n de la séquence
	ldr r3, [fp, #24]	@ r0 : début du tableau
	
if_red: cmp r1, #0		@ si red == 0
	bne sinon_red
	str r2, [fp, #8]	@ On enregistre la valeur initiale à l'endroit réservé dans la pile pour la valeur de retour
	b fin_if_red
sinon_red:
	push {r0, r1, r2}	@ On calcule g(init, mem[tab])
	mov r0, r2
	ldrb r1, [r0]
	blx r3
	mov r4, r2		@ r4 = g(init, mem[tab])
	pop {r0, r1, r2}
	add r5, r0, #1		@ r5 = tab+1
	sub r6, r1, #1		@ r6 = n-1
	push {r5}		@ On ajoute à la pile les paramètres pour l'appel récursif
	push {r6}
	push {r4}
	push {r3}
	sub sp, sp, #4		@ On laisse un espace pour la valeur de retour
	ldr r1, LD_red
	blx r1			@ appel récursif
	pop {r2}
	add sp, sp, #16
	str r2, [fp, #8]	
fin_if_red:
	pop {r0, r1, r2, r3, r4, r5, r6}
	pop {fp}
	pop {lr}
	bx lr


LD_red:
	.word red
