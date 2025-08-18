	AREA RESET,DATA,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x10001000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR 	R1, =N1
	LDR 	R2, =N2
	LDR 	R3, =RESULT
	
	LDR		R4, [R1]
	LDR 	R5, [R2]
	MOV 	R0, #1
LOOP 
	MOV 	R7, R0
	MUL		R7, R4, R0
	UDIV 	R9, R7, R5
	MLS 	R8, R9, R5, R7
	
	CMP 	R8, #0
	BEQ 	DONE
	
	ADD 	R0, R0, #1
	B 		LOOP
DONE
	STR 	R7, [R3]
STOP 
	B STOP	
	
N1 DCD 0x00000004
N2 DCD 0x00000002

	AREA myArea,DATA,READWRITE
RESULT DCD 0

END
