#!/usr/bin/awk -f

BEGIN {
    if (ARGC > 1) {
        DEFAULT = ARGV[1]
    } else {
        DEFAULT = 0
    }
}

FNR == NR {
    key = $1
    value = $2
    record[key] = value
    next
}
{
    key = $1
    line = $0
    if (key in record) {
        print line, record[key]
    } else {
        print line, DEFAULT
    }
}

END {

}
