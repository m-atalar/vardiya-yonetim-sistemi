Feature: Vardiya Listesi Görüntüleme
  Senaryo: Kullanıcı ana sayfada vardiya listesini görüntüler
    Given kullanıcı ana sayfada
    When sayfa yüklendiğinde
    Then vardiya listesi görünür olmalı
    And en az 1 vardiya gösterilmeli
    And her vardiya için isim gösterilmeli
    And her vardiya için zaman bilgisi gösterilmeli
    And her vardiya için açıklama gösterilmeli
