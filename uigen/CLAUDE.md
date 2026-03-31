claude# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
npm run setup        # First-time setup: install deps, generate Prisma client, run migrations
npm run dev          # Start dev server with Turbopack
npm run build        # Production build
npm run lint         # ESLint check
npm run test         # Run all Vitest tests
npm run db:reset     # Reset SQLite database (destructive)
```

To run a single test file:

```bash
npx vitest run src/components/chat/MessageList.test.tsx
```

## Environment

Copy `.env` and set:

- `ANTHROPIC_API_KEY` — required for real AI generation; if absent, falls back to a mock provider that returns static code
- JWT secret and database URL are also configured here

## Architecture

UIGen is a full-stack AI-powered React component generator. Users describe a component in chat; Claude generates/edits files in a virtual file system; the result renders live in an iframe.

### Three-Panel Layout (`src/app/main-content.tsx`)

- **Left (35%)**: Chat interface (`src/components/chat/`)
- **Right top tab**: Toggle between live Preview and Code view
- **Right Preview**: `PreviewFrame` — renders the virtual FS output in an iframe via Babel transpilation
- **Right Code**: `FileTree` (30%) + Monaco `CodeEditor` (70%)

### AI Pipeline (`src/app/api/chat/route.ts`)

- Uses Vercel AI SDK with `@ai-sdk/anthropic` (model: `claude-haiku-4-5`, max 10k tokens, 40 steps)
- Streams responses; Claude calls two tools:
  - `str_replace_editor` (`src/lib/tools/str-replace.ts`) — patch file contents
  - `file_manager` (`src/lib/tools/file-manager.ts`) — create/delete/move files and folders
- System prompt lives in `src/lib/prompts/generation.tsx`
- Prompt caching (ephemeral) is applied to the system prompt

### Virtual File System (`src/lib/file-system.ts`)

- Entirely in-memory — no disk writes for generated files
- Serialized to/from JSON for persistence in the database
- Shared via `FileSystemProvider` context (`src/lib/contexts/`)

### Data Persistence (`prisma/schema.prisma`)

- The database schema is defined in `prisma/schema.prisma` — reference it anytime you need to understand the structure of data stored in the database
- SQLite database with two models: `User` and `Project`
- `Project.messages` and `Project.data` are JSON strings (chat history + serialized virtual FS)
- Authenticated users get persistence; anonymous users work in-memory only
- Prisma client is generated to `src/generated/prisma` (not the default location)

### Auth (`src/lib/auth.ts`, `src/hooks/use-auth.ts`)

- JWT-based sessions via `jose`; passwords hashed with `bcrypt`
- Server actions in `src/actions/` handle project CRUD for authenticated users

### Node Compatibility

All dev/build scripts prefix `NODE_OPTIONS='--require ./node-compat.cjs'` — this shim is required for the current dependency set on Node 18+.
