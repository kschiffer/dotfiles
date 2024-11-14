
eval "$(/opt/homebrew/bin/brew shellenv)"

# Created by `pipx` on 2024-10-15 07:32:38
export PATH="$PATH:/Users/kevinschiffer/.local/bin"

# Load environment variables from ~/.env if the file exists
if [ -f "$HOME/.env" ]; then
    export $(grep -v '^#' "$HOME/.env" | xargs)
fi

export OPENAI_API_KEY=$GPT_API_KEY
