.MODEL SMALL
.STACK 100H
.DATA
  PROMPT1 DB 10, 13, "Enter first number: $"
  PROMPT2 DB 10, 13, "Enter second number: $"
  PROMPT3 DB "LCM of $"
  PROMPT4 DB " and $"
  PROMPT5 DB " is $"
.CODE

INCLUDE Func.asm

MAIN PROC
  MOV AX, @DATA
  MOV DS, AX ;INITIALIZATION OF DATA SEGMENT

  MOV AH, 09H
  LEA DX, PROMPT1
  INT 21H ;DISPLAY PROMPT1

  CALL DECIMAL_INPUT
  PUSH AX ;SAVING FIRST NUMBER 

  MOV AH, 09H
  LEA DX, PROMPT2
  INT 21H ;DISPLAY PROMPT2

  CALL DECIMAL_INPUT
  PUSH AX ;SAVING SECOND NUMBER 

  MOV AH, 09H
  LEA DX, PROMPT3
  INT 21H ;DISPLAY PROMPT3

  MOV BP, SP

  MOV AX, [BP + 2] ;PARAMETER FOR DECIMAL_OUTPUT AX(FIRST NUMBER)
  CALL DECIMAL_OUTPUT

  MOV AH, 09H
  LEA DX, PROMPT4
  INT 21H ;DISPLAY PROMPT4

  MOV AX, [BP] ;PARAMETER FOR DECIMAL_OUTPUT AX(SECOND NUMBER)
  CALL DECIMAL_OUTPUT

  MOV AH, 09H
  LEA DX, PROMPT5
  INT 21H ;DISPLAY PROMPT5

  MOV AX, [BP + 2] ;PARAMETER FOR LCM AX(FIRST NUMBER)
  MOV BX, [BP] ;PARAMETER FOR LCM AX(SECOND NUMBER)
  CALL LCM

  MOV AX, DX ;PARAMETER FOR DECIMAL_OUTPUT AX(LCM)
  CALL DECIMAL_OUTPUT 

  MOV AH, 4CH
  INT 21H ;EXIT DOS
MAIN ENDP
END MAIN
