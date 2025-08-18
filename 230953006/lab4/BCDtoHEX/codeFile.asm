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
        LDR     R0, =SRC          ; R0 = address of SRC
        LDR     R1, [R0]          ; R1 = value at SRC (BCD input)

        AND     R2, R1, #0xF0     ; Extract tens digit (high nibble)
        LSR     R2, R2, #4        ; Shift to get digit value 0-9

        AND     R3, R1, #0x0F     ; Extract ones digit (low nibble)

        MOV     R4, #10           ; constant 10

        MUL     R2, R2, R4        ; tens * 10

        ADD     R6, R2, R3        ; R6 = final decimal value

        LDR     R5, =DST          ; R5 = address of DST
        STR     R6, [R5]          ; store result

STOP
        B STOP

SRC     DCD 0x45             	; input BCD 0x50 (decimal 50)
		AREA mydata, DATA, READWRITE
DST     DCD 0x0

        END
