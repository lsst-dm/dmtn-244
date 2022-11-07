DOCNAME = P52
-include makedefs

tex = $(filter-out $(wildcard *acronyms.tex) , $(wildcard *.tex))

GITVERSION := $(shell git log -1 --date=short --pretty=%h)
GITDATE := $(shell git log -1 --date=short --pretty=%ad)
GITSTATUS := $(shell git status --porcelain)
ifneq "$(GITSTATUS)" ""
	GITDIRTY = -dirty
endif

export TEXMFHOME ?= lsst-texmf/texmf
FILESPDF  = $(P).pdf copyrightForm_$(P)_$(A).pdf
FILESTEX  = $(P).tex $(P).bib $(FIGS) makedefs
FILESASP  = asp2014.bst asp2014.sty
FILES4AR  = $(FILESTEX) $(FILESPDF)
TAR_FILE  = $(P).tar.gz


#asp tex is a bit odd so latexml fails ..
$(DOCNAME).pdf: $(tex) meta.tex local.bib authors.tex acronyms.tex
	latex $(DOCNAME)
	bibtex $(DOCNAME)
	latex $(DOCNAME)
	latex $(DOCNAME)
	dvipdfm $(DOCNAME)
	dvipdf $(DOCNAME)


# Acronym tool allows for selection of acronyms based on tags - you may want more than DM
acronyms.tex: $(tex) myacronyms.txt
	$(TEXMFHOME)/../bin/generateAcronyms.py -t "DM" $(tex)

authors.tex:  authors.yaml
	python3 $(TEXMFHOME)/../bin/db2authors.py --mode adass > authors.tex

.PHONY: clean
clean:
	latexmk -c
	rm -f $(DOCNAME).bbl
	rm -f $(DOCNAME).pdf
	rm -f $(DOCNAME).dvi
	rm -f meta.tex
	rm -f authors.tex
	rm -f acronyms.tex
	rm -f *.pyc

.FORCE:

meta.tex: Makefile .FORCE
	rm -f $@
	touch $@
	echo '% GENERATED FILE -- edit this in the Makefile' >>$@
	/bin/echo '\newcommand{\lsstDocType}{$(DOCTYPE)}' >>$@
	/bin/echo '\newcommand{\lsstDocNum}{$(DOCNUMBER)}' >>$@
	/bin/echo '\newcommand{\vcsRevision}{$(GITVERSION)$(GITDIRTY)}' >>$@
	/bin/echo '\newcommand{\vcsDate}{$(GITDATE)}' >>$@

check:
	./PaperCheck.py $(P) $(A)

tar:    $(FILES4AR)
	tar zcf $(TAR_FILE) $(FILES4AR) newKeywords.txt
