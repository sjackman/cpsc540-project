all:

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

%-salary.tab: %.csv
	csvprintf '%1$s\t%11$s\n' <$< >$@

%.out: %.R
	R --no-restore --no-save <$< >$@

%.vw: %.csv
	python kaggle-advertised-salaries/2vw.py $< $@

data/sub.txt: data/Valid.csv data/Train.csv
	python kaggle-advertised-salaries/add_dummy_salaries.py data/Valid.csv data/Valid_with_dummy_salaries.csv
	cat data/Train.csv data/Valid_with_dummy_salaries.csv >data/train_plus_valid.csv
	python kaggle-advertised-salaries/2vw.py data/train_plus_valid.csv data/train_plus_valid.vw
	python kaggle-advertised-salaries/first.py data/train_plus_valid.vw data/train.vw 244768
	python kaggle-advertised-salaries/first.py data/train_plus_valid.vw data/test.vw 999999999 244768
	vw -d data/train.vw -c -f model.vw --passes 20
	vw -t -d data/test.vw -c -i model.vw -p data/p.txt
	R --no-restore --no-save <kaggle-advertised-salaries/unlog_predictions.r >unlog_predictions.out
