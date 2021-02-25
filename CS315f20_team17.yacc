%token INT
%token DOUBLE
%token LP
%token RP
%token LCB
%token RCB
%token ASSIGN
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token MOD
%token EQ
%token SEQ
%token GEQ
%token NEQ
%token SMALLER
%token GREATER
%token AND
%token OR
%token NOT
%token NL
%token BOOL
%token SMC
%token STR
%token WHILE
%token FOR
%token DO
%token IF
%token ELSE
%token ELSEIF
%token PRINT
%token SCAN
%token READ_TMP
%token READ_ALT
%token READ_INC
%token READ_ACC
%token READ_TIME
%token CAMERA
%token TAKE_PICT
%token CONNECT_WIFI
%token FORWARD
%token BACKWARD
%token SET_INC
%token SET_ALT
%token MAIN
%token VAR
%token DEF
%token COMMA

%{
  int numberOfErrors;
  int yylex();
  int yyerror( char *s );
%}

%%

program:
    main
    | main defFuncList
    | defFuncList main defFuncList
    | defFuncList main ;
defFuncList:
    defFunc
    | defFunc defFuncList;
main:
    MAIN LP RP LCB CONNECT_WIFI LP RP SMC stmtList RCB
    | MAIN LP RP LCB CONNECT_WIFI LP RP SMC RCB ;
stmtList:
    stmt
    | stmt stmtList ;
stmt: 
    VAR ASSIGN right SMC 
    | func SMC  
    | loop
    | conditionalStmt ;
right:
    right OR term 
    | term ;
term:
    term AND term2 
    | term2 ;
term2: 
    term2 conditionOp2 term3
    | term3 ;
term3: 
    term3 conditionOp1 term4 
    | term4 ;
term4: 
    term4 arithmeticOp2 term5 
    | term5 ;
term5: 
    term5 arithmeticOp1 term6 
    | term6 ;
term6: 
    NOT term7 
    | term7 ;
term7: 
    LP right RP 
    | term8 ;
term8:
    val 
    | func ;
val: 
    VAR 
    | const ;
const: 
    INT 
    | DOUBLE 
    | BOOL 
    | STR ;
arithmeticOp1: 
    TIMES 
    | DIV 
    | MOD ;
arithmeticOp2: 
    PLUS 
    | MINUS ;
conditionOp1: 
    SMALLER 
    | GREATER 
    | SEQ 
    | GEQ ;
conditionOp2: 
    EQ 
    | NEQ ;
primitiveFunc: 
    PRINT LP right RP 
    | SCAN LP RP 
    | READ_TMP LP RP 
    | READ_ALT LP RP 
    | READ_INC LP RP 
    | READ_ACC LP RP 
    | READ_TIME LP RP 
    | CAMERA LP right RP 
    | TAKE_PICT LP RP 
    | CONNECT_WIFI LP RP 
    | FORWARD LP right RP 
    | BACKWARD LP right RP 
    | SET_INC LP right RP 
    | SET_ALT LP right RP ;
func: 
    VAR LP valList RP 
    | VAR LP RP 
    | primitiveFunc ;
defFunc: 
    DEF func LCB stmtList RCB
    | DEF func LCB RCB ;

valList: 
    right 
    | right COMMA valList ;
loop: 
    WHILE LP stmt3 RP LCB stmtList RCB 
    | WHILE LP stmt3 RP LCB RCB   
    | FOR LP stmt3List SMC stmt3 SMC stmt3List RP LCB stmtList RCB
    | FOR LP stmt3List SMC stmt3 SMC stmt3List RP LCB RCB ;
stmt3List: 
    stmt3 
    | stmt3 COMMA stmt3List ;
stmt3: 
    VAR ASSIGN right 
    | right ;

conditionalStmt: 
    if 
    | if else 
    | if elseifs 
    | if elseifs else ;
if: 
    IF LP right RP LCB stmtList RCB
    | IF LP right RP LCB RCB ; 
    elseifs: 
        elseif 
        | elseif elseifs ;
elseif: 
    ELSE IF LP right RP LCB stmtList RCB 
    | ELSEIF LP right RP LCB RCB ;
else: 
    ELSE LCB stmtList RCB
    | ELSE LCB RCB ;

%%
#include "lex.yy.c"
extern int yylineno;
int yyerror( char *s ) 
{ 
    numberOfErrors ++;
    fprintf( stderr, "%s in line %d \n", s, yylineno ); 
}

int main()
{
    numberOfErrors = 0;
    yyparse();

    if(numberOfErrors == 0)
        printf("Program is valid\n");
    return 0;
}
