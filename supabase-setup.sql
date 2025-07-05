-- Create waitlist table for storing email subscriptions
CREATE TABLE IF NOT EXISTS waitlist (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'unsubscribed')),
  source VARCHAR(50) DEFAULT 'website',
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index on email for faster lookups
CREATE INDEX IF NOT EXISTS idx_waitlist_email ON waitlist(email);

-- Create index on created_at for sorting
CREATE INDEX IF NOT EXISTS idx_waitlist_created_at ON waitlist(created_at);

-- Create index on status for filtering
CREATE INDEX IF NOT EXISTS idx_waitlist_status ON waitlist(status);

-- Enable Row Level Security (RLS)
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Create policy to allow public inserts (for joining waitlist)
CREATE POLICY "Allow public inserts" ON waitlist
  FOR INSERT
  TO public
  WITH CHECK (true);

-- Create policy to allow public reads (for checking if email exists)
CREATE POLICY "Allow public reads" ON waitlist
  FOR SELECT
  TO public
  USING (true);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_waitlist_updated_at
  BEFORE UPDATE ON waitlist
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Create function to get waitlist statistics
CREATE OR REPLACE FUNCTION get_waitlist_stats()
RETURNS JSON AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_build_object(
    'total_count', COUNT(*),
    'pending_count', COUNT(*) FILTER (WHERE status = 'pending'),
    'confirmed_count', COUNT(*) FILTER (WHERE status = 'confirmed'),
    'unsubscribed_count', COUNT(*) FILTER (WHERE status = 'unsubscribed'),
    'today_count', COUNT(*) FILTER (WHERE DATE(created_at) = CURRENT_DATE),
    'this_week_count', COUNT(*) FILTER (WHERE created_at >= DATE_TRUNC('week', NOW())),
    'this_month_count', COUNT(*) FILTER (WHERE created_at >= DATE_TRUNC('month', NOW()))
  ) INTO result
  FROM waitlist;
  
  RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission on the function
GRANT EXECUTE ON FUNCTION get_waitlist_stats() TO public;

-- Insert some sample data (optional - remove in production)
-- INSERT INTO waitlist (email, source) VALUES 
--   ('test@example.com', 'website'),
--   ('demo@example.com', 'website');

-- View to check table structure
-- SELECT column_name, data_type, is_nullable, column_default 
-- FROM information_schema.columns 
-- WHERE table_name = 'waitlist' 
-- ORDER BY ordinal_position;