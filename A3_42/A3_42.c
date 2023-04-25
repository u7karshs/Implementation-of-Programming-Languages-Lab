#include<stdio.h>

extern char* yytext;
extern int   yylex();
int main()
{
	int token;
	
	//Interactive Flex
	while(token=yylex())
	{
		switch(token)
		{
		
		case KEYWORD: 
			printf("<KEYWORD, %s>\n", yytext);			break;
 
		case IDENTIFIER: 
			printf("<IDENTIFIER, %s>\n", yytext);		break;
							    	
		case INTEGER_CONSTANT: 
			printf("<INTEGER_CONSTANT, %s>\n", yytext);	break;
		    						
    		case CHAR_CONST: 
			printf("<CHARACTER_CONSTANT, %s>\n", yytext);	break;
									
		case SCHAR_LITERAL: 
			printf("<STRING_LITERAL, %s>\n", yytext);		break;
									
		case PUNCTUATOR: 
			printf("<PUNCTUATOR, %s>\n", yytext);		break;
			
		case SINGLE_LINE: 
			printf("<SINGLE_LINE_COMMENT,> %s\n", yytext);	break;						
									
		case MULTI_LINE: 
			printf("<MULTILINE_COMMNET, %s>\n", yytext);	break;
									
		case WS: break;
		default:   
			printf("<INVALID_TOKEN, %s>\n", yytext); 		break;
		}

	}
  return 0;
}