# Vardiya Yönetim Sistemi

**Yazılım Gerçekleme ve Test Dersi - Hafta 7 Ödevi**

Öğrenci: **Mustafa ATALAR**

## Bağlantılar

- LinkedIn paylaşımı: https://www.linkedin.com/feed/update/urn:li:activity:7392639789466013696/
- GitHub (Repo): https://github.com/m-atalar/vardiya-yonetim-sistemi
- YouTube (Demo): https://youtu.be/tRJq6UtfuQo

## Proje Hakkında

Bu proje, çalışanların vardiyalarını yönetmek ve planlamak için geliştirilmiş bir web uygulamasıdır. Behavior-Driven Development (BDD) yaklaşımı ve Test-Driven Development (TDD) prensipleri kullanılarak geliştirilmiştir.

### Özellikler

- **Vardiya Yönetimi**: Sabah, akşam, gece ve öğleden sonra vardiyalarının yönetimi
- **Çalışan Yönetimi**: Departmanlara göre çalışan organizasyonu
- **Vardiya Atamaları**: Çalışanların vardiyalara atanması ve takibi
- **Departman Yönetimi**: Farklı departmanların organizasyonu
- **RESTful API**: Tam kapsamlı backend API
- **Modern UI**: React ve Tailwind CSS ile responsive arayüz
- **BDD Testleri**: Cypress ve Cucumber ile otomatik testler

## Teknoloji Yığını

### Backend
- Ruby on Rails 8.1.0 (API Mode)
- PostgreSQL
- RESTful API Architecture

### Frontend
- Next.js 16.0.1
- React 19.2.0
- TypeScript 5
- Tailwind CSS 4

### Testing
- Cypress 15.6.0
- Cucumber/Gherkin (BDD)
- @badeball/cypress-cucumber-preprocessor

## Proje Yapısı

```
.
├── backend/          # Rails API
│   ├── app/
│   │   ├── controllers/
│   │   └── models/
│   ├── config/
│   ├── db/
│   └── ...
├── frontend/         # Next.js Application
│   ├── app/
│   ├── cypress/
│   │   └── e2e/
│   └── ...
└── README.md
```

## Kurulum ve Çalıştırma

### Gereksinimler

- Ruby 3.3.9
- Rails 8.1.0
- PostgreSQL
- Node.js 18+
- npm veya yarn

### Backend Kurulumu

```bash
cd backend

# Bağımlılıkları yükle
bundle install

# Veritabanını oluştur ve migrate et
rails db:create
rails db:migrate
rails db:seed

# Sunucuyu başlat (Port 3000)
rails server
```

Backend API: `http://localhost:3000`

### Frontend Kurulumu

```bash
cd frontend

# Bağımlılıkları yükle
npm install

# Development sunucusunu başlat (Port 3001)
npm run dev
```

Frontend: `http://localhost:3001`

## API Endpoints

### Departments
- `GET /api/v1/departments` - Tüm departmanları listele
- `GET /api/v1/departments/:id` - Belirli bir departmanı getir
- `POST /api/v1/departments` - Yeni departman oluştur
- `PATCH/PUT /api/v1/departments/:id` - Departman güncelle
- `DELETE /api/v1/departments/:id` - Departman sil

### Employees
- `GET /api/v1/employees` - Tüm çalışanları listele
- `GET /api/v1/employees/:id` - Belirli bir çalışanı getir
- `POST /api/v1/employees` - Yeni çalışan oluştur
- `PATCH/PUT /api/v1/employees/:id` - Çalışan güncelle
- `DELETE /api/v1/employees/:id` - Çalışan sil

### Shifts
- `GET /api/v1/shifts` - Tüm vardiyaları listele
- `GET /api/v1/shifts/:id` - Belirli bir vardiyayı getir
- `POST /api/v1/shifts` - Yeni vardiya oluştur
- `PATCH/PUT /api/v1/shifts/:id` - Vardiya güncelle
- `DELETE /api/v1/shifts/:id` - Vardiya sil

### Shift Assignments
- `GET /api/v1/shift_assignments` - Tüm vardiya atamalarını listele
- `GET /api/v1/shift_assignments/:id` - Belirli bir atamayı getir
- `POST /api/v1/shift_assignments` - Yeni atama oluştur
- `PATCH/PUT /api/v1/shift_assignments/:id` - Atama güncelle
- `DELETE /api/v1/shift_assignments/:id` - Atama sil

## Veritabanı Modelleri

### Department (Departman)
- name (string, unique)
- description (text)
- İlişki: has_many :employees

### Employee (Çalışan)
- name (string)
- email (string, unique)
- phone (string)
- role (string: manager, employee, supervisor)
- department_id (foreign key)
- İlişkiler: belongs_to :department, has_many :shift_assignments

### Shift (Vardiya)
- name (string)
- start_time (time)
- end_time (time)
- description (text)
- İlişki: has_many :shift_assignments

### ShiftAssignment (Vardiya Ataması)
- employee_id (foreign key)
- shift_id (foreign key)
- date (date)
- status (string: scheduled, completed, cancelled)
- İlişkiler: belongs_to :employee, belongs_to :shift

## BDD Testleri

Proje, Behavior-Driven Development yaklaşımı ile geliştirilmiştir. Cypress ve Cucumber kullanılarak yazılan testler, kullanıcı senaryolarını Türkçe olarak tanımlar.

### Test Senaryoları

**Feature**: Vardiya Listesi Görüntüleme

**Senaryo**: Kullanıcı ana sayfada vardiya listesini görüntüler
- Given: kullanıcı ana sayfada
- When: sayfa yüklendiğinde
- Then: vardiya listesi görünür olmalı
- And: en az 1 vardiya gösterilmeli
- And: her vardiya için isim gösterilmeli
- And: her vardiya için zaman bilgisi gösterilmeli
- And: her vardiya için açıklama gösterilmeli

### Testleri Çalıştırma

```bash
cd frontend

# Cypress test arayüzünü aç
npm run cypress:open

# Testleri headless modda çalıştır
npm run cypress:run
```

**Not**: Testleri çalıştırmadan önce hem backend hem de frontend sunucularının çalışıyor olması gerekir.

## Red-Green-Refactor Döngüsü

Bu proje TDD prensipleri ile geliştirilmiştir:

1. **RED**: Önce test senaryoları yazıldı (Gherkin format)
2. **GREEN**: Testleri geçecek şekilde kod geliştirildi
3. **REFACTOR**: Kod optimize edildi ve iyileştirildi

## Geliştirme Süreci

1. Backend API tasarımı ve model oluşturma
2. Migration ve seed data hazırlama
3. Controller'lar ve route'ların implementasyonu
4. Frontend component tasarımı
5. API entegrasyonu
6. BDD test senaryolarının yazılması
7. Test-driven geliştirme döngüsü
8. UI/UX iyileştirmeleri

## Örnek Veri

Sistem, aşağıdaki örnek verilerle birlikte gelir:

- 4 Departman (IT, HR, Operations, Sales)
- 6 Çalışan (farklı departmanlarda)
- 4 Vardiya (Morning, Evening, Night, Afternoon)
- 8 Vardiya Ataması

## Lisans

Bu proje, eğitim amaçlı geliştirilmiştir.

---

**Not**: Bu proje, Yazılım Gerçekleme ve Test dersi kapsamında BDD ve TDD yaklaşımlarını öğrenmek amacıyla geliştirilmiştir.
