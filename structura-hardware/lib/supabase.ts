import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Server-side client for sensitive operations
export async function getServerSupabase() {
  const { createClient: createServerClient } = await import('@supabase/supabase-js')
  return createServerClient(supabaseUrl, supabaseAnonKey)
}
