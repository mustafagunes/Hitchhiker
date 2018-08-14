# Hitchhiker

![](https://img.shields.io/teamcity/codebetter/bt428.svg)
![](https://img.shields.io/badge/swift-3.0-red.svg)
![](https://img.shields.io/badge/xcode-8.3-blue.svg)
![](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![](https://img.shields.io/badge/license-Apache%202.0-yellow.svg)

### Uygulama içinden görüntüler
![ScreenShot](https://raw.github.com/mustafagunes/Hitchhiker/master/README%20Docs/otostop.gif)

İÇERİK
------
Aşağıda uygulamada için kullanılan araçlar ve kütüphanelerin listesi yer alıyor.

1. **POD** - Üçüncü parti kütüphaneleri yüklediğim araç
    - [Firebase](https://github.com/firebase/firebase-ios-sdk) - Google'ın geliştirdiği anlık veri alışverişini sağlayabileceğiniz veritabanı kütüphanesi.
      * Firebase/Core
      * Firebase/Auth
      * Firebase/Database
    - [RevealingSplashView](https://github.com/PiXeL16/RevealingSplashView) - Uygulama başlangıcında LaunchScreen'i kullanarak efektli uygulama başlangıcı sağlıyor.
    
2. **GIT - Versiyon Kontrol**
    - ```git add -A``` - Bulunduğunuz dosyadaki bütün parçaları alır.
    - ```git commit -m "<description>"``` - Yaptığınız değişikliklerden sonra versiyonla alakalı açıklama kısmı.
    - ```git push -u origin master``` - Yukarıdakileri sırası ile yaptıysanız, bu komutla Github, Gitlab ve BitBucket gibi depolara projenizi gönderebilirsiniz

**Not:** Yukarıdaki komutlar git içerisindeki bazı komutlardır. Komutların tamamı için : [GIT Docs](https://git-scm.com/docs)

Projeyi İndirme & Kurma
-----------------------

* **Elle Kurulum**
    - [Bu linke tıkyarak projeyi .zip olarak indirin](https://github.com/mustafagunes/Hitchhiker/archive/master.zip)
    - İndirme işlemi bittikten sonra, dosyaları çıkartın.
    - Ardından **htchhkr-development.xcworkspace** çift tıklayarak projeyi çalıştırın.

* **Terminal ile Kurulum**
    - Aşağıdaki komutları sırasıyla terminale yazın ve çalıştırın:
        * ```git clone https://github.com/mustafagunes/Hitchhiker.git```
        * ```cd htchhkr-development```
    - Son olarak aşağıdaki komutu yazın ve çalıştırın:
        * ```open htchhkr-development.xcworkspace```
