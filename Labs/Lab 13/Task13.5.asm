.MODEL SMALL
.STACK 100H
.DATA
  PROMPT1 DB "Enter number of minutes: $"
  PROMPT2 DB " minutes is equivalent to $"
  PROMPT3 DB " days, $"
  PROMPT4 DB " hours, and $"
  PROMPT5 DB " minutes.$"
.CODE

INCLUDE Func.asm

MAIN PROC
  MOV AX, @DATA
  MOV DS, AX ;INITIALIZATION OF DATA SEGMENT

  MOV AH, 09H
  LEA DX, PROMPT1
  INT 21H ;DISPLAY PROMPT1

  CALL DECIMAL_INPUT

  CALL DECIMAL_OUTPUT

  PUSH AX ;SAVING INPUT MINUTES 

  MOV AH, 09H
  LEA DX, PROMPT2
  INT 21H ;DISPLAY PROMPT2

  POP AX ;RESTORING INPUT MINUTES 

  MOV BX, 60 ;DIVIDE BY 60 WILL GIVE Q(DAYS + HOURS), R(MINUTES)
  XOR DX, DX 
  DIV BX 

  PUSH DX ;MINUTES 

  MOV BX, 24 ;DIVIDE BY 24 WILL GIVE Q(DAYS), R(HOURS)
  XOR DX, DX
  DIV BX

  PUSH DX ;HOURS 
  PUSH AX ;DAYS 

  POP AX ;PARAMETER FOR DECIMAL_OUTPUT AX(DAYS)
  CALL DECIMAL_OUTPUT

  MOV AH, 09H
  LEA DX, PROMPT3
  INT 21H ;DISPLAY PROMPT3

  POP AX ;PARAMETER FOR DECIMAL_OUTPUT AX(HOURS)
  CALL DECIMAL_OUTPUT

  MOV AH, 09H
  LEA DX, PROMPT4
  INT 21H ;DISPLAY PROMPT4

  POP AX ;PARAMETER FOR DECIMAL_OUTPUT AX(MINUTES)
  CALL DECIMAL_OUTPUT

  MOV AH, 09H
  LEA DX, PROMPT5
  INT 21H ;DISPLAY PROMPT5

  MOV AH, 4CH
  INT 21H ;EXIT DOS

MAIN ENDP
END MAIN 
