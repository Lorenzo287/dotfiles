.MODEL small
.STACK 100h

.DATA
    ; Variables

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; Code

    MOV AX, 4C00h
    INT 21h
END START
