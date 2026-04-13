#!/bin/bash
set -e

for f in *.mmd; do
    echo "Compiling $f..."
    podman run --userns keep-id --user "${UID}" --rm \
        -v "$(pwd):/data:z" \
        ghcr.io/mermaid-js/mermaid-cli/mermaid-cli:latest \
        -i "$f" -o "${f%.mmd}.png"
done

echo "Done."
