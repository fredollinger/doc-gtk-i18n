HTML=html
BOOK=i18n

all:
	mkdir -p html
	chmod -R a+w html
	mkdir -p figures
	xmlto -o $(HTML) html  $(BOOK).xml
	cp -a figures $(HTML)
	make install

html2:
	xmlto -o html2 html  $(BOOK)

pdf2:
	xmlto -o pdf pdf  $(BOOK)

dvi:
	xmlto -o $(BOOK).dvi dvi  $(BOOK)

ps:
	xmlto -o $(BOOK).ps ps  $(BOOK)

view:
	lynx $(HTML)/index.html

edit:
	p4 edit  $(BOOK).xml
	vim  $(BOOK).xml
clean:
	rm -rvf html

iview:
	firefox $(HTML)/index.html&
install:
	rsync -varzl $(HTML)/* /var/www/$(BOOK)
submit:
	p4 edit $(BOOK) 
	git commit -a
	p4 submit $(BOOK)
commit:
	make submit
revert:
	p4 revert $(BOOK)
