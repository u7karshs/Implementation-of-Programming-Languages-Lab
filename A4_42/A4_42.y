%{
    #include <stdio.h>
    extern int yylex();
    extern char* yytext;
    extern int yylineno;
    void yyerror(char *s);
%}

%union {
    int int_val;
    char char_val;
    char *string_val;
}
%token CHAR
%token ELSE
%token FOR
%token IF
%token NOT
%token ADDRESS
%token INT
%token RETURN
%token VOID
%token <string_val> IDENTIFIERS
%token <int_val> INTEGER_CONSTANT
%token <char_val> CHARACTER_CONSTANT
%token <string_val> STRING_LITERAL
%left  LEFT_SQUARE_BRACKET  RIGHT_SQUARE_BRACKET ARROW
%token LEFT_CURLY_BRACKET
%token RIGHT_CURLY_BRACKET 
%left MULTIPLY DIVIDE MODULO 
%left ADD SUBTRACT
%left LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL
%left  EQUAL NOT_EQUAL
%left LOGICAL_AND LOGICAL_OR
%right QUESTION_MARK COLON
%right ASSIGN
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token SEMICOLON

%token COMMA

%nonassoc RIGHT_PARENTHESIS
%nonassoc ELSE

%start translation_unit

%%

primary_expression: IDENTIFIERS																										{ printf("Line no. %d: primary-expression --> identifier\n",yylineno); }
                  | INTEGER_CONSTANT																								{ printf("Line no. %d: primary-expression --> integer_constant\n",yylineno); }
		  | CHARACTER_CONSTANT																								{ printf("Line no. %d: primary_expression --> character_constant\n",yylineno); }
                  |STRING_LITERAL																									{ printf("Line no. %d: primary-expression --> string-literal\n",yylineno); }
                  | LEFT_PARENTHESIS expression RIGHT_PARENTHESIS																	{ printf("Line no. %d: primary-expression --> ( expression )\n",yylineno); }
                  ;


postfix_expression: primary_expression																								{ printf("Line no. %d: postfix-expression --> primary-expression\n",yylineno); }
                  | postfix_expression LEFT_SQUARE_BRACKET expression RIGHT_SQUARE_BRACKET												
                  { printf("Line no. %d: postfix-expression --> postfix-expression [ expression ]\n",yylineno); }
                  | postfix_expression LEFT_PARENTHESIS argument_expression_list_opt RIGHT_PARENTHESIS								
                  { printf("Line no. %d: postfix-expression --> postfix-expression ( argument-expression-list-opt )\n",yylineno); }
                    | postfix_expression ARROW IDENTIFIERS																				
                    { printf("Line no. %d: postfix-expression --> postfix-expression -> identifier\n",yylineno); }
                  ;

argument_expression_list_opt: argument_expression_list																				
{ printf("Line no. %d: argument-expression-list-opt --> argument-expression-list\n",yylineno); }
                            |																										{ printf("Line no. %d: argument-expression-list-opt --> epsilon\n",yylineno); }
                            ;


argument_expression_list: assignment_expression																					
{ printf("Line no. %d: argument-expression-list --> assignment-expression\n",yylineno); }
                        | argument_expression_list COMMA assignment_expression														
                        { printf("Line no. %d: argument-expression-list --> argument-expression-list , assignment-expression\n",yylineno); }
                        ;

unary_expression: postfix_expression																								{ printf("Line no. %d: unary-expression --> postfix-expression\n",yylineno); }
               | unary_operator unary_expression																					
               { printf("Line no. %d: unary-operator --> unary-expression\n",yylineno); }
                ;
                
unary_operator:								
               ADDRESS																											{ printf("Line no. %d: unary-operator --> &\n",yylineno); }
              | NOT																													{ printf("Line no. %d: unary-operator --> !\n",yylineno); }
              |MULTIPLY																											{ printf("Line no. %d: unary-operator --> *\n",yylineno); }
              | ADD																													{ printf("Line no. %d: unary-operator --> +\n",yylineno); }
              | SUBTRACT																											{ printf("Line no. %d: unary-operator --> -\n",yylineno); }
              ;
              

multiplicative_expression: unary_expression																							{ printf("Line no. %d: multiplicative-expression --> unary-expression\n",yylineno); }
                         | multiplicative_expression MULTIPLY unary_expression														
                         { printf("Line no. %d: multiplicative-expression --> multiplicative-expression * unary-expression\n",yylineno); }
                         | multiplicative_expression DIVIDE unary_expression															
                         { printf("Line no. %d: multiplicative-expression --> multiplicative-expression / unary-expression\n",yylineno); }
                         | multiplicative_expression MODULO unary_expression															
                         { printf("Line no. %d: multiplicative-expression --> multiplicative-expression %% unary-expression\n",yylineno); }
                         ;

additive_expression: multiplicative_expression																						{ printf("Line no. %d: additive-expression --> multiplicative-expression\n",yylineno); }
                   | additive_expression ADD multiplicative_expression																{ printf("Line no. %d: additive-expression --> additive-expression + multiplicative-expression\n",yylineno); }
                   | additive_expression SUBTRACT multiplicative_expression															
                   { printf("Line no. %d: additive-expression --> additive-expression - multiplicative-expression\n",yylineno); }
                   ;

