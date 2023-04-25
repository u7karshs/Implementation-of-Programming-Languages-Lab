%{
    #include "y.tab.h"
%}

%option yylineno

DIGIT                           [0-9]
ID_NON_DIGIT                    [a-zA-Z_]
NON_ZERO_DIGIT                  [1-9]
IDENTIFIERS                     {ID_NON_DIGIT}({DIGIT}|{ID_NON_DIGIT})*
ENUMERATION_CONSTANT            {IDENTIFIERS}
SIGN                            [+-]
DIGIT_SEQUENCE                  {DIGIT}+
INTEGER_CONSTANT                {NON_ZERO_DIGIT}{DIGIT}*|[0]
EXPONENT_PART                   [eE]{SIGN}?{DIGIT_SEQUENCE}      
FRACTIONAL_CONSTANT             ({DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}\.)

ESCAPE_SEQUENCE                 "\\'"|"\\""|"\\?"|"\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"
C_CHAR                          [^\'\n\\]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE                 {C_CHAR}+
CHARACTER_CONSTANT              \'{C_CHAR_SEQUENCE}\'
S_CHAR                          [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE                 {S_CHAR}+
STRING_LITERAL                  \"{S_CHAR_SEQUENCE}?\"
SINGLE_COMMENT_STARTED          "//"
MULTILINE_STARTED               "/*"
MULTILINE_END                   "*/"
WS                              [ \n\t]
%x SINGLE_LINE_COMMENT
%x MULTIPLE_LINE_COMMENT

%%
"char"                          { return CHAR; }
"else"                          { return ELSE; }
"for"                           { return FOR; }
"if"                            { return IF; }
"int"                           { return INT; }
"return"                        { return RETURN; }
"void"                          { return VOID; }

{IDENTIFIERS}                               {return IDENTIFIERS;}
{INTEGER_CONSTANT}                          {return INTEGER_CONSTANT;}
{CHARACTER_CONSTANT}                        {return CHARACTER_CONSTANT;}
{STRING_LITERAL}                            {return STRING_LITERAL;}

"["                             { return LEFT_SQUARE_BRACKET; }
"]"                             { return RIGHT_SQUARE_BRACKET; }
"("                             { return LEFT_PARENTHESIS; }
")"                             { return RIGHT_PARENTHESIS; }
"{"                             { return LEFT_CURLY_BRACKET; }
"}"                             { return RIGHT_CURLY_BRACKET; }
"<="                            { return LESS_THAN_EQUAL; }
">="                            { return GREATER_THAN_EQUAL; }
"->"                            { return ARROW; }
"*"                             { return MULTIPLY; }
"+"                             { return ADD; }
"-"                             { return SUBTRACT; }
"/"                             { return DIVIDE; }
"%"                             { return MODULO; }
"<"                             { return LESS_THAN; }
">"                             { return GREATER_THAN; }
"=="                            { return EQUAL; }
"!="                            { return NOT_EQUAL; }
"&&"                            { return LOGICAL_AND; }
"||"                            { return LOGICAL_OR; }
"?"                             { return QUESTION_MARK; }
":"                             { return COLON; }
";"                             { return SEMICOLON; }
"&"				 { return ADDRESS; }
"!"				 { return NOT; }
"="                             { return ASSIGN; }
","                             { return COMMA; }


{SINGLE_COMMENT_STARTED}                    {BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>.                      {}
<SINGLE_LINE_COMMENT>"\n"                   {BEGIN(INITIAL); }
{MULTILINE_STARTED}                         {BEGIN(MULTIPLE_LINE_COMMENT);}
<MULTIPLE_LINE_COMMENT>.                    {}
<MULTIPLE_LINE_COMMENT>"\n"                 {}
<MULTIPLE_LINE_COMMENT>{MULTILINE_END}      {BEGIN(INITIAL); }
{WS}                                        {}

%%
