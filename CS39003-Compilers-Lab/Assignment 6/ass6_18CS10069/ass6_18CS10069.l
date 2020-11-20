%{
	/**
	* Authors  : Debajyoti Dasgupta (18CS30051) [debajyotidasgupta6@gmail.com]
	*            Siba Smarak Panigrahi (18CS10069) [sibasmarak.p@gmail.com]
	* Language : C++14
	* Desc     : header file for the translation statements
	* Date     : 24.10.2020
	* Project  : TinyC
	* Course   : CS39003 Compilers Laboratory
	*/

	#include <stdio.h>
	#include <string.h>
	#include "ass6_18CS10069_translator.h"
	#include "ass6_18CS10069.tab.h"
    extern YYSTYPE yylval;
    extern int line;
    int line = 1;
%}
/*Definition of regular expression*/

%option noyywrap


/* Regular Expression Definations */
LETTER          [a-zA-Z]
DIGIT           [0-9]
NON_ZERO        [1-9]
DIGIT_SEQ       {DIGIT}{DIGIT}*
ESCAPE_SEQ      "\\\'"|"\\\""|"\\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"
C_CHAR          [^\'\\\n]|{ESCAPE_SEQ}
S_CHAR          [^\"\\\n]|{ESCAPE_SEQ}
CHAR_SEQ        {C_CHAR}{C_CHAR}*
STRING_SEQ      {S_CHAR}{S_CHAR}*

IDENTIFIER      ({LETTER}|"_")({LETTER}|{DIGIT}|"_")*

FRAC            {DIGIT_SEQ}\.|\.{DIGIT_SEQ}|{DIGIT_SEQ}\.{DIGIT_SEQ}
FLOAT_CONST     ({FRAC}|{DIGIT_SEQ})([Ee]([-+]{DIGIT_SEQ}|{DIGIT_SEQ}))|{FRAC}|"0"*\."0"*
INT_CONST       {NON_ZERO}{DIGIT}*|"0"+
CHAR_CONST      \'{CHAR_SEQ}\'

STRING          \"{STRING_SEQ}\"|\"\"
COMMENT_LINE    "//".*
COMMENT_MULTI   "/*"([^*]|\*+[^/*])*\**(\*"/")? 
WS              [ \t]
NEWLINE         [\n]

%%

{COMMENT_LINE}          { /*printf("This single line comment will be ignored by the parser\n");*/ }
{COMMENT_MULTI}         { /*printf("This multi line comment will be ignored by the parser\n");*/  }

"if"                    { return IF;       }
"do"                    { return DO;       }
"for"                   { return FOR;      }
"int"                   { return INT;      }
"long"                  { return LONG;     }
"else"                  { return ELSE;     }
"char"                  { return CHAR;     }
"case"                  { return CASE;     }
"goto"                  { return GOTO;     }
"void"                  { return VOID;     }
"short"                 { return SHORT;    }
"float"                 { return FLOAT;    }
"break"                 { return BREAK;    }
"const"                 { return CONST;    }
"union"                 { return UNION;    }
"while"                 { return WHILE;    }
"switch"                { return SWITCH;   }
"static"                { return STATIC;   }
"struct"                { return STRUCT;   }
"extern"                { return EXTERN;   }
"sizeof"                { return SIZEOF;   }
"inline"                { return INLINE;   }
"double"                { return DOUBLE;   }
"return"                { return RETURN;   }
"typedef"               { return TYPEDEF;  }
"default"               { return DEFAULT;  }
"volatile"              { return VOLATILE; }
"restrict"              { return RESTRICT; }
"continue"              { return CONTINUE; }

"..."                   { return DOTS;     }
"<<="                   { return SHLEQ;    }
">>="                   { return SHREQ;    }
"++"                    { return INC;      }
"--"                    { return DEC;      }
"->"                    { return ACC;      }
"<<"                    { return SHL;      }
">>"                    { return SHR;      }
"<="                    { return LTE;      }
">="                    { return GTE;      }
"=="                    { return EQ;       }
"!="                    { return NEQ;      }
"&&"                    { return AND;      }
"||"                    { return OR;       }
"*="                    { return STAREQ;   }
"/="                    { return DIVEQ;    }
"%="                    { return MODEQ;    }
"+="                    { return PLUSEQ;   }
"-="                    { return MINUSEQ;  }
"&="                    { return BINANDEQ; }
"^="                    { return BINXOREQ; }
"|="                    { return BINOREQ;  }

"["                     { return SQBRAOPEN;   }
"]"                     { return SQBRACLOSE;  }
"("                     { return ROBRAOPEN;   }
")"                     { return ROBRACLOSE;  }
"{"                     { return CURBRAOPEN;  }
"}"                     { return CURBRACLOSE; }

";"                     { return SEMICOLON; }

"."                     { return DOT;       }
"&"                     { return AMP;       }
"*"                     { return MUL;       }
"+"                     { return ADD;       }
"-"                     { return SUB;       }
"~"                     { return NEG;       }
"/"                     { return DIV;       }
"#"                     { return HASH;      }
":"                     { return COLON;     }
"|"                     { return BITOR; 	}
","                     { return COMMA;     }
"="                     { return ASSIGN;    }
"<"                     { return BITSHL;    }
"^"                     { return BITXOR;	}
">"                     { return BITSHR;    }
"%"                     { return MODULO;    }
"!"                     { return EXCLAIM;   }
"?"                     { return QUESTION;  }

{INT_CONST}             { 
	                        yylval.intval = atoi(yytext);
							return INTEGER_CONSTANT; /* Constant Rule */ 
                        }
{CHAR_CONST}            { 
	                        yylval.charval = yytext;
							return CHARACTER_CONSTANT; /* Constant Rule */ 
						}
{FLOAT_CONST}           { 
	                        yylval.charval = yytext;
	                        return FLOATING_CONSTANT; /* Constant Rule */ 
						}

{IDENTIFIER}            { 
	                        yylval.symp = table->lookup(yytext);
							return IDENTIFIER; /* Identifier Rule */ 
						}

{STRING}                { 
	                        yylval.charval = yytext;
							return STRING_LITERAL; /* String-literal */ 
						}

{WS}                    { /*White-space Rule*/ }

{NEWLINE}               { /* printf("\n\n============================== Parsing line %d ============================== \n\n", ++line ); */ }

%%