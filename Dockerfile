
# 1. تحديد الصورة الأساسية (ضروري)
FROM node:18-alpine 

# 2. تعيين مجلد العمل
WORKDIR /app

# 3. نسخ ملفات package*.json من مجلد 'app' وتثبيت الاعتماديات
COPY app/package*.json ./

RUN npm install

# 4. نسخ باقي ملفات التطبيق من مجلد 'app'
COPY app/. .

# 5. تحديد المنفذ وأمر التشغيل
EXPOSE 3000
CMD ["node", "index.js"]
=======
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]  # أو الملف الرئيسي في مشروعك
>>>>>>> a2f6e19219ab60afc516c42bde31bbc93dd30dc5
