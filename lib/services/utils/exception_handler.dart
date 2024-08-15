import 'package:digister/widgets/notification.dart';
import 'package:dio/dio.dart';
import 'package:toastification/toastification.dart';

class ExceptionHandler {
  static dynamic falseException(
    DioException error, {
    required dynamic returnValue,
  }) {
    if (error.type == DioExceptionType.connectionError) {
      NotificationWidget.show(
        title: 'Connection error!',
        description:
            'Silahkan hubungkan perangkat anda ke jaringan internet dan coba lagi.',
        type: ToastificationType.error,
      );

      return returnValue;
    }

    if (error.type == DioExceptionType.connectionTimeout) {
      NotificationWidget.show(
        title: 'Connection timeout!',
        description: 'Mohon cek koneksi internet anda dan coba lagi.',
        type: ToastificationType.error,
      );

      return returnValue;
    }

    if (error.type == DioExceptionType.receiveTimeout) {
      NotificationWidget.show(
        title: 'Server timeout!',
        description: 'Server sedang penuh. Silahkan coba beberapa saat lagi.',
        type: ToastificationType.error,
      );

      return returnValue;
    }

    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }

    return returnValue;
  }
}
