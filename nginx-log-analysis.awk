#!/usr/bin/awk -f
# by zhenglingyun(konghuarukhr@163.com), 2016-06-23

# example: cat access.log | sed -nr 's/^.*\[(.*):..:.. \+.*HTTP\/1\.." ([0-9]+) ([0-9]+) .*"(.*)"$/\1 \2 \3 \4/p' | awk '{print $1,$4,$2,$3}' | ./this-program.awk
# example: cat access.log | sed -nr 's/^([0-9.]+) .*\[(.*):..:.. \+.*HTTP\/1\.." ([0-9]+) ([0-9]+) .*"(.*)"$/\1 \2 \3 \4 \5/p' | awk '{print $2,$5,$3,$4,$1}' | ./this-program.awk
# this awk program needs input format:
# when                 cost  code byte  other1  other2...
# 23/Jun/2016:00:01:03 0.040 200  15322 1.1.1.1 XXX
# 'when' precision is up to you, can be second, minute, or hour

function reverse(array, size) {
    for (i = 1; i <= int(size/2); i++) {
        tmp = array[i]
        array[i] = array[size-i+1]
        array[size-i+1] = tmp
    }
}

BEGIN {
    line = 1
}

{
    when = $1
    cost = $2
    code = $3
    byte = $4
    for (i = 5; i <= NF; i++) {
        others[i,$i]++
    }

    codes[code]++
    bytes[byte]++
    if (code != 200 || byte == 0) {
        # print $0
        next
    }
    costs[line] = cost
    costs_sum += cost
    line++

    seg_costs[when] += cost
    seg_cnt[when]++
}

END {
    printf "--------------------------\n"
    num = asorti(seg_costs, sorted_seg)
    for (i = 1; i <= num; i++) {
        seg = sorted_seg[i]
        printf "segment: %s, count: %d, avg_costs: %f\n", seg, seg_cnt[seg], seg_costs[seg]/seg_cnt[seg]
    }
    printf "--------------------------\n"
    printf "cnt: %d\n", line-1
    printf "sum: %f\n", costs_sum
    printf "avg: %f\n", costs_sum/(line-1)
    printf "--------------------------\n"
    asort(costs)
    printf "fst: %s\n", costs[1]
    printf "10%: %s\n", costs[int(line*0.1)]
    printf "20%: %s\n", costs[int(line*0.2)]
    printf "30%: %s\n", costs[int(line*0.3)]
    printf "40%: %s\n", costs[int(line*0.4)]
    printf "50%: %s\n", costs[int(line*0.5)]
    printf "60%: %s\n", costs[int(line*0.6)]
    printf "70%: %s\n", costs[int(line*0.7)]
    printf "80%: %s\n", costs[int(line*0.8)]
    printf "90%: %s\n", costs[int(line*0.9)]
    printf "lst: %s\n", costs[line-1]
    printf "--------------------------\n"
    num = asorti(codes, sorted_codes)
    for (i = 1; i <= num; i++) {
        code = sorted_codes[i]
        printf "code: %s, count: %d\n", code, codes[code]
    }
    printf "--------------------------\n"
    num = asorti(others, sorted_others)
    if (num > 0) {
        for (i = 1; i <= num; i++) {
            key = sorted_others[i]
            split(key, arr, SUBSEP)
            printf "key: %s, count: %d\n", arr[2], others[key]
        }
        printf "--------------------------\n"
    }
}
