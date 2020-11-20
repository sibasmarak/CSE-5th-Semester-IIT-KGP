%{
    #include "stdio.h"
    #include "y.tab.h"
    int line = 1;
%}

%x  COMMENT
%x  SINGLE_LINE_COMMENT
KEYWORD                     "break"|"float"|"static"|"case"|"for"|"struct"|"char"|"goto"|"switch"|"continue"|"if"|"typedef"|"default"|"int"|"union"|"do"|"long"|"void"|"double"|"return"|"while"|"else"|"short"|"extern"|"sizeof"
PUNCTUATORS                 "("|"]"|"["|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
ESCAPE_SEQUENCE             "\\\'"|"\\\""|"\\\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"
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

"break"			            { return(BREAK);                                                    }
"case"			            { return(CASE);                                                     }
"char"			            { return(CHAR);                                                     }
"const"                     { return(CONST);                                                    }
"continue"		            { return(CONTINUE);                                                 }
"default"		            { return(DEFAULT);                                                  }
"do"			            { return(DO);                                                       }
"double"		            { return(DOUBLE);                                                   } 
"else"			            { return(ELSE);                                                     }
"extern"		            { return(EXTERN);                                                   }
"float"                     { return(FLOAT);                                                    }
"for"			            { return(FOR);                                                      }
"goto"			            { return(GOTO);                                                     }
"inline"		            { return(INLINE);                                                   }
"if"			            { return(IF);                                                       }
"int"			            { return(INT);                                                      }
"long"			            { return(LONG);                                                     }
"restrict"		            { return(RESTRICT);                                                 }
"return"		            { return(RETURN);                                                   }
"short"			            { return(SHORT);                                                    }
"sizeof"		            { return(SIZEOF);                                                   }
"static"		            { return(STATIC);                                                   }
"struct"		            { return(STRUCT);                                                   }
"switch"		            { return(SWITCH);                                                   }
"typedef"		            { return(TYPEDEF);                                                  }
"union"			            { return(UNION);                                                    }
"void"			            { return(VOID);                                                     }
"volatile"		            { return(VOLATILE);                                                 }
"while"			            { return(WHILE);                                                    }

{IDENTIFIER}                { return IDENTIFIER;                                                }
{STRING_LITERAL}            { return STRING_LITERAL;                                            }
{INTEGER_CONSTANT}          { return INT_CONST;                                                 }
{FLOAT_CONST}               { return FLOAT_CONST;                                               }
{CHAR_CONSTANT}             { return CHAR_CONST;                                                }
"\n"                        { line++; printf("\n#################### LINE NO : %d ####################\n", line); }
{ESCAPE_SEQUENCE}|" "                     

"/*"                        { BEGIN(COMMENT);                                                   }
<COMMENT>"*/"               { BEGIN(INITIAL);                                                   }
<COMMENT>.                  {                                                                   }
<COMMENT>"\n"               { line++; printf("%d\n", line);                                                           }

"//"                        { BEGIN(SINGLE_LINE_COMMENT);                                       }
<SINGLE_LINE_COMMENT>"\n"   { line++; BEGIN(INITIAL);                                           }
<SINGLE_LINE_COMMENT>.      {                                                                   }    
			
"["                         { return('[');                                                      }
"]"                         { return(']');                                                      }
"("                         { return('(');                                                      }
")"                         { return(')');                                                      }
"{"                         { return('{');                                                      }
"}"                         { return('}');                                                      }
"."                         { return('.');                                                      }
"->"                        { return(ARROW);                                                    } 
"++"                        { return(INCREMENT);                                                }
"--"                        { return(DECREMENT);                                                }
"&"                         { return('&');                                                      }
"*"                         { return(MULT);                                                     }
"+"                         { return('+');                                                      }
"-"                         { return(MINUS);                                                    }
"~"                         { return('~');                                                      }
"!"                         { return('!');                                                      }
"/"                         { return('/');                                                      }
"%"                         { return('%');                                                      }
">>"                        { return(RSHIFT);                                                   }
"<<"                        { return(LSHIFT);                                                   }
"<"                         { return('<');                                                      }
">"                         { return('>');                                                      }
"<="                        { return(LEQ);                                                      }
">="                        { return(GEQ);                                                      }
"=="                        { return(EQ);                                                       }
"!="                        { return(NEQ);                                                      } 
"^"                         { return('^');                                                      } 
"|"                         { return('|');                                                      }
"||"                        { return(OR);                                                       }
"&&"                        { return(AND);                                                      }
"?"                         { return('?');                                                      }
":"                         { return(':');                                                      }
";"                         { return(';');                                                      }
"..."                       { return(ELLIPSIS);                                                 }
"="                         { return('=');                                                      }
"*="                        { return(MULT_ASSIGN);                                              }
"/="                        { return(DIV_ASSIGN);                                               }
"%="                        { return(MOD_ASSIGN);                                               }
"+="                        { return(ADD_ASSIGN);                                               }
"-="                        { return(SUB_ASSIGN);                                               }
"<<="                       { return(LSHIFT_ASSIGN);                                            }
">>="                       { return(RSHIFT_ASSIGN);                                            }
"&="                        { return(BIN_AND_ASSIGN);                                           }
"^="                        { return(BIN_XOR_ASSIGN);                                           }
"|="                        { return(BIN_OR_ASSIGN);                                            }
","                         { return(',');                                                      }
"#"                         { return('#');                                                      }

%%

