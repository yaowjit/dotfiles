#!/usr/bin/env python3

import os
from pathlib import Path

import tomllib

with open("./tools.toml", "rb") as f:
    data = tomllib.load(f)

os.system("mkdir -p ./bin/aarch64/ ./bin/x86_64/")
curr_arch = "x86_64"

bin_path = data["global"]["bin_path"]
tmp_path = Path("./tmp")

for k, v in data.items():
    if k == "global":
        continue
    if v.get("arch") is None:
        v["arch"] = data["global"]["arch"]
    else:
        if v["arch"].get("aarch64") is None:
            v["arch"]["aarch64"] = data["global"]["arch"]["aarch64"]
        if v["arch"].get("x86_64") is None:
            v["arch"]["x86_64"] = data["global"]["arch"]["x86_64"]
    fmt_opts = v.copy()
    fmt_opts["bin_path"] = bin_path

    for arch_key, arch in v["arch"].items():
        if isinstance(v["fname"], str):
            fname_unformated = v["fname"]
        elif isinstance(v["fname"], dict):
            fname_unformated = v["fname"][arch_key]

        fmt_opts["arch_key"] = arch_key
        fmt_opts["arch"] = arch
        fmt_opts["fname"] = fname_unformated.format(**fmt_opts)
        url = data["global"]["url"].format(**fmt_opts)
        dl_cmd = f"wget -c {url} -P {tmp_path}"
        print(dl_cmd)
        os.system(dl_cmd)
        target_path = f"tmp/{fmt_opts['fname']}"
        post_cmd = fmt_opts["cmd"].format(**fmt_opts)
        print(post_cmd)
        os.system(f"cd {tmp_path} && {post_cmd} && cd ..")

os.system(f"chmod +x -R {bin_path}")
