import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        //rotaları tanımladık sayfalar arası geçiş için
        "/": (BuildContext context) => GirisEkrani(),
        "/KayitEkrani": (BuildContext context) => KayitEkrani(),
        "/AnaSayfa": (BuildContext context) => AnaSayfa(),
        "/ProfilSayfasi": (BuildContext context) => ProfilSayfasi(),
        "/ChatApp": (BuildContext context) => ChatApp(),
      },
    );
  }
}

List<Map<String, String>> kayitliKullanicilar = [
  {"ad": "admin", "sifre": "1234"}
]; // Kullanıcıları burada saklıyoruz geçici olarak databse yok

//GİRİŞ EKRANI
class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  girisYap() {
    //burada bilgileri kontrol eden bir sistem var
    String ad = t1.text;
    String sifre = t2.text;

    bool girisBasarili = kayitliKullanicilar.any(
        (kullanici) => kullanici["ad"] == ad && kullanici["sifre"] == sifre);

    if (girisBasarili) {
      Navigator.pushNamed(
        context,
        "/AnaSayfa",
      );
    } else {
      //uyarı ekranı buna bakarak yapabilirsin
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Yanlış kullanıcı adı veya Şifre"),
              content: new Text("Lütfen Girdiğiniz Bilgileri Kontrol Ediniz!!"),
              actions: [
                new FloatingActionButton(
                    child: new Text("Kapat"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
  }

  kayitEkrani() {
    Navigator.pushNamed(context, "/KayitEkrani");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GİRİŞ EKRANI")),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(100),
          child: Column(
            children: [
              TextFormField(
                  decoration: InputDecoration(hintText: "Kullanıcı Adı"),
                  controller: t1),
              TextFormField(
                  decoration: InputDecoration(hintText: "Şifre"),
                  controller: t2),
              ElevatedButton(onPressed: girisYap, child: Text("Giriş")),
              Row(
                children: [
                  Text("Hesabın yok mu?--->"),
                  TextButton(onPressed: kayitEkrani, child: Text("Kaydol")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//KAYIT EKRANI
class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  kayitOl() {
    //kaydeden sistem var burada
    String ad = t3.text;
    String sifre = t4.text;

    if (ad.isNotEmpty && sifre.isNotEmpty) {
      kayitliKullanicilar.add({"ad": ad, "sifre": sifre});
      Navigator.pushNamed(context, "/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lütfen tüm alanları doldurun!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("KAYIT EKRANI"),
        ),
        body: Container(
          child: Column(
            children: [
              TextFormField(
                  decoration: InputDecoration(hintText: "Kullanıcı Adı"),
                  controller: t3),
              TextFormField(
                decoration: InputDecoration(hintText: "Şifre"),
                controller: t4,
              ),
              ElevatedButton(onPressed: kayitOl, child: Text("Kayıt Ol"))
            ],
          ),
        ));
  }
}

//ANA SAYFA
class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  chatApp() {
    Navigator.pushNamed(context, "/ChatApp");
  }

  account() {
    Navigator.pushNamed(context, "/ProfilSayfasi");
  }

  quit() {
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ana Sayfa"),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: chatApp, icon: Icon(Icons.messenger_outline)),
                  IconButton(
                      onPressed: account, icon: Icon(Icons.account_circle)),
                  IconButton(onPressed: quit, icon: Icon(Icons.account_tree)),
                ],
              )
            ],
          ),
        ));
  }
}

//PROFİL SAYFASI
class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({super.key});

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  List<String> mesajlar = []; // Mesajları tutan liste
  TextEditingController mesajController = TextEditingController();

  void mesajGonder() {
    String mesaj = mesajController.text;
    if (mesaj.isNotEmpty) {
      setState(() {
        mesajlar.add(mesaj);
      });
      mesajController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mesajlaşma")),
      body: Column(
        children: [
          // Mesajları gösteren kısım
          Expanded(
            child: ListView.builder(
              itemCount: mesajlar.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      mesajlar[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          // Mesaj yazma ve gönderme kısmı
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mesajController,
                    decoration: InputDecoration(
                      hintText: "Mesajınızı yazın...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: mesajGonder,
                  icon: Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VeriModeli {
  String kullaniciAdi, sifre;
  VeriModeli(this.kullaniciAdi, this.sifre);
}
