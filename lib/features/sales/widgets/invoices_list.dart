import 'package:flutter/material.dart';
import 'package:gps_module/data/models/sales/sales_model.dart';
import 'package:gps_module/features/sales/widgets/invoice_widget.dart';

import '../../../data/models/invoice/invoice_model.dart';

class invoicesList extends StatelessWidget {
  final List<SalesModel> invoices;
  const invoicesList({super.key, required this.invoices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: invoices.length,
      itemBuilder: (BuildContext context, int index) {
        return InvoiceWidget(
          invoice: invoices[index],
        );
      },
    );
  }
}
