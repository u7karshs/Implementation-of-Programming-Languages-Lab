%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "A5_42_translator.h"
    #include "A5_42.tab.h"
    int lineCount = 1;
%}

%option noyywrap

%x MULTI_LINE_COMMENT_BODY
%x SINGLE_LINE_COMMENT_BODY

ESCAPE_SEQUENCE         "\\\'"|"\\\""|"\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"

IDENTIFIER              [A-Za-z_][A-Za-z0-9_]*

DIGIT                   [0-9]
DIGIT_SEQUENCE          {DIGIT}+
NONZERO_DIGIT           [1-9]
INTEGER_CONSTANT        {NONZERO_DIGIT}{DIGIT}*|"0"


C_CHAR                  [^\'\n\\]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE         {C_CHAR}+
CHARACTER_CONSTANT      \'{C_CHAR_SEQUENCE}\'

S_CHAR                  [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE         {S_CHAR}+
STRING_LITERAL          \"({S_CHAR_SEQUENCE}?)\"

WHITESPACE              [ \t]
NEWLINE                 \n

%%


"char"                          { return CHARTYPE; }
"const"                         { return CONST; }
"else"                          { return ELSE; }
"for"                           { return FOR; }
"if"                            { return IF; }
"int"                           { return INTTYPE; }
"return"                        { return RETURN; }
"void"                          { return VOIDTYPE; }

{IDENTIFIER}                    { yylval.symbol = currentTable->lookup(yytext);; return IDENTIFIER; }
{INTEGER_CONSTANT}              { yylval.intVal = atoi(yytext); return INTEGER_CONSTANT; }
{CHARACTER_CONSTANT}            { yylval.charVal = strdup(yytext); return CHARACTER_CONSTANT; }
{STRING_LITERAL}                { yylval.stringVal = strdup(yytext); return STRING_LITERAL; }

"["                             { return LEFT_SQUARE_BRACKET; }
"/"                             { return SLASH; }
"?"                             { return QUESTION_MARK; }
"="                             { return ASSIGNMENT; }
","                             { return COMMA; }
"]"                             { return RIGHT_SQUARE_BRACKET; }
"("                             { return LEFT_PARENTHESES; }
"{"                             { return LEFT_CURLY_BRACKET; }
"}"                             { return RIGHT_CURLY_BRACKET; }
"."                             { return DOT; }
"->"                            { return ARROW; }
"*"                             { return ASTERISK; }
"+"                             { return PLUS; }
"-"                             { return MINUS; }
"!"                             { return EXCLAMATION; }
"%"                             { return MODULO; }
"<"                             { return LESS_THAN; }
">"                             { return GREATER_THAN; }
"<="                            { return LESS_EQUAL_THAN; }
">="                            { return GREATER_EQUAL_THAN; }
":"                             { return COLON; }
";"                             { return SEMI_COLON; }
")"                             { return RIGHT_PARENTHESES; }
"&"                             { return ADDRESS; }
"=="                            { return EQUALS; }
"!="                            { return NOT_EQUALS; }
"&&"                            { return LOGICAL_AND; }
"||"                            { return LOGICAL_OR; }

"/*"                            { BEGIN(MULTI_LINE_COMMENT_BODY); }
<MULTI_LINE_COMMENT_BODY>"*/"   { BEGIN(INITIAL); }
<MULTI_LINE_COMMENT_BODY>.      { }
<MULTI_LINE_COMMENT_BODY>"\n"   { lineCount++; }

"//"                            { BEGIN(SINGLE_LINE_COMMENT_BODY); }
<SINGLE_LINE_COMMENT_BODY>"\n"  { BEGIN(INITIAL);  }
<SINGLE_LINE_COMMENT_BODY>.     { }

{WHITESPACE}                    { }
{NEWLINE}                       { lineCount++;  }
.                               { printf("ERROR [Line %d] : Invalid token %s\n", lineCount, yytext); return INVALID_TOKEN; }

%%
