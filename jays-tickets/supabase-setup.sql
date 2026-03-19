-- Run this in Supabase SQL Editor (supabase.com → your project → SQL Editor)
-- Creates the table for tracking sold games with real-time enabled

CREATE TABLE IF NOT EXISTS jays_sold (
  game_index INTEGER PRIMARY KEY,
  sold_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE jays_sold ENABLE ROW LEVEL SECURITY;

-- Allow anyone to read (your friends see sold status)
CREATE POLICY "Anyone can view sold games"
  ON jays_sold FOR SELECT
  USING (true);

-- Allow anyone to insert/delete (admin code in the app controls access)
CREATE POLICY "Allow insert"
  ON jays_sold FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Allow delete"
  ON jays_sold FOR DELETE
  USING (true);

-- Enable realtime so all browsers update instantly
ALTER PUBLICATION supabase_realtime ADD TABLE jays_sold;
