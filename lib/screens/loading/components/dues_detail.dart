import 'dart:convert';
import 'package:digister/models/dues_model.dart';
import 'package:digister/screens/confirmation/components/image_field.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/text_between.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DuesDetail extends StatelessWidget {
  const DuesDetail({
    super.key,
    required this.dues,
    required this.isInfo,
  });

  final DuesModel dues;
  final bool isInfo;

  void _showImageDetail(BuildContext context) {
    showModalDialog(
      context,
      Dialog(
        child: ImageModalContent(
          context: context,
          bytes: base64Decode(dues.proofOfPayment!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? theme.colorScheme.secondary
            : theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary.withOpacity(0.1),
            offset: const Offset(4, 5),
            blurRadius: 9,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 65),
          TextBetween(
            text1: 'Jenis iuran',
            text2: dues.duesType!,
          ),
          TextBetween(
            text1: 'Harga',
            text2: 'Rp. ${dues.duesPrice!}',
          ),
          TextBetween(
            text1: 'Pembayaran bulan',
            text2: DateFormat('MMMM yyyy', 'id').format(
              DateTime(
                int.parse(dues.paymentYear!),
                dues.paymentMonth!,
              ),
            ),
          ),
          TextBetween(
            text1: 'Tanggal pembayaran',
            text2: DateFormat('d MMMM yyyy', 'id').format(
              DateTime.parse(dues.paymentDate!),
            ),
          ),
          const Text('Bukti pembayaran'),
          const SizedBox(height: 10),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: MemoryImage(
                  base64Decode(dues.proofOfPayment!),
                ),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => _showImageDetail(context),
              child: const Text('Lihat gambar'),
            ),
          ),
          if (dues.explanation != null) ...[
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Keterangan'),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(dues.explanation ?? ""),
            ),
          ],
          if (isInfo) const SizedBox(height: 10),
          if (isInfo)
            Text(
              dues.isValid == 0 ? 'Belum divalidasi' : 'Sudah divalidasi',
              style: theme.textTheme.titleMedium!.copyWith(
                color: dues.isValid == 0
                    ? theme.colorScheme.primary
                    : Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