relational_expression: additive_expression																								{ printf("Line no. %d: relational-expression --> additive-expression\n",yylineno); }
                     | relational_expression LESS_THAN additive_expression																{ printf("Line no. %d: relational-expression --> relational-expression < shift-expression\n",yylineno); }
                     | relational_expression GREATER_THAN additive_expression															{ printf("Line no. %d: relational-expression --> relational-expression > shift-expression\n",yylineno); }
                     | relational_expression LESS_THAN_EQUAL additive_expression														
                     { printf("Line no. %d: relational-expression --> relational-expression <= shift-expression\n",yylineno); }
                     | relational_expression GREATER_THAN_EQUAL additive_expression													
                     { printf("Line no. %d: relational-expression --> relational-expression >= shift-expression\n",yylineno); }
               
                     ;
                     
equality_expression: relational_expression																							{ printf("Line no. %d: equality-expression --> relational-expression\n",yylineno); }
                   | equality_expression EQUAL relational_expression																
                   { printf("Line no. %d: equality-expression --> equality-expression == relational-expression\n",yylineno); }
                   | equality_expression NOT_EQUAL relational_expression															
                   { printf("Line no. %d: equality-expression --> equality-expression != relational-expression\n",yylineno); }
                   ;

logical_and_expression: equality_expression																						
{ printf("Line no. %d: logical-AND-expression --> equality-expression\n",yylineno); }
                      | logical_and_expression LOGICAL_AND equality_expression													
                      { printf("Line no. %d: logical-AND-expression --> logical-AND-expression && equality-expression\n",yylineno); }
                      ;

logical_or_expression: logical_and_expression																						
{ printf("Line no. %d: logical-OR-expression --> logical-AND-expression\n",yylineno); }
                     | logical_or_expression LOGICAL_OR logical_and_expression														
                     { printf("Line no. %d: logical-OR-expression --> logical_or_expression || logical-AND-expression\n",yylineno); }
                     ;

conditional_expression: logical_or_expression																						
{ printf("Line no. %d: conditional-expression --> logical-OR-expression\n",yylineno); }
                      | logical_or_expression QUESTION_MARK expression COLON conditional_expression									
                      { printf("Line no. %d: conditional-expression --> logical-OR-expression ? expression : conditional-expression\n",yylineno); }
                      ;

assignment_expression: conditional_expression																						
{ printf("Line no. %d: assignment-expression --> conditional-expression\n",yylineno); }
                     | unary_expression ASSIGN assignment_expression													
                     { printf("Line no. %d: assignment-expression --> unary-expression assignment-operator assignment-expression\n",yylineno); }
                     ;

expression: assignment_expression																									{ printf("Line no. %d: expression --> assignment-expression\n",yylineno); }
          ;


declaration: type_specifier init_declarator SEMICOLON
{ printf("Line no. %d: declaration --> declaration-specifiers init-declarator-list-opt ;\n",yylineno); }
           ;


init_declarator: declarator																											{ printf("Line no. %d: init-declarator --> declarator\n",yylineno); }
               | declarator ASSIGN initializer 																						
               { printf("Line no. %d: init-declarator --> declarator = initializer\n",yylineno); }
               ;


type_specifier: VOID																												{ printf("Line no. %d: type-specifier --> void\n",yylineno); }
              | CHAR																												{ printf("Line no. %d: type-specifier --> char\n",yylineno); }
            
              | INT																												{ printf("Line no. %d: type-specifier --> int\n",yylineno); }
              ;

declarator: pointer_opt direct_declarator
{ printf("Line no. %d: declarator --> pointer-opt direct-declarator\n",yylineno); }
          ;

pointer_opt: pointer																												{ printf("Line no. %d: pointer-opt --> pointer\n",yylineno); }
           |																														{ printf("Line no. %d: pointer-opt --> epsilon\n",yylineno); }
           ;

direct_declarator: IDENTIFIERS																										{ printf("Line no. %d: direct-declarator --> identifier\n",yylineno); }
		 | IDENTIFIERS LEFT_SQUARE_BRACKET INTEGER_CONSTANT RIGHT_SQUARE_BRACKET																	
		 { printf("Line no. %d: direct-declarator --> [ INTEGER-CONSTANT ]\n",yylineno); }
                 | IDENTIFIERS LEFT_PARENTHESIS parameter_list_opt RIGHT_PARENTHESIS																	
                 { printf("Line no. %d: direct-declarator --> ( parameter-type-list )\n",yylineno); }
                 ;

pointer: MULTIPLY 																							{ printf("Line no. %d: pointer -->  \n",yylineno); }
       ;

parameter_list_opt: parameter_list																									{ printf("Line no. %d: parameter-type-list --> parameter-list\n",yylineno); }
                 |
                 { printf("Line no. %d: parameter-type-list --> epsilon\n",yylineno); }
                   ;

