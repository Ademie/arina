import 'package:flutter/material.dart';

class PriceSummary extends StatelessWidget {
  const PriceSummary({
    super.key,
    required this.duration,
    required this.rent,
    required this.security,
    required this.service,
    required this.total,
  });

  final String duration;
  final String rent;
  final String security;
  final String service;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 3,
                child: ListTile(
                  title: Text('Duration'),
                ),
              ),
              Text("$duration months")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: ListTile(
                  title: Text('Rent'),
                ),
              ),
              Text("₦$rent")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: ListTile(
                  title: Text('Security'),
                ),
              ),
              Text("₦$security")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: ListTile(
                  title: Text('Service Charge'),
                ),
              ),
              Text("₦$service")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: ListTile(
                  title: Text('Total Package'),
                ),
              ),
              Text("₦$total")
            ],
          ),
        ],
      ),
    );
  }
}
