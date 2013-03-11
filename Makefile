# Regress using Vowpal Wabbit

# Parameters
vwopt=-b24
l1=1.7e-7
l2=0
passes=50

all: data/error.tab data/valid-yhat.tab

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

%.Rout: %.R
	R --no-restore --no-save <$< >$@

%/all-y.tab: %/Train.csv
	csvprintf '%1$$s\t%11$$s\n' <$< >$@

%/train-y.tab: %/all-y.tab
	head -n200001 $< >$@

%/test-y.tab: %/all-y.tab
	sed -n '1p;200002,$$p' $< >$@

%.vw: %.csv
	python kaggle-advertised-salaries/2vw.py $< $@

data/train_plus_valid.csv: data/Train.csv data/Valid.csv
	python kaggle-advertised-salaries/add_dummy_salaries.py data/Valid.csv data/Valid_with_dummy_salaries.csv
	cat data/Train.csv data/Valid_with_dummy_salaries.csv >$@

data/train.vw: data/train_plus_valid.vw
	python kaggle-advertised-salaries/first.py \
		data/train_plus_valid.vw $@ 200000

data/test.vw: data/train_plus_valid.vw
	python kaggle-advertised-salaries/first.py \
		data/train_plus_valid.vw $@ 44768 200000

data/valid.vw: data/train_plus_valid.vw
	python kaggle-advertised-salaries/first.py \
		data/train_plus_valid.vw $@ 999999 244768

%/model.vw: %/train.vw
	vw -d $< -c -f $@ --readable_model $@.txt $(vwopt) \
		--passes $(passes) --l1 $(l1) --l2 $(l2)

%-yhat-log.tab: %.vw data/model.vw
	vw -t -d $< -c -i data/model.vw -p $@ $(vwopt)

%.tab: %-log.tab
	./exp.R <$< >$@

%/error.tab: %/train-y.tab %/train-yhat.tab %/test-y.tab %/test-yhat.tab
	./calculate-error.R >$@

%/audit.txt: %/train.vw
	vw -a -t -d $< -p /dev/null $(vwopt) >$@

%/audit.tab: %/audit.txt
	fmt -1 $< |gawk -F: '/:/ {x[$$1] = $$2} END {for (i in x) print x[i] "\t" i}' |sort -n >$@

%/model.vw.tab: %/model.vw.txt
	gsed -n '13,$$s/:/\t/p' <$< >$@

%/model.tab: %/audit.tab %/model.vw.tab
	gawk 'ARGIND==1 {x[$$1] = $$2} ARGIND>1 {print $$1 "\t" x[$$1] "\t" exp($$2)}' $^ |sort -rnk3 >$@

data/unlog_predictions.txt: data/Valid.csv data/Train.csv
	python kaggle-advertised-salaries/add_dummy_salaries.py data/Valid.csv data/Valid_with_dummy_salaries.csv
	cat data/Train.csv data/Valid_with_dummy_salaries.csv >data/train_plus_valid.csv
	python kaggle-advertised-salaries/2vw.py data/train_plus_valid.csv data/train_plus_valid.vw
	python kaggle-advertised-salaries/first.py data/train_plus_valid.vw data/train.vw 244768
	python kaggle-advertised-salaries/first.py data/train_plus_valid.vw data/valid.vw 999999999 244768
	vw -d data/train.vw -c -f model.vw --passes 20
	vw -t -d data/valid.vw -c -i model.vw -p data/p.txt
	R --no-restore --no-save <kaggle-advertised-salaries/unlog_predictions.r >$@
