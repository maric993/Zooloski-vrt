DIR = .
CC = gcc
CFLAGS = -g -Wall `mysql_config --cflags --libs`
PROGS = app



.PHONY: all create trigger insert beauty dist progs
progs:
	gcc app.c -o app -g -Wall `mysql_config --cflags --libs`


all: progs create trigger insert 


create:
	mysql -u root  <create.sql 

trigger: 
	mysql -u root  <triggers.sql
	
insert:
	mysql -u root  <insert.sql


	
beauty:
	-indent $(PROGS).c

clean:
	-rm -f *~ $(PROGS)
	
dist: beauty clean
	-tar -czv -C .. -f ../$(DIR).tar.gz $(DIR)
