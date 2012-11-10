DIAFILES=$(wildcard imageinput/*.dia)
DOTFILES=$(wildcard imageinput/*.dot)
TEXFILES=$(wildcard content/*.tex) document.tex

%.png: %.dot
	@echo dot export $<
	@dot $< -T png -o $@

%.png: %.dia
	@echo dia export $<
	@dia $< -e $@ -t png

document.pdf: images code $(TEXFILES)
	TEXINPUTS=.:includes: pdflatex -shell-escape document && \
	TEXINPUTS=.:includes: bibtex document && \
	TEXINPUTS=.:includes: pdflatex -shell-escape document && \
	TEXINPUTS=.:includes: pdflatex -shell-escape document

.PHONY: perm
perm:
	bash tools/permamake.sh $(DIAFILES) $(DOTFILES) $(TEXFILES)

.PHONY: images
images: ${DIAFILES:.dia=.png} ${DOTFILES:.dot=.png}


.PHONY:code
code:
	python tools/minted_code_extractor.py content ../juggler .tex_from_code


clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
cleaner: clean
	rm -f .tex_from_code/*.tex
	rmdir .tex_from_code
	rm -f imageinput/*.png
	rm -f *.pdf *.out
