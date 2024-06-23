import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingDto {
  AccountDto? authorId;
  int? status;
  double? price;
  String? bookingType;
  String? time;
  String? content;
  double? startPointLat;
  double? startPointLong;
  String? startPointId;
  String? startPointMainText;
  String? startPointAddress;
  double? endPointLat;
  double? endPointLong;
  String? endPointId;
  String? endPointMainText;
  String? endPointAddress;
  String? distance;
  String? duration;
  int? point;
  List<String>? userFavorites;
  List<String>? userMayFavorites;
  int? applyNum;
  int? watchedNum;
  int? savedNum;
  double? diftAtribute;
  bool? isNew;
  double? interesestValue;
  double? interesestConfidenceValue;
  bool? isReal;
  bool? isCaseBased;
  bool? isFavorite;
  bool? isMayFavorite;
  String? createdAt;
  String? updatedAt;
  String? id;
  BookingDto(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.authorId,
      this.status,
      this.price,
      this.bookingType,
      this.time,
      this.content,
      this.startPointLat,
      this.startPointLong,
      this.startPointId,
      this.startPointMainText,
      this.startPointAddress,
      this.endPointLat,
      this.endPointLong,
      this.endPointId,
      this.endPointMainText,
      this.endPointAddress,
      this.distance,
      this.duration,
      this.point,
      this.userFavorites,
      this.userMayFavorites,
      this.applyNum,
      this.watchedNum,
      this.savedNum,
      this.diftAtribute,
      this.isNew,
      this.interesestValue,
      this.interesestConfidenceValue,
      this.isReal,
      this.isCaseBased,
      this.isFavorite,
      this.isMayFavorite});

  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingDtoToJson(this);

  static List<BookingDto> bookingsFake = [
    BookingDto(
      id: "6617e06b6298eeb22b545113",
      authorId: AccountDto(
        id: "6617d90a01bacb54336f1c2b",
        firstName: "Selena Wann",
        email: "swannb8@tinypic.com",
        password:
            "\$2a\$10\$N.m2ha/oQu9amhZ8su3hyeOp9gZuGayRB2alifIU8Vaw4y3FxnAxi",
        avatarUrl:
            "https://robohash.org/quivoluptatesaccusantium.png?size=50x50&set=set1",
        phoneNumber: "(366) 6261829",
        online: false,
        gender: "female",
        role: "user",
        priorityPoint: 100,
        createdAt: "2024-04-11T12:35:22.751Z",
        updatedAt: "2024-04-11T12:35:22.751Z",
      ),
      status: 2,
      price: 70047,
      bookingType: "Tìm tài xế",
      time: "2024-02-02T05:24:58.608Z",
      startPointLat: 10.7801,
      startPointLong: 106.6913,
      startPointMainText: "Đại học Kinh tế Thành phố Hồ Chí Minh",
      startPointAddress:
          "59C Nguyễn Đình Chiểu, Quận 3, Thành phố Hồ Chí Minh, Việt Nam",
      endPointLat: 10.873305,
      endPointLong: 106.807471,
      endPointMainText: "Trường Đại học An ninh nhân dân",
      endPointAddress:
          "Km18 Xa Lộ Hà Nội, Phường Linh Trung, Thủ Đức, Thành phố Hồ Chí Minh",
      distance: "16.38256180959842",
      userFavorites: ["6605b1e6a20c4cd40793491f"],
      applyNum: 17,
      watchedNum: 43,
      savedNum: 24,
      diftAtribute: 1,
      interesestValue: 0,
      interesestConfidenceValue: 1.1686131886159186,
      createdAt: "2024-04-11T13:06:59.204Z",
      updatedAt: "2024-04-14T07:52:31.514Z",
      isFavorite: true,
      isMayFavorite: false,
    ),
    BookingDto(
      id: "6617e06b6298eeb22b5450e3",
      authorId: AccountDto(
        id: "6617d90a01bacb54336f1d4e",
        firstName: "Leon Brosetti",
        email: "lbrosettijb@rediff.com",
        password:
            "\$2a\$10\$N.m2ha/oQu9amhZ8su3hyeOp9gZuGayRB2alifIU8Vaw4y3FxnAxi",
        avatarUrl:
            "https://robohash.org/molestiasvelitvoluptatem.png?size=50x50&set=set1",
        phoneNumber: "(691) 4167548",
        online: false,
        gender: "male",
        role: "user",
        priorityPoint: 100,
        createdAt: "2024-04-11T12:35:22.762Z",
        updatedAt: "2024-04-11T12:35:22.762Z",
      ),
      status: 2,
      price: 120112,
      bookingType: "Tìm tài xế",
      time: "2024-01-29T00:52:52.159Z",
      startPointLat: 10.9383,
      startPointLong: 106.824,
      startPointMainText: "Trường Đại học Công nghiệp TP.HCM",
      startPointAddress:
          "12 Nguyễn Văn Bảo, Phường 04, Quận Gò Vấp, Thành phố Hồ Chí Minh, Việt Nam",
      endPointLat: 10.8063056,
      endPointLong: 106.6286111,
      endPointMainText: "Trường Đại học Công Thương TP.HCM",
      endPointAddress:
          "140 Lê Trọng Tấn, phường Tây Thạnh, quận Tân Phú, Thành phố Hồ Chí Minh,  Việt Nam",
      distance: "25.896980410993926",
      userFavorites: ["6605b1e6a20c4cd40793491f"],
      applyNum: 8,
      watchedNum: 14,
      savedNum: 3,
      diftAtribute: 1,
      interesestValue: 0,
      interesestConfidenceValue: 1.098005485175443,
      createdAt: "2024-04-11T13:06:58.156Z",
      updatedAt: "2024-04-14T07:52:42.638Z",
      isFavorite: true,
      isMayFavorite: false,
    ),
    // Add more BookingDto objects here...
  ];
}
