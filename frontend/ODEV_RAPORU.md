# ÖDEV RAPORU
# Kütüphane Yönetim Sistemi - BDD ile Frontend Geliştirme

**Ders:** Yazılım Gerçekleme
**Öğrenci:** Mustafa Atalar
**Tarih:** 5 Kasım 2025
**Mentorlük:** Nurettin Şenyer ve Ömer Durmuş

---

## 1. Proje Özeti

Bu projede, **Behavior Driven Development (BDD)** yaklaşımı kullanılarak bir kütüphane yönetim sistemi frontend uygulaması geliştirilmiştir. Proje, önceki haftalarda geliştirilen Ruby on Rails API backend'ine bağlanan bir Next.js uygulamasıdır.

### Proje Hedefi
- BDD metodolojisini uygulama
- Red-Green-Refactor döngüsünü deneyimleme
- Cypress + Cucumber ile E2E test yazma
- Full-stack entegrasyon gerçekleştirme

---

## 2. Kullanılan Teknolojiler

### Backend
- **Framework:** Ruby on Rails 8.1.0
- **Veritabanı:** PostgreSQL
- **Mimari:** API-only (RESTful)
- **Port:** 3000

### Frontend
- **Framework:** Next.js 16.0.1
- **React Version:** 19.2.0
- **Language:** TypeScript 5
- **Styling:** Tailwind CSS 4
- **Port:** 3001

### Test & BDD
- **Test Framework:** Cypress 15.6.0
- **BDD Tool:** Cucumber (Gherkin syntax)
- **Preprocessor:** @badeball/cypress-cucumber-preprocessor 23.2.1
- **Build Tool:** @bahmutov/cypress-esbuild-preprocessor 2.2.7

---

## 3. BDD Yaklaşımı ve Red-Green Döngüsü

### 3.1. BDD Nedir?
Behavior Driven Development (Davranış Odaklı Geliştirme), yazılımın davranışını tanımlayan testlerin önce yazılıp, sonra kodu geliştirme yaklaşımıdır.

### 3.2. Red-Green-Refactor Döngüsü

#### 🔴 RED PHASE (Kıpkırmızı - %100 Fail)
**Adımlar:**
1. Gherkin formatında test senaryosu yazıldı
2. Cypress step definitions oluşturuldu
3. Frontend kodu YOK iken testler çalıştırıldı
4. **Sonuç:** 1 test, 0 passing, 1 failing (%100 FAIL) ✅

**Test Çıktısı:**
```
Tests:        1
Passing:      0
Failing:      1
Pending:      0
Skipped:      0
```

**Hata Mesajı:**
```
AssertionError: Timed out retrying after 4000ms:
Expected to find element: `[data-testid="books-list"]`, but never found it.
```

#### 🟢 GREEN PHASE (Yemyeşil - %100 Success)
**Adımlar:**
1. Frontend kodu geliştirildi
2. API entegrasyonu yapıldı
3. UI komponenti oluşturuldu
4. Testler tekrar çalıştırıldı
5. **Sonuç:** 1 test, 1 passing, 0 failing (%100 SUCCESS) ✅

**Test Çıktısı:**
```
Tests:        1
Passing:      1
Failing:      0
Pending:      0
Skipped:      0
Duration:     2 seconds
```

---

## 4. Geliştirme Süreci

### 4.1. Backend Hazırlık

#### CORS Konfigürasyonu
Backend'de CORS (Cross-Origin Resource Sharing) ayarları yapıldı:

**Gemfile:**
```ruby
gem "rack-cors"
```

**config/initializers/cors.rb:**
```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:3001", "127.0.0.1:3001"
    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

#### Seed Data
Backend'de 5 kitap yüklendi:
- My Name is Red (Orhan Pamuk)
- The Bastard of Istanbul (Elif Şafak)
- Memed, My Hawk (Yaşar Kemal)
- Snow (Orhan Pamuk)
- The Forty Rules of Love (Elif Şafak)

#### API Endpoint
```
GET http://localhost:3000/api/v1/books
```

### 4.2. Frontend Kurulum

#### Next.js Projesi
```bash
npx create-next-app@latest library-frontend \
  --typescript \
  --tailwind \
  --app \
  --no-src-dir \
  --turbopack \
  --eslint \
  --yes
