DATAS SEGMENT
    X DB 100 DUP(?)  
DATAS ENDS

STACKS SEGMENT
    DB 100 DUP('STACK')
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
MAIN PROC FAR
    MOV AX,DATAS
    MOV DS,AX
    MOV SI,0
INPUT: MOV AH,1H;INPUT DATAS AND STORE IN DS
    INT 21H
    MOV [SI+X],AL
    INC SI
    CMP AL,0DH
    JNZ INPUT
    DEC SI;�������ַ���
    DEC SI
    
NEXT2:MOV DI,OFFSET X
	MOV CX,SI
NEXT:MOV AL,[DI]
    CMP AL,[DI+1]
    JBE NEXT1
    XCHG AL,[DI+1]
    MOV [DI],AL
NEXT1:INC DI
    LOOP NEXT
    DEC SI
    JNZ NEXT2
    MOV SI,OFFSET X
    
    MOV DL,0AH;���лس�
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H
    
OUTPUT:MOV DL,[SI];OUTPUT SORTED DATAS
	MOV AH,2H
    INT 21H
    INC SI
    CMP DL,0DH
    JNZ OUTPUT
    MOV AH,4CH
    INT 21H
MAIN ENDP
CODES ENDS
    END MAIN



