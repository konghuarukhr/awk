# awk
awk scripts collection

## nginx-log-analysis.awk
* usage: `cat access.log | sed -nr 's/^.*\[(.*):..:.. \+.*HTTP\/1\.." ([0-9]+) ([0-9]+) .*"(.*)"$/\1 \2 \3 \4/p' | awk '{print $1,$4,$2,$3}' | ~/nginx-log-analysis.awk`
* usage: `cat access.log | sed -nr 's/^([0-9.]+) .*\[(.*):..:.. \+.*HTTP\/1\.." ([0-9]+) ([0-9]+) .*"(.*)"$/\1 \2 \3 \4 \5/p' | awk '{print $2,$5,$3,$4,$1}' | ~/nginx-log-analysis.awk`
example:
[zhenglingyun@bjzw-datacenter-hadoop-60 logs]$ time grep '24/Jun/2016.*product?' search.access.log | sed -nr 's/^([0-9.]+) .*\[(.*):..:.. \+.*HTTP\/1\.." ([0-9]+) ([0-9]+) .*"(.*)"$/\1 \2 \3 \4 \5/p' | awk '{print $2,$5,$3,$4,$1}' | ~/nginx-log-analysis.awk
--------------------------
segment: 24/Jun/2016:00, count: 12609, avg_costs: 0.090058
segment: 24/Jun/2016:01, count: 7270, avg_costs: 0.104270
segment: 24/Jun/2016:02, count: 4836, avg_costs: 0.103911
segment: 24/Jun/2016:03, count: 3084, avg_costs: 0.091970
segment: 24/Jun/2016:04, count: 2472, avg_costs: 0.089771
segment: 24/Jun/2016:05, count: 3046, avg_costs: 0.093207
segment: 24/Jun/2016:06, count: 5274, avg_costs: 0.093065
segment: 24/Jun/2016:07, count: 7732, avg_costs: 0.093421
segment: 24/Jun/2016:08, count: 12963, avg_costs: 0.085547
segment: 24/Jun/2016:09, count: 16759, avg_costs: 0.079971
segment: 24/Jun/2016:10, count: 27477, avg_costs: 0.072775
segment: 24/Jun/2016:11, count: 5367, avg_costs: 0.073802
--------------------------
cnt: 108889
sum: 9243.618000
avg: 0.084890
--------------------------
fst: 0.002
10%: 0.010
20%: 0.010
30%: 0.016
40%: 0.030
50%: 0.055
60%: 0.092
70%: 0.113
80%: 0.161
90%: 0.215
lst: 1.774
--------------------------
code: 200, count: 108890
code: 500, count: 784
--------------------------
key: 10.10.54.23, count: 56812
key: 10.10.54.38, count: 52851
key: 10.10.54.71, count: 11
--------------------------

real    0m10.964s
user    0m11.577s
sys 0m0.224s
[zhenglingyun@bjzw-datacenter-hadoop-60 logs]$
