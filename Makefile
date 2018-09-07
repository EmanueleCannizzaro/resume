PYTHON=python
LATEX=xelatex
OUTDIR=output
ifdef PDF_LINK
LINK=--pdf_link $(PDF_LINK)
else
LINK=
endif

all: html md pdf

outdir:
	mkdir -p $(OUTDIR)

install_tex: outdir
	cp Awesome-CV/awesome-cv.cls $(OUTDIR)
	cp Awesome-CV/fontawesome.sty $(OUTDIR)
	cp -r Awesome-CV/fonts $(OUTDIR)

html: outdir
	$(PYTHON) build_cv.py --html_out_file $(OUTDIR)/cv.html $(LINK)

md: outdir
	$(PYTHON) build_cv.py --md_out_file $(OUTDIR)/cv.md $(LINK)

tex: outdir
	$(PYTHON) build_cv.py --tex_out_file $(OUTDIR)/cv.tex

pdf: install_tex tex
	cd $(OUTDIR); $(LATEX) cv.tex; cd ..

clean:
	rm -r $(OUTDIR)