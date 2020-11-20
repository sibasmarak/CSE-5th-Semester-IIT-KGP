%{
    #include "stdio.h"
    #define KEYWORD 258
    #define IDENTIFIER 259
    #define PUNCTUATORS 260
    #define STRING_LITERAL 261
    #define INT_CONST 262
    #define FLOAT_CONST 263
    #define CHAR_CONSTANT 264
    #define MULTI_COMMENT 265
    #define SINGLE_COMMENT 266
    #define WS 267
    #define MULTI_COMMENT_START 268
    #define MULTI_COMMENT_END 269
    #define SINGLE_COMMENT_START 270
    #define SINGLE_COMMENT_END 271
    
%}

%x  COMMENT
%x  SINGLE_LINE_COMMENT
KEYWORD                     "break"|"float"|"static"|"case"|"for"|"struct"|"char"|"goto"|"switch"|"continue"|"if"|"typedef"|"default"|"int"|"union"|"do"|"long"|"void"|"double"|"return"|"while"|"else"|"short"|"extern"|"sizeof"
PUNCTUATORS                 "("|"]"|"["|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
ESCAPE_SEQUENCE             "\\\'"|"\\\""|"\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"
DIGIT                       [0-9]
IDENTIFIER                  [a-zA-Z_][a-zA-Z0-9_]*
S_CHAR                      [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE             {S_CHAR}+
STRING_LITERAL              \"({S_CHAR_SEQUENCE})?\"
INTEGER_CONSTANT            [1-9][0-9]*|[0]+
C_CHAR                      [^\'\n\\]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE             ({C_CHAR})+
CHAR_CONSTANT               \'({C_CHAR_SEQUENCE})\'        
DIGIT_SEQUENCE              [0-9]+
EXPONENT_PART               ([Ee]([+-]?)({DIGIT_SEQUENCE}))
FRAC_CONSTANT               {DIGIT_SEQUENCE}\.|{DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE}
FLOAT_CONST                 ({DIGIT_SEQUENCE}{EXPONENT_PART})|({FRAC_CONSTANT}{EXPONENT_PART}?)
CONST                       {INTEGER_CONSTANT}|{CHAR_CONSTANT}|{FLOAT_CONST}

%%

{KEYWORD}                   { return KEYWORD;                                                   }
{IDENTIFIER}                { return IDENTIFIER;                                                }
{PUNCTUATORS}               { return PUNCTUATORS;                                               }
{STRING_LITERAL}            { return STRING_LITERAL;                                            }
{INTEGER_CONSTANT}          { return INT_CONST;                                                 }
{FLOAT_CONST}               { return FLOAT_CONST;                                               }
{CHAR_CONSTANT}             { return CHAR_CONSTANT;                                             }
{ESCAPE_SEQUENCE}|" "                     

"/*"                        { BEGIN(COMMENT); return MULTI_COMMENT_START;                       }
<COMMENT>"*/"               { BEGIN(INITIAL); return MULTI_COMMENT_END;                         }
<COMMENT>.                  { return MULTI_COMMENT;                                             }
<COMMENT>"\n"               { return MULTI_COMMENT;                                             }

"//"                        { BEGIN(SINGLE_LINE_COMMENT); return SINGLE_COMMENT_START;          }
<SINGLE_LINE_COMMENT>"\n"   { BEGIN(INITIAL); return SINGLE_COMMENT_END;                        }
<SINGLE_LINE_COMMENT>.      { return SINGLE_COMMENT;                                            }    

%%

