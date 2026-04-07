@AGENTS.md

# Bataan Hardware Store — System Instructions

## What This Is

A full hardware store management system for a single store in Bataan Province,
Philippines. Built with Next.js App Router, Supabase, Tailwind CSS, and shadcn/ui.

## Tech Stack

- Framework: Next.js 15 App Router, TypeScript
- UI: Tailwind CSS, shadcn/ui components
- Database + Auth: Supabase (PostgreSQL + Row Level Security)
- Offline: Dexie.js + IndexedDB (PWA)
- Deployment: Vercel

## Project Structure

- app/(auth)/ — login, forgot-password, setup
- app/(internal)/ — owner and staff dashboard, all internal pages
- app/(pos)/ — fullscreen cashier POS interface
- app/(store)/ — public e-commerce storefront
- app/api/ — API routes and webhooks
- components/ — reusable UI components
- lib/ — supabase client, utilities, helpers
- hooks/ — custom React hooks
- store/ — Dexie.js offline database config
- types/ — TypeScript type definitions

## Philippines-Specific Rules

- Currency: PHP (Philippine Peso ₱)
- VAT: 12% — always auto-calculated, never entered manually
- VAT formula: VATable = Total / 1.12, VAT = Total - VATable
- Receipts must follow BIR official receipt format
- Senior/PWD discount: 20% — required by law, ID number must be recorded
- Payments: Cash and COD only for now (GCash/PayMongo added later)
- SMS: Semaphore (added later)
- All dates use Philippine time (Asia/Manila)

## Database Rules

- Use Supabase client from lib/supabase/
- Always use Row Level Security (RLS) policies
- Never hard delete — always soft delete with deleted_at timestamp
- Always include created_at and updated_at on every table
- Use uuid for all primary keys
- Offline-capable tables must also write to Dexie.js local database
- branch_id included on key tables for future multi-branch support

## Pricing Rules

- Every product has: cost_price, retail_price, wholesale_price
- Every sale records unit_price_at_sale — snapshot, never changes
- Price changes go to price_history table — never overwrite current price
- Alert owner when margin drops below 10%

## Inventory Rules

- Stock only reserved after order is CONFIRMED — not at creation
- Every stock movement recorded in stock_movements table with reason
- Low stock alert triggered when quantity reaches low_stock_threshold
- Soft delete products — never hard delete

## Order Rules

- Orders have status: pending, confirmed, processing,
  out_for_delivery, completed, cancelled, failed
- Unconfirmed orders auto-cancel after 24 hours
- Inventory reserved only after confirmation
- Every order records the channel: pos, website, messenger, whatsapp, phone

## User Roles

- owner: full access to everything
- cashier: POS only — sales, receipts, today's orders
- staff: inventory only — stock movements, receiving, purchase orders
- Enforce via Supabase RLS and middleware.ts route protection

## Offline Rules

- POS must work offline using Dexie.js
- Offline transactions saved to offline_queue table on reconnect
- Sync processes oldest transactions first
- Sales are additive — never conflict
- If stock goes negative after sync — alert owner, never block

## UI Rules

- Design: clean, minimal, friendly — reference Linear.app and shadcn dashboard
- Both dark and light mode — user can switch
- Use shadcn/ui components always — never build from scratch
- Tables for data lists, cards for summary metrics
- All amounts shown in ₱ with 2 decimal places
- Toasts for success/error feedback
- Confirm dialogs before any destructive action

## Receipt Format

Every receipt must include:

- Store name and complete address
- TIN and BIR Accreditation number
- Official receipt series number
- Date and time
- Itemized list: name, qty, unit price, total
- VAT breakdown: VATable sales, VAT amount, total
- Payment method and change given
- Cashier name

## Code Style

- TypeScript strict mode always
- Use server components by default, client components only when needed
- Use Next.js server actions for form submissions
- shadcn/ui components for all UI elements
- Zod for all form validation
- Always handle loading, empty, and error states
- Mobile-responsive — works on tablet for POS
- No inline styles — Tailwind classes only

## What Is Built So Far

- Nothing yet — starting from scratch

## Build Order

1. Database schema (Supabase migrations)
2. Auth (login, roles, middleware)
3. Inventory module
4. POS module
5. Reports and dashboard
6. E-commerce storefront
7. Advanced features (credit, returns, delivery, bots)

## Design System

- Reference DESIGN.md for all visual decisions
- Font: Inter Variable with font-feature-settings "cv01", "ss03" on ALL text
- Default weight: 510 for UI elements, 400 for body, 590 for emphasis
- Never use weight 700 — maximum is 590
- Dark mode backgrounds: #08090a (page), #0f1011 (panels), #191a1b (cards)
- Light mode background: #f7f8f8 (page), #ffffff (cards)
- Primary text dark: #f7f8f8 — never pure white #ffffff
- Primary text light: #1a1a1a
- Brand accent: #5e6ad2 (bg) / #7170ff (interactive) — used sparingly
- Borders: rgba(255,255,255,0.08) dark mode, #e6e6e6 light mode
- Border radius: 6px buttons, 8px cards, 12px modals
- Never use solid colored button backgrounds — rgba transparency only
- Monospace: Berkeley Mono for receipt text, code, technical labels
- See DESIGN.md Section 9 for exact component prompt patterns
