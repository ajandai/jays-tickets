-- Run this in Supabase SQL Editor
-- If you already ran the old version, this replaces it safely

-- Drop old policies
DROP POLICY IF EXISTS "read" ON jays_sold;
DROP POLICY IF EXISTS "write" ON jays_sold;
DROP POLICY IF EXISTS "del" ON jays_sold;
DROP POLICY IF EXISTS "Anyone can view sold games" ON jays_sold;
DROP POLICY IF EXISTS "Allow insert" ON jays_sold;
DROP POLICY IF EXISTS "Allow delete" ON jays_sold;
DROP POLICY IF EXISTS "public_read" ON jays_sold;

-- Create table
CREATE TABLE IF NOT EXISTS jays_sold (
  game_index INTEGER PRIMARY KEY,
  sold_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS: anyone can READ, nobody can write directly
ALTER TABLE jays_sold ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read" ON jays_sold FOR SELECT USING (true);

-- Admin function: mark sold (password protected)
CREATE OR REPLACE FUNCTION mark_sold(idx INTEGER, pwd TEXT)
RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF pwd != 'jays115admin2026' THEN RETURN false; END IF;
  INSERT INTO jays_sold (game_index) VALUES (idx) ON CONFLICT DO NOTHING;
  RETURN true;
END;
$$;

-- Admin function: mark unsold (password protected)
CREATE OR REPLACE FUNCTION mark_unsold(idx INTEGER, pwd TEXT)
RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF pwd != 'jays115admin2026' THEN RETURN false; END IF;
  DELETE FROM jays_sold WHERE game_index = idx;
  RETURN true;
END;
$$;

-- Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE jays_sold;
