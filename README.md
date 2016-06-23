# awk
awk scripts collection

## nginx-log-analysis.awk
usage: `cat search.access.log | sed -nr 's/^.*\[(.*):..:.. \+.*HTTP\/1\.." ([0-9]+) ([0-9]+) .*"(.*)"$/\1 \2 \3 \4/p' | awk '{print $1,$4,$2,$3}' | ~/nginx-log-analysis.awk`