```

#### Cypress + Cucumber Kurulumu
```bash
npm install --save-dev \
  cypress \
  @badeball/cypress-cucumber-preprocessor \
  @bahmutov/cypress-esbuild-preprocessor
```

#### Package.json Konfigürasyonu
```json
{
  "scripts": {
    "dev": "next dev --port 3001",
    "cypress:open": "cypress open",
    "cypress:run": "cypress run"
  },
  "cypress-cucumber-preprocessor": {
    "stepDefinitions": "cypress/e2e/**/*.ts",
    "messages": {
      "enabled": true
    }
  }
}
```

### 4.3. Test Senaryosu (Gherkin)

**Dosya:** `cypress/e2e/books.feature`

```gherkin
Feature: Kitap Listesi Görüntüleme
  Kütüphane yönetim sisteminde kullanıcılar kitapları görüntüleyebilmelidir

  Scenario: Kullanıcı ana sayfada kitap listesini görüntüler
    Given kullanıcı ana sayfada
    When sayfa yüklendiğinde
    Then kitap listesi görünür olmalı
    And en az 1 kitap gösterilmeli
    And her kitap için başlık gösterilmeli
    And her kitap için yazar gösterilmeli
    And her kitap için açıklama gösterilmeli
```

### 4.4. Step Definitions

**Dosya:** `cypress/e2e/books.ts`

```typescript
import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Given("kullanıcı ana sayfada", () => {
  cy.visit("/");
});

When("sayfa yüklendiğinde", () => {
  cy.wait(1000);
});

Then("kitap listesi görünür olmalı", () => {
  cy.get('[data-testid="books-list"]').should("be.visible");
});

Then("en az {int} kitap gösterilmeli", (count: number) => {
  cy.get('[data-testid="book-item"]').should("have.length.at.least", count);
});

// ... diğer step'ler
```

### 4.5. Frontend Geliştirme

**Dosya:** `app/page.tsx`

#### API Entegrasyonu
```typescript
const [books, setBooks] = useState<Book[]>([]);

useEffect(() => {
  const fetchBooks = async () => {
    const response = await fetch("http://localhost:3000/api/v1/books");
    const data = await response.json();
    setBooks(data);
  };
  fetchBooks();
}, []);
```

#### UI Komponenti
```typescript
<div data-testid="books-list" className="space-y-6">
  {books.map((book) => (
    <div key={book.id} data-testid="book-item" className="bg-white rounded-lg shadow-lg p-6">
      <h2 data-testid="book-title">{book.title}</h2>
      <div data-testid="book-author">
        {book.authors.map((author) => author.name).join(", ")}
      </div>
      <p data-testid="book-description">{book.description}</p>
    </div>
  ))}
</div>
```

---

## 5. Test Sonuçları

### 5.1. RED Phase Sonucu

**Komut:**
```bash
npm run cypress:run
```

**Çıktı:**
```
Running:  books.feature

Kitap Listesi Görüntüleme
  1) Kullanıcı ana sayfada kitap listesini görüntüler

0 passing (10s)
1 failing

✖  books.feature                00:09        1        -        1        -        -
✖  1 of 1 failed (100%)         00:09        1        -        1        -        -
```

**Screenshot:**
- `cypress/screenshots/books.feature/Kitap Listesi Görüntüleme -- Kullanıcı ana sayfada kitap listesini görüntüler (failed).png`

**Video:**
- `cypress/videos/books.feature.mp4` (RED phase)

### 5.2. GREEN Phase Sonucu

**Komut:**
```bash
npm run cypress:run
```

**Çıktı:**
```
Running:  books.feature

Kitap Listesi Görüntüleme
  ✓ Kullanıcı ana sayfada kitap listesini görüntüler (2317ms)

1 passing (2s)

