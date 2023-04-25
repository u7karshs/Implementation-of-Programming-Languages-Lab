%{
	/*Defining the Token Classes*/
	#define KEYWORD 1
	#define IDENTIFIER 2
	#define INTEGER_CONSTANT 3
	#define CHAR_CONST 4
	#define SCHAR_LITERAL 5
	#define PUNCTUATOR 6
	#define SINGLE_LINE 7
	#define MULTI_LINE 8
	#define WS 9
%}
/*These are the regular expression definitions*/
KEYWORD 	"char"|"else"|"for"|"if"|"int"|"return"|"void"
DIGIT 	  [0-9]
DIGIT_NOTZERO [1-9]
ALPHABET 	  [a-zA-Z_]
IDENTIFIER    {ALPHABET}({ALPHABET}|{DIGIT})*
ZERO		  [0]
SIGN 	        [+-]
INTEGER_CONST ({DIGIT_NOTZERO}{DIGIT}*)|{ZERO}+|[-]({DIGIT_NOTZERO}{DIGIT}*)
ESCAPE	  "\\'"|"\\""|"\\?"|"\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"

CHAR_SET 		{ESCAPE}|[^("\'"|"\\"|"\n")]
CHAR_SEQ 		{CHAR_SET}+
SINGLE_QUOTE	"\'"
DOUBLE_QUOTE	"\""
CHAR_CONST 	{SINGLE_QUOTE}{CHAR_SEQ}{SINGLE_QUOTE}
CONSTANT 	{INTEGER_CONST}|{CHAR_CONST}

SCHAR_SET	  {ESCAPE}|[^("\""|"\\"|"\n")]
SCHAR_SEQ	  {SCHAR_SET}+
SCHAR_LITERAL {DOUBLE_QUOTE}{SCHAR_SEQ}{DOUBLE_QUOTE}

PUNCTUATOR 	"["|"]"|"("|")"|"{"|"}"|"->"|"&"|"*"|"+"|"-"|"/"|"%"|"!"|"?"|"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"|"="|":"|";"|","


SINGLE_LINE	    "//"[^\n]*
NOT_STAR	    [^"*"]|\n
NOT_SLASH	    [^"/"]|\n
NOT_SLASH_STAR  [^"*""/]|\n
MULTI_LINE	    "/*"{NOT_STAR}*"*"("*"|({NOT_SLASH_STAR}{NOT_STAR}*"*"))*"/"
WS		[ \t\n]

%%
{KEYWORD}		{return KEYWORD;} 		/*Keyword Rule*/
{IDENTIFIER}	{return IDENTIFIER;}		/*Identifier Rule*/
{INTEGER_CONST}	{return INTEGER_CONSTANT;}	/*Integer Constant Rule*/
{CHAR_CONST}	{return CHAR_CONST;} 		/*Character Constant Rule*/
{SCHAR_LITERAL}	{return SCHAR_LITERAL;} 	/*String Literal Rule*/
{PUNCTUATOR}	{return PUNCTUATOR;} 		/*Punctuator Rule*/
{SINGLE_LINE}	{return SINGLE_LINE;} 		/*Single Line Comment*/
{MULTI_LINE}	{return MULTI_LINE;} 		/*Multi Line Comment*/
{WS}			{;}					/*White Space Rule*/

%%