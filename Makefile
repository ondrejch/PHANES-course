MODULES := 01 02 03 04 05 06 07 08
.PHONY: slides test check clean

slides:
	@set -e; for m in $(MODULES); do (cd mod/$$m && pdflatex -interaction=nonstopmode -halt-on-error lecture$$m.tex >/dev/null && pdflatex -interaction=nonstopmode -halt-on-error lecture$$m.tex >/dev/null); done

test:
	python3 -m unittest mod/04/openmc-example/test_spec.py
	python3 shared/heat_balance.py --power-W 100000 --mass-flow-kg-s 2 --cp-J-kg-K 1000 --inlet-K 300 >/dev/null
	python3 -m py_compile shared/*.py mod/04/openmc-example/*.py

check: slides
	@echo "=== Checking Overfull boxes ==="
	@failed=0; for m in $(MODULES); do \
		count=$$(grep -c 'Overfull' mod/$$m/lecture$$m.log || true); \
		if [ "$$count" -ne 0 ]; then \
			echo "Module $$m has $$count overfull box(es)"; \
			failed=1; \
		fi; \
	done; \
	if [ "$$failed" -eq 0 ]; then echo "All decks: 0 Overfull boxes."; else exit 1; fi

clean:
	rm -f mod/*/*.aux mod/*/*.log mod/*/*.nav mod/*/*.out mod/*/*.snm mod/*/*.toc mod/*/*.vrb

