/* float2.l just in case
{identifier}(\ )?{equals}(\ )?({identifier}|{digit}+)({op}({identifier}|{digit}+))?
{digit}+        printf("NUMBER");{identifier}[(][ ]{identifier}?[ ](,[ ]{identifier}[ ])*[)] printf(" FUNC_CALL");
{type}[ ]{identifier}[(][ ]({type}[ ]{identifier})?[ ](,[ ]{type}[ ]{identifier}[ ])[)] printf(" FUNC_DECL");    float val;
[+-]?{digit}+ {sscanf(yytext, "%f", &val);printf("NUMBER");}op        [+|\-|*|/|%]void yyerror(char *);
//identifier     ([A-Za-z][A-Za-z0-9]*){float}        {sscanf(yytext, "%lf", &yylval); return(FLOAT);}
{number}    {sscanf(yytext, "%d", &yylval); return(NUMBER);}
true        return(TRUE);
false        return(FALSE);
bool        return(BOOL_TYPE);int a = b
a=10+10
when[ ]             return(WHEN);
*/
%{
#include <stdio.h>
%}
builtin_func     (TEMPERATURE|HUMIDITY|AIR_PRESSURE|AIR_QUALITY|LIGHT|SOUND_LEVEL|TIMESTAMP)
switch        (sw1|sw2|sw3|sw4|sw5|sw6|sw7|sw8|sw9|sw10)
digit         [0-9]
letter        [a-zA-Z]
equals        {space}*[=]{space}*
rel_op          (>=|>|<=|<|==|!=)
integer        ({digit}+)
float         ({integer}*(\.){integer}+)
underscore     _
identifier     {letter}({letter}|{digit}|{underscore})*
alphanumeric    ([A-Za-z0-9]+)
type        (int|float|{BOOL}|string)
nl        "\n"
boolean     TRUE|FALSE|true|false|ON|OFF|on|off
comma        ,
semicolon    \;
space        "\ "
INT         int
FLOAT         {space}*(float){space}*
BOOL         {space}*(boolean|bool){space}*
STRING         {space}*(string){space}*
eof		"##"
%%
{space}*{eof}{space}*			     return(END_OF_FILE);
{space}*[\+]{space}*                  return(PLUS);
{space}*[\-]{space}*                  return(MINUS);
{space}*[\/]{space}*                  return(DIV);
{space}*[\*]{space}*                  return(MUL);
{space}*{float}{space}*              return(FLOAT);
{space}*{integer}{space}*        return(INTEGER);
{semicolon}{space}+			return(SEMICOLON);
for[ ]?                    return(FOR);
if{space}*                      return(IF);	
while[ ]?               return(WHILE);
{space}*else{space}*             return(ELSE);
{boolean}               return(BOOLEAN);
void[ ]             return(VOID);
connect[ ]             return(CONNECT);
{space}*send{space}*               return(SEND);
return[ ]               return(RETURN);
when[ ]			return(WHEN);
TIMESTAMP		return(TIMESTAMP);
{space}*{INT}{space}*            return(INT_TYPE);
{space}*{FLOAT}{space}*            return(FLT_TYPE);
{space}*{STRING}{space}*        return(STR_TYPE);
{space}*{BOOL}{space}*            return(BOOL_TYPE);
CONST[ ]+        return(CONST);
print{space}*            return(PRINT);
"&&"            return(AND);
"||"            return(OR);
{space}*receive{space}*             return(RECEIVE);
\".*\"        return(STRING);
(\/\/)[ ]*.*[ ]*(\/\/)     return(COMMENT);
{switch}        return(SWITCH);
{builtin_func}      return(BUILTIN_FUNC);
{space}*{equals}{space}*                return(EQUALS);
{space}*[{]{space}*                    return(LB);
{space}*[}]{space}*                    return(RB);
{space}*[(]{space}*            return(LP);
{space}*[)]{space}*        return(RP);
{space}*[\[]{space}*        return(SRB);
{space}*[\]]{space}*        return(SLB);
{space}*{identifier}{space}*            return(IDENTIFIER);
"=="                    return(EQ_CMP);
">="                    return(GTEQ_CMP);
"!="                    return(NEQ_CMP);
"<="                    return(LTEQ_CMP);
[<]                     return(LT_CMP);
[>]                     return(GT_CMP);
{space}*{comma}{space}*                return(COMMA);
{space}*www.{alphanumeric}.com{space}*     return(URL);
{nl}         { extern int lineno; lineno++;
                   return NL;
         }
.                   return(yytext[0]);
%%
int yywrap() { return 1; }
