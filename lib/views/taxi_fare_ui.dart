import 'package:material_ui/material_ui.dart';

class TaxiFareUi extends StatefulWidget {
  const TaxiFareUi({super.key});

  @override
  State<TaxiFareUi> createState() => _TaxiFareUiState();
}

class _TaxiFareUiState extends State<TaxiFareUi> {
  // ตัวควบคุม TextField() ระยะทางและเวลารถติด
  TextEditingController distanceController = TextEditingController();
  TextEditingController trafficController = TextEditingController();

  // ค่าโดยสารที่จะแสดงในกล่องผลลัพธ์
  String fareResult = '0.00';

  // สีหลักที่ใช้ในหน้านี้
  final Color mainColor = const Color(0xFFF0C342);
  final Color redColor = const Color(0xFFDB5443);

  // แสดง SnackBar แจ้งเตือนสีแดง
  void showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.warning_rounded,
              color: Color(0xFFF0C342),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(message),
          ],
        ),
        backgroundColor: redColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // คำนวณค่าโดยสารแบบขั้นบันได
  double calculateFare(double distance, double traffic) {
    double fare = 35; // กิโลเมตรแรก 35 บาท

    // [ระยะเริ่ม, ระยะสิ้นสุด, ราคาต่อกิโลเมตร]
    List<List<double>> rates = [
      [1, 10, 6.50],
      [10, 20, 7.00],
      [20, 40, 8.00],
      [40, 60, 8.50],
      [60, 80, 9.00],
      [80, double.infinity, 10.50],
    ];

    for (var rate in rates) {
      if (distance <= rate[0]) break;
      // คิดเฉพาะระยะที่อยู่ในช่วงนี้
      double km = (distance < rate[1] ? distance : rate[1]) - rate[0];
      fare += km * rate[2];
    }

    // รถติด นาทีละ 3 บาท
    fare += traffic * 3;
    return fare;
  }

  // หน้าตา TextField() ใช้ซ้ำ 2 ช่อง
  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text(
          'Taxi Fare',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 30,
          ),
          child: Column(
            children: [
              // ส่วนของรูปภาพ
              Image.asset(
                'assets/images/taxi.png',
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.45,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 20,
              ),
              // ส่วนหัวข้อ
              Text(
                'คำนวณค่าโดยสารแท็กซี่',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // ส่วนของระยะทาง
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ระยะทาง (กิโลเมตร) 🛣️',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: distanceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: inputStyle('กรุณากรอกระยะทาง'),
              ),
              const SizedBox(
                height: 15,
              ),

              // ส่วนของเวลารถติด
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'เวลารถติด (นาที) ⏰',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: trafficController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: inputStyle('กรุณากรอกเวลารถติด'),
              ),
              const SizedBox(
                height: 25,
              ),

              // ส่วนของปุ่มคำนวณ
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // validate input ก่อน ต้องกรอกครบทั้ง 2 ช่อง
                    if (distanceController.text.trim().isEmpty ||
                        trafficController.text.trim().isEmpty) {
                      showWarningSnackBar('กรุณากรอกข้อมูลให้ครบถ้วน');
                      return;
                    }

                    // ใช้ tryParse เพราะถ้ากรอกไม่ใช่ตัวเลขจะได้ null ไม่ error
                    double? distance =
                        double.tryParse(distanceController.text.trim());
                    double? traffic =
                        double.tryParse(trafficController.text.trim());
                    if (distance == null ||
                        traffic == null ||
                        distance <= 0 ||
                        traffic < 0) {
                      showWarningSnackBar('กรุณากรอกตัวเลขให้ถูกต้อง');
                      return;
                    }

                    // มีผลต่อการแสดงผล ต้องอยู่ใน setState() นะจ๊ะ
                    setState(() {
                      fareResult =
                          calculateFare(distance, traffic).toStringAsFixed(2);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'คำนวณค่าโดยสาร',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // ส่วนของปุ่มยกเลิก (ล้างค่า)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distanceController.clear();
                      trafficController.clear();
                      fareResult = '0.00';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E9E9E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ยกเลิก',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // ส่วนของกล่องแสดงผลลัพธ์
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAEBB9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ค่าโดยสารแท็กซี่',
                    ),
                    Text(
                      fareResult,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.045,
                        fontWeight: FontWeight.bold,
                        color: redColor,
                      ),
                    ),
                    const Text(
                      'บาท',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
