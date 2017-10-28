%{
    #include <stdio.h>
    #include "zoomjoystrong.h"
    extern int yylineno;
    void yyerror(const char* msg) {
          fprintf(stderr, "%s on line no: %d\n", msg, yylineno);
          //yyerror;
    }
    int yylex();
%}

%union{
    int iVal;
    float fVal;
    char* sVal;
}
%start program
%token <sVal>   POINT
%token <sVal>   LINE
%token <sVal>   CIRCLE
%token <sVal>   RECTANGLE
%token <sVal>   SET_COLOR
%token <iVal>   INT
%token <fVal>   FLOAT

%token          END
%token          END_STATEMENT

%%

program         :     statement_list END        //{finish();}
                ;

statement_list  :     statement
                |     statement statement_list
                ;

statement       :     error ';'
                |     zjs END_STATEMENT;

zjs             :     POINT INT INT               {point($2, $3);}
                |     LINE INT INT INT INT        {line($2, $3, $4, $5);}
                |     CIRCLE INT INT INT          {circle($2, $3, $4);}
                |     RECTANGLE INT INT INT INT   {rectangle($2, $3, $4, $5);}
                |     SET_COLOR INT INT INT       {set_color($2, $3, $4);}
                ;

%%

int main(int argc, char** argv){
    setup();
    yyparse();
    //finish();
    return 0;
}

int checkColor(int c1, int c2, int c3){
    return 0;
}
