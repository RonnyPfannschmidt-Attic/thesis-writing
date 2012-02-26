document:
	pdflatex -shell-escape document && \
	bibtex document && \
	pdflatex -shell-escape document && \
	pdflatex -shell-escape document
clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
cleaner: clean
	rm -f *.pdf *.out
