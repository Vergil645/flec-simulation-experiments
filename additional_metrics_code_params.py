import json

import pprint

from collections import defaultdict


def collect_metrics(file_serv, file_cli, params, message_deadline=250000):
    encode_window_count = defaultdict(int)

    for line in file_serv:
        if "EVENT::" in line:
            ev = json.loads(line.replace("EVENT::", ""))
            if ev["type"] == "sent_repair_packet":
                window = ev["window"]
                encode_window_count[(window[0], window[1])] += ev["repair_symbols"]

    code_params_count = defaultdict(int)
    all_count = 0

    for window, cnt in encode_window_count.items():
        k = window[1] - window[0] + 1
        r = cnt
        code_params_count[(k, r)] += 1
        all_count += 1

    retval = {
        "count": sorted(
            [{"n": k+r, "k": k, "r": r, "cnt": cnt, "percent": cnt / all_count * 100} for (k, r), cnt in code_params_count.items()],
            key=lambda d: d["cnt"],
            reverse=True,
        )
    }

    pprint.pprint(retval)

    return retval


if __name__ == "__main__":
    import sys
    with open(sys.argv[1]) as file_serv:
        with open(sys.argv[2]) as file_cli:
            collect_metrics(file_serv, file_cli, {}, message_deadline=250000)
