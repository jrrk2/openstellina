
%token EOF
%token LPAREN RPAREN
%token <float> NUM
%token PLUS MINUS MULTIPLY DIVIDE CARET LT GT AND OR
%token <string> VAR

%left OR
%left AND
%left LT
%left GT
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left NEG	/* negation -- unary minus */
%right CARET	/* exponentiation */

%start item
%type <Calc.expr> item

/* Grammar follows */
%%

tree:  exp_lst EOF	{ List.rev $1 }
;

exp_lst: { [] }
        | exp_lst exp { $2 :: $1 }


item:  exp EOF	{ $1 }
;

exp:	NUM			{ Num $1 }
	| VAR			{ Var $1 }
	| VAR LPAREN exp RPAREN	{ Func ($1, $3) }
	| exp PLUS exp		{ Add ($1, $3) }
	| exp MINUS exp		{ Sub ($1, $3) }
	| exp MULTIPLY exp	{ Mul ($1, $3) }
	| exp DIVIDE exp	{ Div ($1, $3) }
	| exp LT exp		{ Lt ($1, $3) }
	| exp GT exp		{ Gt ($1, $3) }
	| exp AND exp		{ And ($1, $3) }
	| exp OR exp		{ Or ($1, $3) }
	| MINUS exp %prec NEG	{ Neg $2 }
	| exp CARET exp		{ Caret($1, $3) }
	| LPAREN exp RPAREN	{ $2 }
;

%%
