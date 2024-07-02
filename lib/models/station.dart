import 'package:comuline/models/destination_detail.dart';
import 'package:equatable/equatable.dart';

class Station extends Equatable {
  const Station({
    required this.id,
    required this.name,
    required this.daop,
    required this.fgEnable,
    required this.haveSchedule,
    required this.updatedAt,
    this.destinationDetail,
    this.isBookmarked,
  });

  final String id;
  final String name;
  final int daop;
  final int fgEnable;
  final bool haveSchedule;
  final String updatedAt;
  final List<DestinationDetail>? destinationDetail;
  final bool? isBookmarked;

  Station copyWithdestinationDetail(
    List<DestinationDetail> destinationDetail,
  ) {
    return Station(
      id: id,
      name: name,
      daop: daop,
      fgEnable: fgEnable,
      haveSchedule: haveSchedule,
      updatedAt: updatedAt,
      destinationDetail: destinationDetail,
      isBookmarked: isBookmarked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        daop,
        fgEnable,
        haveSchedule,
        updatedAt,
        destinationDetail,
        isBookmarked,
      ];
}
