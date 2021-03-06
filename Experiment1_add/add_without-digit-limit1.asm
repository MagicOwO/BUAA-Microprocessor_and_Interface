DATAS SEGMENT
    X1 DB 30 DUP(?)
    X2 DB 30 DUP(?)
    X3 DB 31 DUP(?)
    X4 DB 0DH,0AH
    COUNT1 DW 0
    COUNT2 DW 0
DATAS ENDS

STACKS SEGMENT
    DB 100 DUP('STACK')
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MAIN PROC FAR
    MOV AX,DATAS
    MOV DS,AX
    MOV SI,OFFSET X1;输入X1
    MOV BX,0
NEXT:CALL KEYIN
    AND AL,0FH
    MOV [BX][SI],AL
    INC BX
    CMP AL,0DH
    JNZ NEXT
    DEC BX
    DEC BX
    MOV DX,OFFSET COUNT1
    MOV [DX],BX
    MOV DL,2BH;加号
    MOV AH,2H
    INT 21H
    MOV DI,OFFSET X2;输入X2
    MOV BX,0
NEXT1:CALL KEYIN
    AND AL,0FH
    MOV [BX][DI],AL
    INC BX
    CMP AL,0DH
    JNZ NEXT1
    DEC BX
    DEC BX
    MOV DX,OFFSET COUNT2
    MOV [DX],BX
    MOV DL,'='
    MOV AH,2H
    INT 21H
    MOV AX,COUNT1
    MOV DX,COUNT2
    MOV BX,OFFSET X3
    CMP AX,DX
    JA DA1
    ADD BX,COUNT2
    MOV CX,COUNT1
J1:MOV AX,[SI]
    MOV [DX],AX
    INC SI
    DEC DX
    DEC COUNT2
    JNZ J1
    JMP GOON
DA1:ADD BX,COUNT1
    MOV CX,COUNT2
    MOV DX,OFFSET X3
J2:MOV AX,[SI]
    MOV [DX],AX
    INC SI
    DEC DX
    DEC COUNT1
    JNZ J2
GOON:MOV DX,BX
	SUB DX,CX
NEXT2:OR CX,CX
	MOV AL,COUNT1[SI]
    ADC AL,COUNT2[DI]
    AAA
    MOV [BX],AL
    DEC COUNT1
    DEC COUNT2
    DEC BX
    LOOP NEXT2
    
    MOV DX,OFFSET X3
    MOV AX,BX
    SUB AX,DX
    MOV CX,AX
    MOV DX,OFFSET X3;显示部分
    SUB BX DX
    MOV CX,BX
XUNHUAN:MOV 
NEXT3:MOV DL,[BX];高位为0则不显示
    CMP DL,0
    JNZ NEXT4;第一位不为零跳出循环1
    INC BX
    LOOP NEXT3
NEXT4:MOV CX,OFFSET X1+13
    SUB CX,BX
NEXT5:MOV DL,[BX];循环显示次数为13-BX中的数
    ADD DL,30H
    MOV AH,2
    INT 21H
    INC BX
    LOOP NEXT5
    MOV AH,4CH
    INT 21H
    MAIN ENDP
    
    KEYIN PROC;输入子程序
AGAIN:MOV AH,8
    INT 21H
    CMP AL,0DH
    JZ GOOUT
    CMP AL,30H
    JB AGAIN
    CMP AL,39H
    JA AGAIN
    MOV DL,AL
    MOV AH,2
    INT 21H
GOOUT:RET
    KEYIN ENDP
CODES ENDS
    END START
