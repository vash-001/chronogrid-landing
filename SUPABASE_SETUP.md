# Supabase Setup Guide

This guide will help you set up Supabase for the ChronoGrid landing page waitlist functionality.

## 🚀 Quick Setup

### 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Sign up or log in to your account
3. Click "New Project"
4. Choose your organization
5. Enter project details:
   - **Name**: `chronogrid-landing`
   - **Database Password**: Generate a strong password
   - **Region**: Choose closest to your users
6. Click "Create new project"

### 2. Get API Credentials

1. Go to **Settings** → **API**
2. Copy the following values:
   - **Project URL** (anon public)
   - **anon public key**

### 3. Set Environment Variables

Create or update your `.env.local` file:

```env
NEXT_PUBLIC_SUPABASE_URL=your_project_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
NODE_ENV=development
```

## إعداد قاعدة البيانات

### 1. إنشاء الجدول

1. اذهب إلى **SQL Editor** في لوحة تحكم Supabase
2. انسخ والصق محتوى ملف `supabase-setup.sql`
3. انقر على "Run" لتنفيذ الاستعلام

### 2. التحقق من الإعداد

بعد تنفيذ SQL:

1. اذهب إلى **Table Editor**
2. يجب أن ترى جدول `waitlist` مع الأعمدة التالية:
   - `id` (UUID, Primary Key)
   - `email` (VARCHAR, Unique)
   - `status` (VARCHAR, Default: 'pending')
   - `source` (VARCHAR, Default: 'website')
   - `metadata` (JSONB)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

## الميزات المتاحة

### 1. إضافة إيميل لقائمة الانتظار
```typescript
import { waitlistService } from '@/lib/supabase'

const { data, error } = await waitlistService.addToWaitlist('user@example.com')
```

### 2. التحقق من وجود الإيميل
```typescript
const { exists, error } = await waitlistService.checkEmailExists('user@example.com')
```

### 3. الحصول على عدد المشتركين
```typescript
const { count, error } = await waitlistService.getWaitlistCount()
```

### 4. تحديث حالة الإيميل
```typescript
const { data, error } = await waitlistService.updateEmailStatus('user@example.com', 'confirmed')
```

## الأمان والخصوصية

### Row Level Security (RLS)
- تم تفعيل RLS على جدول `waitlist`
- السياسات المطبقة:
  - **إدراج عام**: يمكن لأي شخص إضافة إيميل
  - **قراءة عامة**: يمكن التحقق من وجود الإيميلات
  - **لا توجد تحديثات أو حذف عام**: محمي من التلاعب

### الفهارس المحسنة
- فهرس على `email` للبحث السريع
- فهرس على `created_at` للترتيب
- فهرس على `status` للتصفية

## إحصائيات قائمة الانتظار

يمكنك الحصول على إحصائيات مفصلة:

```sql
SELECT get_waitlist_stats();
```

سيعطيك:
- العدد الإجمالي
- عدد المعلقين
- عدد المؤكدين
- عدد الملغيين
- إحصائيات يومية/أسبوعية/شهرية

## استكشاف الأخطاء

### خطأ في الاتصال
- تأكد من صحة `NEXT_PUBLIC_SUPABASE_URL`
- تأكد من صحة `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- تأكد من أن المشروع نشط في Supabase

### خطأ في الصلاحيات
- تأكد من تفعيل RLS
- تأكد من وجود السياسات الصحيحة

### خطأ في الجدول
- تأكد من تنفيذ `supabase-setup.sql` بالكامل
- تحقق من وجود الجدول في **Table Editor**

## الخطوات التالية

1. **تشغيل المشروع**: `npm run dev`
2. **اختبار النموذج**: جرب إضافة إيميل في الموقع
3. **مراقبة البيانات**: تحقق من الجدول في Supabase
4. **إعداد التنبيهات**: اختياري - إعداد webhooks للتنبيهات

## ملاحظات مهمة

- **لا تشارك مفاتيح API**: احتفظ بـ `.env.local` خاص
- **استخدم HTTPS**: في الإنتاج، تأكد من استخدام HTTPS
- **نسخ احتياطية**: فعل النسخ الاحتياطية التلقائية في Supabase
- **مراقبة الاستخدام**: راقب حدود الخطة المجانية

---

**تم الإعداد بنجاح!** 🎉

الآن يمكن للمستخدمين الانضمام لقائمة الانتظار وسيتم حفظ بياناتهم بأمان في Supabase.