parameter_list: parameter_declaration																								{ printf("Line no. %d: parameter-list --> parameter-declaration\n",yylineno); }
              | parameter_list COMMA parameter_declaration																			
              { printf("Line no. %d: parameter-list --> parameter-list , parameter-declaration\n",yylineno); }
              ;

identifier_opt:
IDENTIFIERS
{ printf("Line no. %d: identifier-opt --> IDENTIFIERS\n",yylineno); }
|
{ printf("Line no. %d: identifier-opt --> epsilon\n",yylineno); }
;

parameter_declaration: type_specifier pointer_opt identifier_opt											
{ printf("Line no. %d: parameter-declaration --> declaration-specifiers declarator\n",yylineno); }
                     ;

initializer: assignment_expression																									{ printf("Line no. %d: initializer --> assignment-expression\n",yylineno); }
           ;

statement: compound_statement																										{ printf("Line no. %d: statement --> compound-statement\n",yylineno); }
         | expression_statement																										{ printf("Line no. %d: statement --> expression-statement\n",yylineno); }
         | selection_statement																										{ printf("Line no. %d: statement --> selection-statement\n",yylineno); }
         | iteration_statement																										{ printf("Line no. %d: statement --> iteration-statement\n",yylineno); }
         | jump_statement																											{ printf("Line no. %d: statement --> jump-statement\n",yylineno); }
         ;


compound_statement: LEFT_CURLY_BRACKET block_item_list_opt RIGHT_CURLY_BRACKET															{ printf("Line no. %d: compound-statement --> { block-item-list-opt }\n",yylineno); }
                  ;

block_item_list_opt: block_item_list																								{ printf("Line no. %d: block-item-list-opt --> block-item-list\n",yylineno); }
                   |																												{ printf("Line no. %d: block-item-list-opt --> epsilon\n",yylineno); }
                   ;

block_item_list: block_item																											{ printf("Line no. %d: block-item-list --> block-item\n",yylineno); }
               | block_item_list block_item																							
               { printf("Line no. %d: block-item-list --> block-item-list block-item\n",yylineno); }
               ;

block_item: declaration																												{ printf("Line no. %d: block-item --> declaration\n",yylineno); }
          | statement																												{ printf("Line no. %d: block-item --> statement\n",yylineno); }
          ;

expression_statement: expression_opt SEMICOLON																						
{ printf("Line no. %d: expression-statement --> expression-opt ;\n",yylineno); }
                    ;

expression_opt: expression																											{ printf("Line no. %d: expression-opt --> expression\n",yylineno); }
              |																														{ printf("Line no. %d: expression-opt --> epsilon\n",yylineno); }
              ;

selection_statement: IF LEFT_PARENTHESIS expression RIGHT_PARENTHESIS statement														
{ printf("Line no. %d: selection-statement --> if ( expression ) statement\n",yylineno); }
                   | IF LEFT_PARENTHESIS expression RIGHT_PARENTHESIS statement ELSE statement										
                   { printf("Line no. %d: selection-statement --> if ( expression ) statement else statement\n",yylineno); }
                   ;

iteration_statement: 
                    FOR LEFT_PARENTHESIS expression_opt SEMICOLON expression_opt SEMICOLON expression_opt RIGHT_PARENTHESIS statement							
                    { printf("Line no. %d: iteration-statement --> for ( expression-opt ; expression-opt ; expression-opt ) statement\n",yylineno); }
                   ;

jump_statement:
               RETURN expression_opt SEMICOLON																						
               { printf("Line no. %d: jump-statement --> return expression-opt ;\n",yylineno); }
              ;


translation_unit: external_declaration																								{ printf("Line no. %d: translation-unit --> external-declaration\n",yylineno); }
                | translation_unit external_declaration																				
                { printf("Line no. %d: translation-unit --> translation-unit external-declaration\n",yylineno); }
                ;

external_declaration:
declaration																									{ printf("Line no. %d: external-declaration --> declaration\n",yylineno); } 
                    | function_definition																							{ printf("Line no. %d: external-declaration --> function-definition\n",yylineno); }
                    ;

function_definition: type_specifier declarator declaration_list_opt compound_statement										
{ printf("Line no. %d: function-definition --> declaration-specifiers declarator declaration-list-opt compound-statement\n",yylineno); }
                   ;

declaration_list_opt: declaration_list																								{ printf("Line no. %d: declaration-list-opt --> declaration-list\n",yylineno); }
                    |																												{ printf("Line no. %d: declaration-list-opt --> epsilon\n",yylineno); }
                    ;

declaration_list: declaration																										{ printf("Line no. %d: declaration-list --> declaration\n",yylineno); }
                | declaration_list declaration																						
                { printf("Line no. %d: declaration-list --> declaration-list declaration\n",yylineno); }
                ;

%%

void yyerror(char *s) {
    printf("Error occured!      line no.: %d       Error: %s      Unable to parse: %s\n",yylineno, s, yytext);  
    printf("Parsing process terminated due to error.");
}
