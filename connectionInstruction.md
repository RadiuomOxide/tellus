# Claude Code — Docker Remote Session

## Full permissions (no prompts)

```bash
claude --dangerously-skip-permissions
```

This bypasses all permission prompts — Claude can read, write, and run commands without confirmation.

## Persistent remote session

Use `tmux` so the session survives after you disconnect:

```bash
# Inside the container, start a named tmux session
tmux new-session -s claude

# Then launch Claude inside it
claude --dangerously-skip-permissions
```

**To detach** (leave it running in background): `Ctrl+B`, then `D`

**To reattach later:**
```bash
docker exec -it <container_name> tmux attach -t claude
```

## Accessing the container remotely

If you're SSHing into the host machine and the container is running, you can jump straight in:

```bash
docker exec -it <container_name> tmux attach -t claude
```

Or open a shell first:
```bash
docker exec -it <container_name> bash
tmux attach -t claude
```

## Quick one-liner to start fresh

```bash
docker exec -it <container_name> tmux new-session -d -s claude \; send-keys "claude --dangerously-skip-permissions" Enter
```

This starts the session detached, so you can attach to it anytime with:
```bash
docker exec -it <container_name> tmux attach -t claude
```

> **Note:** `--dangerously-skip-permissions` gives Claude full file system and shell access with no guardrails — fine for a controlled container, not a shared environment.
