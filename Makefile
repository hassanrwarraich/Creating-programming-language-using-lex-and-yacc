CC = gcc
firstStart: yacc y.tab.c
	${CC} -o parser y.tab.c
yacc: lex lex.yy.c
	yacc yacc.y
lex: lex.l
	lex lex.l
clean:
	rm -f lex.yy.c y.tab.c parser
