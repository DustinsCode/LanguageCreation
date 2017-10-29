%{
    /**
    * Parser for ZoomJoyStrong language for CIS 343
    *
    * @author Dustin Thurston
    */
    #include <stdio.h>
    #include <stdlib.h>
    #include "zoomjoystrong.h"
    extern int yylineno;
    void yyerror(const char* msg) {
          fprintf(stderr, "%s on line no: %d\n", msg, yylineno);
          //yyerror;
    }
    int yylex();
    void checkColor();
    int checkValue();
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

program         :     statement_list END END_STATEMENT       {finish();};

statement_list  :     statement
                |     statement statement_list
                ;

statement       :     zjs END_STATEMENT;

zjs             :     POINT INT INT               {point(checkValue($2), checkValue($3));}
                |     LINE INT INT INT INT        {line(checkValue($2), checkValue($3),checkValue($4), checkValue($5));}
                |     CIRCLE INT INT INT          {circle(checkValue($2), checkValue($3),checkValue($4));}
                |     RECTANGLE INT INT INT INT   {rectangle(checkValue($2), checkValue($3),checkValue($4), checkValue($5));}
                |     SET_COLOR INT INT INT       {checkColor(checkValue($2), checkValue($3),checkValue($4));}
                ;
%%

int main(int argc, char** argv){
    setup();
    yyparse();
    //finish();
    return 0;
}

/**
* Checks for valid RGB color code format
*
* @param c1 RED
* @param c2 GREEN
* @param c3 BLUE
*/
void checkColor(int c1, int c2, int c3){
    if((c1 >= 0 && c1 <= 255) && (c2 >= 0 && c2 <= 255) && (c3 >=0 && c3 <= 255)){
        set_color(c1,c2,c3);
    }else{
        printf("color code must be between 0 and 255\n");
    }
}

/**
* Checks that value is non-negative integer
*
* @param num number to check for validation
* @return either the number, if valid, or -1 which will throw an error
*/
int checkValue(int num){
    if(num >=0){
        return num;
    }else{
        printf("parameter must be a positive integer\n");
        return -1;
    }
}
