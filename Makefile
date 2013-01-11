DIAFILES=$(wildcard imageinput/*.dia)
DOTFILES=$(wildcard imageinput/*.dot)
TEXFILES=$(wildcard content/*.tex) document.tex
BUILDPDF=pdflatex -shell-escape document


%.png: %.dot
	@echo dot export $<
	@dot $< -T png -o $@

%.png: %.dia
	@echo dia export $<
	@dia $< -e $@ -t png

.PHONY: once
once: images code
	$(BUILDPDF)

document.pdf: images code $(TEXFILES)
	TEXINPUTS=.:includes: $(BUILDPDF) && \
	TEXINPUTS=.:includes: bibtex document && \
	TEXINPUTS=.:includes: $(BUILDPDF) && \
	TEXINPUTS=.:includes: $(BUILDPDF)

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
