DIAFILES=$(wildcard imageinput/*.dia)
DOTFILES=$(wildcard imageinput/*.dot)


%.png: %.dot
	@echo dot export $<
	@dot $< -T png -o $@

%.png: %.dia
	@echo dia export $<
	@dia $< -e $@ -t png



document.pdf: images code content/*.tex
	pdflatex -shell-escape document && \
	bibtex document && \
	pdflatex -shell-escape document && \
	pdflatex -shell-escape document

.PHONY: images
images: ${DIAFILES:.dia=.png} ${DOTFILES:.dot=.png}


.PHONY:code
code:
	python minted_code_extractor.py content ../juggler .tex_from_code


clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
cleaner: clean
	rm -f .tex_from_code/*.tex
	rmdir .tex_from_code
	rm -f imageinput/*.png
	rm -f *.pdf *.out
