NAME=main
TARGET=$(NAME).pdf
SOURCE=$(NAME).tex
AUX=$(NAME).aux

JUNK=.aux .bbl .blg .log .brf .out .snm .nav .toc

all: $(TARGET)

$(TARGET): $(SOURCE) .FORCE
	@pdflatex $(SOURCE)
	@bibtex $(NAME)
	@pdflatex $(SOURCE)
	@pdflatex $(SOURCE)

bib: $(SOURCE) $(BIBS) .FORCE
	@pdflatex $(SOURCE)
	@rm -f $(NAME).bib
	@bibtool -x $(AUX) -i $(PTOOLSDIR)/mainDB.bib -o $(NAME).bib
	@bibtex $(NAME)
	@pdflatex $(SOURCE)
	@pdflatex $(SOURCE)

clean:
	@for ext in $(JUNK); do\
	    rm -f $(NAME)$$ext;\
	done

quick:  $(SOURCE) $(FIGS) $(BIBS) .FORCE
	@pdflatex $(SOURCE)

.FORCE:
