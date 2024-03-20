import json
import os

from collections import defaultdict


if __name__ == "__main__":
    code_params_count = defaultdict(int)
    non_trivial_count = 0

    for dirpath, _, filenames in os.walk("results"):
        for filename in filenames:
            if not filename.endswith(".json"):
                continue

            with open(os.path.join(dirpath, filename), "r") as file:
                ev = json.load(file)

            for _, res in ev.items():
                for _, plugin_results in res["plugins"].items():
                    for plugin_res in plugin_results:
                        if "additional_metrics_code_params" in plugin_res["additional_metrics"]:
                            for t_code_params_count in plugin_res["additional_metrics"]["additional_metrics_code_params"]["count"]:
                                k = t_code_params_count["k"]
                                n = t_code_params_count["n"]
                                cnt = t_code_params_count["cnt"]

                                code_params_count[(k, n)] += cnt
                                if k != 1:
                                    non_trivial_count += cnt

    for (k, n), cnt in sorted(code_params_count.items()):
        if k == 1:
            print(f"(k={k}, n={n}, r={n-k}):".ljust(30, ' '), f"cnt={cnt}")

    print()

    for (k, n), cnt in sorted(code_params_count.items()):
        if k != 1:
            print(f"(k={k}, n={n}, r={n-k}):".ljust(30, ' '), f"cnt={cnt}".ljust(12, ' '),  f"({int(cnt/non_trivial_count*100000)/1000} %)")