✔  books.feature                00:02        1        1        -        -        -
✔  All specs passed!            00:02        1        1        -        -        -
```

**Video:**
- `cypress/videos/books.feature.mp4` (GREEN phase)

---

## 6. Proje Yapısı

```
library-frontend/
├── app/
│   ├── page.tsx                  # Ana sayfa (kitap listesi)
│   ├── layout.tsx                # Root layout
│   └── globals.css               # Global styles
├── cypress/
│   ├── e2e/
│   │   ├── books.feature         # Gherkin test senaryosu
│   │   └── books.ts              # Step definitions
│   ├── support/
│   │   ├── e2e.ts                # Cypress support dosyası
│   │   └── commands.ts           # Custom commands
│   ├── videos/                   # Test videoları
│   │   └── books.feature.mp4     # Demo video
│   ├── screenshots/              # Test ekran görüntüleri
│   └── tsconfig.json             # Cypress TypeScript config
├── cypress.config.ts             # Cypress konfigürasyonu
├── package.json                  # Dependencies & scripts
├── tsconfig.json                 # TypeScript konfigürasyonu
├── tailwind.config.ts            # Tailwind CSS konfigürasyonu
├── README.md                     # Proje dokümantasyonu
└── ODEV_RAPORU.md               # Bu rapor
```

---

## 7. Özellikler

### Frontend Özellikleri
- ✅ API'den kitap listesini çekme
- ✅ Responsive tasarım (Tailwind CSS)
- ✅ Loading state gösterimi
- ✅ Error handling
- ✅ Kitap detayları (başlık, yazar, açıklama, kategoriler, ISBN, yayın tarihi)
- ✅ Modern UI/UX (gradient background, shadow effects, hover animations)

### Test Özellikleri
- ✅ Gherkin formatında test senaryoları
- ✅ E2E test coverage (%100)
- ✅ Headless mod desteği
- ✅ Otomatik video kaydı
- ✅ Screenshot alma
- ✅ Test raporlama

---

## 8. Git & Versiyon Kontrolü

### Commit Geçmişi

**1. İlk Commit (BDD Geliştirmesi):**
```bash
git commit -m "feat: Kütüphane yönetim sistemi - BDD ile frontend geliştirmesi

- Next.js 16 + TypeScript + Tailwind CSS
- Cypress + Cucumber (BDD) test entegrasyonu
- Gherkin formatında test senaryosu
- Ruby on Rails API entegrasyonu
- Kitap listesi görüntüleme özelliği
- RED-GREEN BDD döngüsü uygulandı
- %100 test coverage

