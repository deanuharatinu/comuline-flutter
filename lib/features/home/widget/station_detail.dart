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
    final timeEstimated = destinationDetail.timeEstimated;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: destinationDetail.color.hexToColor,
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
                        Text(
                          DateTimeUtils.parseToDateFormat(
                            date: timeEstimated[0],
                            dateFormat: 'HH:mm',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getReadableTimeDiff(timeEstimated[0]),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (timeEstimated.elementAtOrNull(1) != null)
                        NextSchedule(timeEstimated[1]),
                      if (timeEstimated.elementAtOrNull(2) != null)
                        NextSchedule(timeEstimated[2]),
                      if (timeEstimated.elementAtOrNull(3) != null)
                        NextSchedule(timeEstimated[3]),
                      if (timeEstimated.elementAtOrNull(4) != null)
                        NextSchedule(timeEstimated[4]),
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
  const NextSchedule(
    this.timeEstimated, {
    super.key,
  });

  final String timeEstimated;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateTimeUtils.parseToDateFormat(
            date: timeEstimated,
            dateFormat: 'HH:mm',
          ),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _getReadableTimeDiff(timeEstimated),
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

String _getReadableTimeDiff(String timeDiff) {
  final diff = DateTimeUtils.getTimeDiffFromNow(
    dateTime: timeDiff,
  );

  if (diff.inHours >= 1) {
    return 'dalam ${diff.inHours} jam';
  } else if (diff.inMinutes > 0) {
    return 'dalam ${diff.inMinutes} menit';
  } else {
    return 'dalam 1 menit';
  }
}
