if status is-interactive
    # Commands to run in interactive sessions can go here
end

export XDG_RUNTIME_DIR=/run/user/1000
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

fish_add_path /home/linus/.dotnet/tools

set RANGER_LOAD_DEFAULT_RC false

set -g fish_greeting ""

alias fucking "sudo"
alias ff "fastfetch"
alias ls "lsd"
alias si "kitty +kitten icat"
#alias weather "curl v2.wttr.in/jönköping"
alias weather "curl wttr.in/Jönköping"
alias yoink "git pull"

function yeet
    set -l model qwen3.5:9b
    set -l endpoint http://localhost:11434/api/generate
    set -l msg

    if set -q YEET_MODEL
        set model $YEET_MODEL
    end

    if not git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null
        echo "yeet: not inside a git repo" >&2
        return 1
    end

    if not type -q python3
        echo "yeet: python3 is not installed or not in PATH" >&2
        return 1
    end

    git add -A
    or return 1

    if test (count $argv) -gt 0
        set msg (string join ' ' -- $argv)
    else
        set -l names (git diff --cached --name-only | string collect)

        if test -z "$names"
            echo "yeet: nothing to commit"
            return 0
        end

        set -l stat (git diff --cached --stat --compact-summary | string collect)
        set -l patch (git diff --cached --no-ext-diff --unified=0 | string collect)

        set msg (python3 -c '
import json
import re
import sys
import urllib.error
import urllib.request

endpoint, model, names, stat, patch = sys.argv[1:6]

prompt = f"""Changed files:
{names}

Diff stat:
{stat}

Patch excerpt:
{patch}

Write exactly one git commit subject.

Rules:
- Return plain text only, as a single line. No newlines.
- No markdown.
- No code fences.
- No quotes.
- Imperative mood.
- Keep it short but precise.
- Use Conventional Commits style only when it clearly fits.
- Do not use any "assuming" language, or hypotheticals. These is a well developed code repository containing this code.
"""
payload = {
    "model": model,
    "prompt": prompt,
    "stream": False,
    "keep_alive": 0,
    "think": False,
    "options": {
        "num_ctx": 65536
    },
}

req = urllib.request.Request(
    endpoint,
    data=json.dumps(payload).encode("utf-8"),
    headers={"Content-Type": "application/json"},
    method="POST",
)

try:
    with urllib.request.urlopen(req) as resp:
        outer = json.loads(resp.read().decode("utf-8"))
except urllib.error.HTTPError as e:
    body = e.read().decode("utf-8", errors="replace")
    print(f"yeet: ollama API error {e.code}: {body}", file=sys.stderr)
    sys.exit(2)
except Exception as e:
    print(f"yeet: ollama request failed: {e}", file=sys.stderr)
    sys.exit(3)

raw = (outer.get("response") or "").strip()

for line in raw.splitlines():
    line = line.strip()
    if not line or line.startswith("```"):
        continue
    if re.match(r"^(commit message|message|output)\s*:?\s*$", line, re.I):
        continue
    line = re.sub(r"^(commit message|message|output)\s*:\s*", "", line, flags=re.I)
    line = re.sub(r"^[`\"]+|[`\"]+$", "", line).strip()
    if line:
        print(line, end="")
        sys.exit(0)

print("yeet: model returned an empty commit message", file=sys.stderr)
sys.exit(4)
' "$endpoint" "$model" "$names" "$stat" "$patch")
        set -l py_status $status

        if test $py_status -ne 0
            return $py_status
        end
    end

    echo "→ $msg"
    printf "Commit with this message? [Y/n] "
    read -l confirm

    if test -n "$confirm"
        if not string match -iqr '^(y|yes)$' -- $confirm
            echo "yeet: aborted"
            return 1
        end
    end

    git commit -m "$msg"
    and git push
end
