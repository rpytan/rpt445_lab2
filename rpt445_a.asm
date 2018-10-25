.ORIG x3000

LD R0, STRING1

SORT	AND R5, R5, #0		;counter for number of incorrect pairs
	AND R2, R0, #x0011	;isolates just the score to compare
	AND R6, R0, #x1100	;isolates just the ID to compare

	LDR R1, R0, #1		;loads next array element into R1
	AND R3, R1, #x0011	;isolates just the score to compare
	
	NOT R3, R3		;sets up R3 to be negative to subtract
	ADD R3, R3, #1
	ADD R3, R2, R3		;if R2+R3=p, then R2 is bigger than original R3
	BRz INCRZ		;goes on to sort next value by incrementing
	BRp INCRP		
	STR R0, R0, #1		;stores content of R0 to next register
	STR R1, R0, #0		;stores content of R1 to R0 address
	BR INCRN		;done swapping, move onto next array element

INCRZ	AND R4, R1, #x1100	;isolates just the ID to compare
	NOT R4, R4		;sets up R4 to be negative to subtract
	ADD R4, R4, #1
	ADD R4, R6, R4		
	BRn SWAPID
	ADD R0, R0, #1
	AND R7, R0, #1100 	;isolates just the ID to compare
	BRz AGAIN	 	;checks if reached end of arrray
	BRnp SORT
	
SWAPID	STR R0, R0, #1
	STR R1, R0, #0
	ADD RO, RO, #1
	BR SORT

INCRP	ADD R0, R0, #1		;increments R0 to next address
	AND R7, R0, #1100 	;isolates just the ID to compare
	BRz AGAIN	 	;checks if reached end of arrray
	BRnp SORT

INCRN	ADD R5, R5, #1		;sets counter to positive if needs to swap
	ADD R0, R0, #1		;increments R0 to next address
	AND R7, R0, #1100 	;isolates just the ID to compare
	BRz AGAIN	 	;checks if reached end of arrray
	BRnp SORT

AGAIN	LD R5, R5, #0		;cheks if entire sort was correct
	BRp SORT		;sorts array again by score
	HALT

STRING1	.FILL x4005	;first string in array

	.END
