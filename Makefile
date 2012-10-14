DIAFILES=$(wildcard imageinput/*.dia)

%.png: %.dia
	@echo dia export $<
	@dia $< -e $@ -t png



document.pdf: images content/*.tex
	pdflatex -shell-escape document && \
	bibtex document && \
	pdflatex -shell-escape document && \
	pdflatex -shell-escape document

.PHONY: images
images: ${DIAFILES:.dia=.png}

clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
	rm -f imageinput/*.png
cleaner: clean
	rm -f *.pdf *.out
