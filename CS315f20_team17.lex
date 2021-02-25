%option yylineno
INT [0-9]+
DOUBLE [0-9]+.[0-9]+
LP \(
RP \)
LCB \{
RCB \}
ASSIGN =
PLUS \+
MINUS -
TIMES \*
DIV \/
MOD %
EQ ==
SEQ <=
GEQ >=
NEQ !=
SMALLER <
GREATER >
AND &&
OR \|\|
NOT !
BOOL true|false
SMC ;
STR \"[^\"]*\"
COMMENT \/\/.*
WHILE while
FOR for
DO do
IF if
ELSE else 
ELSEIF else[ \t]if
PRINT print
SCAN scan
READ_TMP readTemperature
READ_ALT readAltitude
READ_INC readInclination
READ_ACC readAcceleration
READ_TIME readTime
CAMERA camera
TAKE_PICT takePicture
CONNECT_WIFI connectWifi
FORWARD forward
BACKWARD backward
SET_INC setInclination
SET_ALT setAltitude
MAIN main
VAR [A-Za-z][A-Za-z0-9_-]*
DEF def
COMMA ,
SPACE [ \t]+
NL \n

%%
{INT} return INT;
{DOUBLE} return DOUBLE;
{LP} return LP;
{RP} return RP;
{LCB} return LCB;
{RCB} return RCB;
{EQ} return EQ;
{ASSIGN} return ASSIGN;
{PLUS} return PLUS;
{MINUS} return MINUS;
{TIMES} return TIMES;
{DIV} return DIV;
{MOD} return MOD;
{SEQ} return SEQ;
{GEQ} return GEQ;
{NEQ} return NEQ;
{SMALLER} return SMALLER;
{GREATER} return GREATER;
{AND} return AND;
{OR} return OR;
{NOT} return NOT;
{SMC} return SMC;
{STR} return STR;
{COMMENT} ;
{BOOL} return BOOL;
{WHILE} return WHILE;
{FOR} return FOR;
{DO} return DO; 
{IF} return IF;
{ELSE} return ELSE;
{ELSEIF} return ELSEIF;
{DEF} return DEF;
{READ_TMP} return READ_TMP;
{READ_ALT} return READ_ALT;
{READ_INC} return READ_INC;
{READ_ACC} return READ_ACC;
{READ_TIME} return READ_TIME;
{CAMERA} return CAMERA;
{TAKE_PICT} return TAKE_PICT;
{CONNECT_WIFI} return CONNECT_WIFI;
{FORWARD} return FORWARD;
{BACKWARD} return BACKWARD;
{SCAN} return SCAN;
{SET_INC} return SET_INC;
{SET_ALT} return SET_ALT;
{MAIN} return MAIN;
{VAR} return VAR;
{COMMA} return COMMA;
{NL} ;
{SPACE} ;
%%

int yywrap()
{
    return 1;
}
