#!/usr/bin/env python3
import json
import sys

def md_escape(text: str) -> str:
    """Escape pipes for markdown tables"""
    return text.replace("|", "\\|")

def fmt(v):
    return "n/a" if v is None else v

def status_icon(status: str) -> str:
    if status == "PASSED":
        return "PASS"
    if status == "FAILED":
        return "FAIL"
    return f"[WARN:{status}]"

def convert(json_data: dict) -> str:
    out = []

    for run_name, run in json_data.items():
        cfg = run.get("configuration", {})
        results = run.get("result", {})

        # ---- Header ----
        out.append(f"#### Test Run: `{run_name}`\n")

        # ---- Configuration ----
        out.append("##### Configuration\n")
        out.append("| Key | Value |")
        out.append("|-----|-------|")

        for k, v in cfg.items():
            if isinstance(v, str) and "/" in v:
                v = f"`{v}`"
            out.append(f"| {k} | {fmt(v)} |")

        # ---- Results ----
        out.append("\n##### Test Results\n")
        out.append(
            "| Test Case | Status | Duration (s) | "
            "CXL.IO EP | CXL.IO EP Total | "
            "CXL.IO RC | CXL.IO RC Total |"
        )
        out.append(
            "|-----------|--------|--------------|"
            "-------------|-----------------|"
            "-------------|-----------------|"
        )

        for test_name, data in results.items():
            raw_status = data.get("status", "UNKNOWN")
            status = status_icon(raw_status)
            duration = round(data.get("duration", 0), 2)

            trackers = data.get("trackers", {})

            ep = trackers.get("CXL.IO_for_EP", {})
            rc = trackers.get("CXL.IO_for_RC", {})

            ep_delta = fmt(ep.get("delta"))
            ep_total = fmt(ep.get("total"))
            rc_delta = fmt(rc.get("delta"))
            rc_total = fmt(rc.get("total"))

            out.append(
                f"| `{md_escape(test_name)}` | {status} | {duration} | "
                f"{ep_delta} | {ep_total} | {rc_delta} | {rc_total} |"
            )

    return "\n".join(out)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: json2md.py testresults.json", file=sys.stderr)
        sys.exit(1)

    with open(sys.argv[1]) as f:
        data = json.load(f)

    print(convert(data))

