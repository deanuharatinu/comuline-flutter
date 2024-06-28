import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/models/destination_detail.dart';
import 'package:flutter/material.dart';

class StationDetail extends StatelessWidget {
  const StationDetail({
    super.key,
    required this.destinationDetail,
  });

  final List<DestinationDetail> destinationDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              key: const PageStorageKey('value'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: destinationDetail.length,
              itemBuilder: (context, index) {
                final stationDetail = destinationDetail[index];
                return Row(
                  children: [
                    StationSchedule(destinationDetail: stationDetail),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StationSchedule extends StatelessWidget {
  const StationSchedule({
    super.key,
    required this.destinationDetail,
  });

  final DestinationDetail destinationDetail;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: hexToColor(destinationDetail.color),
              width: 3.0,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Arah menuju',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          destinationDetail.destination.capitalize,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Berangkat pukul',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const Text(
                          '17.31',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'dalam 9 menit',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jam berikutnya',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NextSchedule(),
                      NextSchedule(),
                      NextSchedule(),
                      NextSchedule(),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextSchedule extends StatelessWidget {
  const NextSchedule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '18.43',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Dalam 27 menit',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