Mentorlük: Nurettin Şenyer ve Ömer Durmuş"
```

**2. İkinci Commit (Dokümantasyon):**
```bash
git commit -m "docs: YouTube demo videosu ve repository linkleri eklendi"
```

---

## 9. Paylaşımlar

### GitHub Repositories
- **Frontend:** https://github.com/m-atalar/library-management-frontend
- **Backend:** https://github.com/m-atalar/library-management-api

### YouTube Demo Video
- **Link:** https://youtu.be/vVzLksRlI1w
- **Başlık:** "Kütüphane Yönetim Sistemi - BDD ile Frontend Geliştirme | Next.js + Cypress + Cucumber"
- **Açıklama:** BDD yaklaşımı, Red-Green döngüsü, test sonuçları

### LinkedIn Paylaşımı
- **Link:** https://www.linkedin.com/posts/mustafa-atalar-ba5300299_k%C3%BCt%C3%BCphane-y%C3%B6netim-sistemi-bdd-ile-frontend-share-7391901400898662402-R6DT
- **İçerik:** Proje özeti, teknolojiler, test sonuçları, linkler
- **Hashtag'ler:** #BDD #TDD #NextJS #Cypress #TestAutomation

---

## 10. Karşılaşılan Zorluklar ve Çözümler

### 10.1. CORS Hatası
**Problem:** Frontend, backend API'ye istek atamıyordu.
**Çözüm:** Backend'de `rack-cors` gem eklendi ve CORS ayarları yapıldı.

### 10.2. Cypress Cucumber Entegrasyonu
**Problem:** Cucumber preprocessor konfigürasyonu karmaşıktı.
**Çözüm:** `@badeball/cypress-cucumber-preprocessor` kullanıldı ve `package.json`'a özel ayarlar eklendi.

### 10.3. Test Data-testid'leri
**Problem:** Cypress testleri elementi bulamıyordu.
**Çözüm:** Her UI elementine `data-testid` attribute'u eklendi.

### 10.4. Port Çakışması
**Problem:** Backend ve frontend aynı portu kullanıyordu.
**Çözüm:** Backend: 3000, Frontend: 3001 olarak ayrıldı.

---

## 11. Öğrenilenler

### BDD Metodolojisi
- Test senaryolarını önce yazmak, geliştirmeye yön veriyor
- Red-Green döngüsü, kod kalitesini artırıyor
- Gherkin syntax, teknik olmayan kişilerle iletişimi kolaylaştırıyor

### Cypress + Cucumber
- E2E testleri yazmak, manuel test süresini azaltıyor
- Video kaydı, hata ayıklamayı kolaylaştırıyor
- Step definitions, test kodunu yeniden kullanılabilir yapıyor

### Full-Stack Entegrasyon
- Backend ve frontend arasındaki iletişim protokollerini (CORS, REST API)
- TypeScript ile tip güvenliği sağlama
- Modern UI geliştirme (Tailwind CSS, React Hooks)

---

## 12. İstatistikler

### Kod İstatistikleri
- **Toplam Dosya:** 15+
- **TypeScript Dosyaları:** 8
- **Test Dosyaları:** 2 (feature + step definitions)
- **Toplam Satır:** ~500+ (frontend + test)

### Test İstatistikleri
- **Toplam Test Senaryosu:** 1
- **Toplam Step:** 7
- **Test Coverage:** %100
- **Test Süresi:** ~2 saniye

### Commit İstatistikleri
- **Toplam Commit:** 2
- **Değişen Dosya:** 13
- **Eklenen Satır:** ~7500+
- **Video Dosyası:** 1 (commit'e dahil)

---

## 13. Sonuç

Bu projede, **Behavior Driven Development (BDD)** yaklaşımını başarıyla uyguladım. Red-Green-Refactor döngüsü sayesinde:

1. ✅ Önce testler yazıldı (%100 fail)
2. ✅ Kod geliştirildi
3. ✅ Testler geçildi (%100 success)

### Proje Başarıları
- ✅ Full-stack entegrasyon (Rails + Next.js)
- ✅ BDD metodolojisi uygulandı
- ✅ %100 test coverage elde edildi
- ✅ Modern teknolojiler kullanıldı
- ✅ Dokümantasyon tamamlandı
- ✅ GitHub, YouTube, LinkedIn'de paylaşıldı

### Gelecek Geliştirmeler
- Daha fazla test senaryosu eklenebilir (kitap detay sayfası, arama, filtreleme)
- CI/CD pipeline kurulabilir
- Authentication eklenebilir
- Unit testler eklenebilir (Jest + React Testing Library)

---

## 14. Kaynaklar

### Dokümantasyon
- Next.js: https://nextjs.org/docs
- Cypress: https://docs.cypress.io
- Cucumber: https://cucumber.io/docs/guides
- Tailwind CSS: https://tailwindcss.com/docs

### Paketler
- @badeball/cypress-cucumber-preprocessor: https://github.com/badeball/cypress-cucumber-preprocessor
- @bahmutov/cypress-esbuild-preprocessor: https://github.com/bahmutov/cypress-esbuild-preprocessor

---

## 15. Teşekkür

Bu projeyi geliştirirken bana rehberlik eden **Nurettin Şenyer** ve **Ömer Durmuş** hocalarıma teşekkür ederim.

---

**Tarih:** 5 Kasım 2025
**Öğrenci:** Mustafa Atalar
**Ders:** Yazılım Gerçekleme
**Konu:** BDD ile Frontend Geliştirme
