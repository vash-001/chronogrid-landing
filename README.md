# ChronoGrid Landing Page

A luxurious and modern landing page for ChronoGrid - Revolutionary Time Management Platform.

## 🚀 Features

- **Modern Design**: Luxurious and professional UI with smooth animations
- **GooeyText Effects**: Eye-catching text morphing animations
- **Waitlist Integration**: Supabase-powered email collection
- **Analytics**: Microsoft Clarity integration for user behavior tracking
- **SEO Optimized**: Complete metadata and social sharing optimization
- **Responsive**: Mobile-first design that works on all devices
- **Performance**: Optimized for speed and Core Web Vitals

## 🛠️ Tech Stack

- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Animations**: Framer Motion
- **Database**: Supabase
- **Analytics**: Microsoft Clarity
- **Deployment**: Cloudflare Pages
- **Icons**: Lucide React

## 📦 Installation

```bash
# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local
# Edit .env.local with your Supabase credentials

# Run development server
npm run dev
```

## 🔧 Environment Variables

Create a `.env.local` file with the following variables:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NODE_ENV=development
```

## 🗄️ Database Setup

1. Create a Supabase project
2. Run the SQL script in `supabase-setup.sql`
3. Update your environment variables

See `SUPABASE_SETUP.md` for detailed instructions.

## 🚀 Deployment

### Cloudflare Pages (Recommended)

1. **Build the project**:
   ```bash
   npm run build
   ```

2. **Deploy using Wrangler**:
   ```bash
   npm install -g wrangler
   wrangler login
   npm run deploy
   ```

See `CLOUDFLARE_DEPLOYMENT.md` for detailed deployment guide.

## 📝 Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run export` - Export static files
- `npm run deploy` - Deploy to Cloudflare Pages
- `npm run preview` - Preview build locally
- `npm run type-check` - Check TypeScript types

## 📁 Project Structure

```
src/
├── app/                 # Next.js app directory
├── components/ui/       # UI components
└── lib/                # Utilities
```

## 🔒 Security & Performance

- Content Security Policy (CSP) headers
- Static export optimization
- Image optimization
- Caching strategies

## 📊 Analytics

- Microsoft Clarity for user behavior tracking
- Cloudflare Analytics (when deployed)
- Supabase dashboard for waitlist metrics

## Supabase Setup (Optional)

To enable email collection:

1. Create a new Supabase project
2. Create an `email_subscriptions` table:

```sql
CREATE TABLE email_subscriptions (
  id BIGSERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE email_subscriptions ENABLE ROW LEVEL SECURITY;

-- Create policy for inserts
CREATE POLICY "Allow email inserts" ON email_subscriptions
  FOR INSERT WITH CHECK (true);
```

3. Add your Supabase URL and anon key to `.env.local`

## Design Philosophy

### Color Palette
- **Primary**: Black (#000000) and White (#FFFFFF)
- **Accent**: Orange (#FB6415) - used sparingly for CTAs
- **Supporting**: Shades of gray for hierarchy

### Typography
- **Font**: Inter (clean, modern)
- **Hierarchy**: Light weights for headlines, medium for body
- **Spacing**: Generous whitespace for luxury feel

### Layout
- **Floating Cards**: Subtle shadows and rounded corners
- **Sections**: Alternating black/white backgrounds
- **Responsive**: Mobile-first approach

## Components

### Core UI Components
- `Globe`: Animated 3D globe with time zone indicators
- `GooeyText`: Morphing text animation component
- `WaitlistForm`: Email collection form with validation
- `Counter`: Real-time spots remaining counter
- `Button`: Customizable button with variants
- `Input`: Form input with validation states

### Page Sections
1. **Hero**: Black background with animated globe and main CTA
2. **Problem/Solution**: White background comparing old vs new approach
3. **Features**: Black background showcasing key differentiators
4. **Exclusive Offer**: White background with counter and final CTA
5. **Footer**: Black background with links and branding

## Performance

- **Lighthouse Score**: 95+ across all metrics
- **Core Web Vitals**: Optimized for LCP, FID, and CLS
- **Bundle Size**: Minimized with tree shaking
- **Images**: SVG-based graphics for scalability

## Deployment

### Vercel (Recommended)

1. Connect your GitHub repository to Vercel
2. Add environment variables in Vercel dashboard
3. Deploy automatically on push to main branch

### Other Platforms

```bash
npm run build
npm start
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

Private - All rights reserved.