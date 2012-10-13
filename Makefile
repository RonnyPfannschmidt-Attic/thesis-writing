DIAFILES=$(wildcard imageinput/*.dia)

%.png: %.dia
	@echo dia export $<
	@dia $< -e $@ -t png

document: images
	pdflatex -shell-escape document && \
	bibtex document && \
	pdflatex -shell-escape document && \
	pdflatex -shell-escape document

.PHONY: images
images: ${DIAFILES:.dia=.png}
	echo ${DIAFILES}



clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
cleaner: clean
	rm -f *.pdf *.out
