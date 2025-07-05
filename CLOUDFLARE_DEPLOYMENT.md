# نشر ChronoGrid على Cloudflare Pages

## خطوات النشر

### 1. تحضير المشروع
```bash
# تثبيت التبعيات
npm install

# بناء المشروع للإنتاج
npm run build
```

### 2. إعداد Cloudflare Pages

#### الطريقة الأولى: عبر Git Integration
1. ادفع الكود إلى GitHub/GitLab
2. اذهب إلى [Cloudflare Dashboard](https://dash.cloudflare.com)
3. اختر "Pages" من القائمة الجانبية
4. انقر "Create a project"
5. اختر "Connect to Git"
6. اختر المستودع الخاص بك
7. استخدم الإعدادات التالية:
   - **Build command**: `npm run build`
   - **Build output directory**: `out`
   - **Root directory**: `/`

#### الطريقة الثانية: عبر Wrangler CLI
```bash
# تثبيت Wrangler
npm install -g wrangler

# تسجيل الدخول
wrangler login

# نشر المشروع
wrangler pages deploy out --project-name chronogrid-landing
```

### 3. إعداد متغيرات البيئة

في لوحة تحكم Cloudflare Pages:
1. اذهب إلى "Settings" > "Environment variables"
2. أضف المتغيرات التالية:
   - `NEXT_PUBLIC_SUPABASE_URL`: رابط مشروع Supabase
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: مفتاح Supabase العام
   - `NODE_ENV`: `production`

### 4. إعداد النطاق المخصص (اختياري)

1. في "Custom domains"
2. انقر "Set up a custom domain"
3. أدخل النطاق الخاص بك
4. اتبع التعليمات لتحديث DNS

## الملفات المهمة للنشر

- `next.config.js` - تكوين Next.js للتصدير الثابت
- `public/_headers` - إعدادات الأمان والتخزين المؤقت
- `public/_redirects` - إعادة التوجيه
- `wrangler.toml` - تكوين Cloudflare

## التحقق من النشر

1. تأكد من أن الموقع يعمل على الرابط المؤقت
2. اختبر نموذج قائمة الانتظار
3. تحقق من عمل Microsoft Clarity
4. اختبر الموقع على أجهزة مختلفة

## استكشاف الأخطاء

### مشكلة في البناء
- تأكد من أن جميع التبعيات مثبتة
- تحقق من عدم وجود أخطاء في الكود
- راجع سجلات البناء في Cloudflare

### مشكلة في متغيرات البيئة
- تأكد من إضافة جميع المتغيرات المطلوبة
- تحقق من صحة قيم Supabase

### مشكلة في التوجيه
- تأكد من وجود ملف `_redirects`
- تحقق من إعدادات Next.js

## الأمان

- تم تكوين CSP headers
- تم تفعيل HTTPS
- تم حماية الملفات الحساسة
- تم تكوين CORS للـ API

## الأداء

- تم تحسين الصور
- تم تفعيل التخزين المؤقت
- تم ضغط الملفات
- تم تحسين CSS و JS

## المراقبة

- Microsoft Clarity للتحليلات
- Cloudflare Analytics
- Supabase Dashboard للبيانات

---

**ملاحظة**: تأكد من تحديث الروابط في الكود ليشير إلى النطاق الجديد بدلاً من localhost.