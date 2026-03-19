# 2026 Blue Jays Tickets — Vercel + Supabase

## Deploy in 4 Steps (~5 minutes)

### Step 1: Supabase — Create the table
1. Go to your **Supabase dashboard** → pick your existing project (the one you use for SteriIQ)
2. Click **SQL Editor** in the left sidebar
3. Paste the contents of `supabase-setup.sql` and click **Run**
4. You should see "Success. No rows returned" — that's correct

### Step 2: Supabase — Enable Realtime
1. Go to **Database → Replication** in the left sidebar
2. Make sure `jays_sold` table has realtime enabled (the SQL should have done this, but double-check)

### Step 3: Add your Supabase credentials to the HTML
1. In Supabase, go to **Settings → API**
2. Copy your **Project URL** (looks like `https://xyzabc.supabase.co`)
3. Copy your **anon public** key
4. Open `public/index.html` and replace the two placeholders near the top:
   ```
   const SUPABASE_URL = 'https://your-project.supabase.co';
   const SUPABASE_ANON_KEY = 'your-anon-key-here';
   ```

### Step 4: Deploy to Vercel
**Option A — Vercel CLI (fastest):**
```bash
cd jays-tickets
npx vercel --prod
```

**Option B — Vercel Dashboard:**
1. Push this folder to a new GitHub repo: `github.com/ajandai/jays-tickets`
2. Go to vercel.com → New Project → Import the repo
3. Framework: **Other**
4. Output Directory: `public`
5. Click Deploy

That's it! You'll get a URL like `jays-tickets.vercel.app`

---

## How It Works

- **Your friends** visit the link, select games, and hit "Send Request" → pre-filled email to ajayjain80@gmail.com
- **You (admin)** click the small "Admin" button bottom-right → enter code `jays115` → mark games as SOLD
- **Live sync**: When you mark a game SOLD, it saves to Supabase and EVERY visitor sees it update in real-time via websocket
- **No login needed** for anyone

## Files
```
jays-tickets/
├── vercel.json          ← Vercel config
├── supabase-setup.sql   ← Run this in Supabase SQL Editor
├── public/
│   ├── index.html       ← The app (add your Supabase keys here)
│   └── seat-view.png    ← Your seat photo
```

## Custom Domain (Optional)
In Vercel dashboard → your project → Settings → Domains
Add something like `jaystickets.ca` or use the free `.vercel.app` domain.

## Admin Code
Default: `jays115` — change it in index.html if you want (search for `const AK=`)
