DIAFILES=$(wildcard imageinput/*.dia)
DOTFILES=$(wildcard imageinput/*.dot)


%.png: %.dot
	@echo dot export $<
	@dot $< -T png -o $@

%.png: %.dia
	@echo dia export $<
	@dia $< -e $@ -t png



document.pdf: images content/*.tex
	pdflatex -shell-escape document && \
	bibtex document && \
	pdflatex -shell-escape document && \
	pdflatex -shell-escape document

.PHONY: images
images: ${DIAFILES:.dia=.png} ${DOTFILES:.dot=.png}

clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
cleaner: clean
	rm -f imageinput/*.png
	rm -f *.pdf *.out
