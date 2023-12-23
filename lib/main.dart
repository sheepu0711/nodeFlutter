import 'package:node_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  // Hàm này để khai báo sử dụng dung lượng lưu trữ của thiết bị
  // dùng để lưu trữ các biến như Url Mqtt, Port, Username, Password, Topic
  // để lần mở app sau sẽ không cần phải nhập lại
  await GetStorage.init();

  // Khởi tạo ứng dụng
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Đây là widget gốc của ứng dụng
  @override
  Widget build(BuildContext context) {
    // GetMaterialApp để khai báo sử dụng Route Management của GetX
    return GetMaterialApp(
      // Tắt banner debug ở góc phải màn hình
      debugShowCheckedModeBanner: false,
      // Khai báo các màn hình và controller của nó
      getPages: AppPages.routes,
      // Màn hình bắt đầu khi vào ứng dụng
      initialRoute: AppPages.initial,
      // Các thuộc tính màu, font chữ, ...
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
