SHELL := /bin/bash
TEXTS := data/isles.txt data/abyss.txt data/last.txt data/sierra.txt
DAT_FILES := $(patsubst data/%.txt, results/%.dat, $(TEXTS))
FIGURES := $(patsubst results/%.dat, results/figure/%.png, $(DAT_FILES))
REPORT := report/count_report.html

all: $(REPORT)

results/%.dat: data/%.txt
	@echo "Counting words for $<..."
	python scripts/wordcount.py --input_file=$< --output_file=$@

results/figure/%.png: results/%.dat
	@echo "Creating plot for $<..."
	python scripts/plotcount.py --input_file=$< --output_file=$@

$(REPORT): $(FIGURES)
	@echo "Rendering report..."
	quarto render report/count_report.qmd

clean:
	@echo "Cleaning up..."
	rm -f $(DAT_FILES) $(FIGURES) $(REPORT)