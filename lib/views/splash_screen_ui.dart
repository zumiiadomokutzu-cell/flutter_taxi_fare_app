import 'package:material_ui/material_ui.dart';
import 'package:flutter_taxi_fare_app/views/taxi_fare_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // หน่วงเวลา 3 วินาทีแล้วเปิดไปหน้า TaxiFareUi() แบบย้อนกลับไม่ได้
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TaxiFareUi(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ส่วนของรูปภาพ
            Image.asset(
              'assets/images/taxi.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Taxi Fare Calculator',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7FB5F0),
              ),
            ),
            Text(
              'คำนวณค่าโดยสารแท็กซี่',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                color: const Color(0xFF7FB5F0),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const CircularProgressIndicator(
              color: Color(0xFFF0C342),
            ),
          ],
        ),
      ),
    );
  }
}
