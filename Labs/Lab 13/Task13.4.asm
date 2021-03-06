.MODEL SMALL
.STACK 100H
.DATA
  PROMPT1 DB "Enter hour: $"
  PROMPT2 DB "Enter minute: $"
  PROMPT3 DB "Enter second: $"
  PROMPT4 DB "12-hour equivalent of $"
  PROMPT5 DB " is $"
  PROMPT6 DB " AM$"
  PROMPT7 DB " PM$"
.CODE

INCLUDE Func.asm

MAIN PROC
  MOV AX, @DATA
  MOV DS, AX ;INITIALIZATION OF DATA SEGMENT

  MOV AH, 09H
  LEA DX, PROMPT1
  INT 21H ;DISPLAY PROMPT1

  CALL DECIMAL_INPUT
  PUSH AX ;SAVING HOURS

  MOV AH, 09H
  LEA DX, PROMPT2
  INT 21H ;DISPLAY PROMPT2

  CALL DECIMAL_INPUT
  PUSH AX ;SAVING MINUTES 

  MOV AH, 09H
  LEA DX, PROMPT3
  INT 21H ;DISPLAY PROMPT3

  CALL DECIMAL_INPUT
  PUSH AX ;SAVING SECONDS

  MOV AH, 09H
  LEA DX, PROMPT4
  INT 21H ;DISPLAY PROMPT4

  MOV BP, SP

  MOV AX, [BP + 4] ;PARAMETER FOR DECIMAL_OUTPUT AX(HOURS)
  CALL DECIMAL_OUTPUT

  MOV AH, 02H
  MOV DL, ':'
  INT 21H ;DISPLAY COLON

  MOV AX, [BP + 2] ;PARAMETER FOR DECIMAL_OUTPUT AX(MINUTES)
  CALL DECIMAL_OUTPUT

  MOV AH, 02H
  MOV DL, ':'
  INT 21H ;DISPLAY COLON 

  MOV AX, [BP] ;PARAMETER FOR DECIMAL_OUTPUT AX(SECONDS)
  CALL DECIMAL_OUTPUT

  MOV AH, 09H
  LEA DX, PROMPT5
  INT 21H ;DISPLAY PROMPT5

  MOV AX, [BP + 4] ;AX = HOURS
  CMP AX, 12 
  JL AM ;JUMP IF HOURS < 12

  SUB AL, 12 ;SUBTRACT HOURS IF GREATER THAN 12

  AM:
  CALL DECIMAL_OUTPUT
    
  MOV AH, 02H
  MOV DL, ':'
  INT 21H ;DISPLAY COLON

  MOV AX, [BP + 2] ;PARAMETER FOR DECIMAL_OUTPUT AX(MINUTES)
  CALL DECIMAL_OUTPUT

  MOV AH, 02H
  MOV DL, ':'
  INT 21H ;DISPLAY COLON 

  MOV AX, [BP] ;PARAMETER FOR DECIMAL_OUTPUT AX(SECONDS)
  CALL DECIMAL_OUTPUT

  MOV AX, [BP + 4] ;AX = HOURS
  CMP AX, 12 
  JGE PM ;JUMP IF HOURS >= 12

  MOV AH, 09H
  LEA DX, PROMPT6
  INT 21H ;DISPLAY PROMPT6
  JMP EXIT

  PM:
  MOV AH, 09H
  LEA DX, PROMPT7
  INT 21H ;DISPLAY PROMPT6

  EXIT:
  MOV AH, 4CH
  INT 21H ;EXIT DOS

MAIN ENDP
END MAIN
