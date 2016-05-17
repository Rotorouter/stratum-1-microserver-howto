.SUFFIXES: .html .asc .txt .1

# If this changes, the corresponding clockmaker declaration and asciidov macro
# must as well.
HOSTDIR = esr@login.ibiblio.org:/public/html/catb/esr/faqs/stratum-1-microserver-howto

GOODIMAGE = 2016-03-18-raspbian-jessie-lite.zip

all: index.html

SNIPPETS = clockmaker ntp.conf
index.html: index.txt $(SNIPPETS)
	asciidoc index.txt

MANIFEST = index.html $(SNIPPETS)
manifest:
	@echo $(MANIFEST)

LANDING = $(HOSTDIR)
upload: index.html
	scp -q $(SNIPPETS) $(LANDING) $(GOODIMAGE)
	scp -q index.html $(LANDING)/index.html

VERSION=$(shell sed <index.txt -n '/^version /s///p')
version:
	@echo $(VERSION)

tag:
	git tag $(VERSION) && git push && git push --tags

clean: 
	rm -f index.html
