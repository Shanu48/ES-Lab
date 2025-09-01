        AREA RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD 0x10001000
        DCD Reset_Handler
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler
        MOV r4,#0             ; index = 0
        MOV R1,#10            ; counter = 10 elements
        LDR R0,=LIST          ; source array
        LDR R2,=RESULT        ; destination array

; Copy LIST -> RESULT
COPY_LOOP
        LDR R3,[R0,R4]        ; load element
        STR R3,[R2,R4]        ; store in RESULT
        ADD R4,#4             ; move to next element
        SUB R1,#1             ; decrement counter
        CMP R1,#0
        BHI COPY_LOOP

        LDR R0,=RESULT        ; base address of array
        MOV R8,#10            ; total elements = 10
        SUB R8,R8,#1          ; run outer loop N-1 times
        MOV R4,#0             ; outer index i = 0

OUTER_LOOP
        ADD R5,R0,R4,LSL #2   ; R5 = &A[i]
        MOV R6,R4             ; min_index = i
        MOV R7,R4             ; j = i

INNER_LOOP
        ADD R7,R7,#1          ; j++
        CMP R7,#10            ; check j < N
        BGE CHECK_SWAP

        ADD R1,R0,R7,LSL #2   ; &A[j]
        LDR R2,[R1]           ; A[j]
        ADD R3,R0,R6,LSL #2   ; &A[min_index]
        LDR R9,[R3]           ; A[min_index]

        CMP R2,R9             ; if A[j] < A[min_index]
        MOVLT R6,R7           ; update min_index
        B INNER_LOOP

CHECK_SWAP
        CMP R6,R4             ; if min_index != i
        BEQ SKIP_SWAP

        ; Swap A[i] and A[min_index]
        ADD R1,R0,R4,LSL #2   ; &A[i]
        LDR R2,[R1]           ; temp = A[i]
        ADD R3,R0,R6,LSL #2   ; &A[min_index]
        LDR R9,[R3]           ; A[min_index]
        STR R9,[R1]           ; A[i] = A[min_index]
        STR R2,[R3]           ; A[min_index] = temp

SKIP_SWAP
        ADD R4,R4,#1          ; i++
        CMP R4,R8
        BLT OUTER_LOOP

STOP    B STOP

LIST    DCD 0x10,0x05,0x33,0x24,0x56,0x77,0x21,0x04,0x87,0x01
        AREA data, DATA, READWRITE
RESULT  DCD 0,0,0,0,0,0,0,0,0,0
        END
