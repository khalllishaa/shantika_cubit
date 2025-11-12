import 'dart:io';

import 'package:dio/dio.dart';

import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shantika_cubit/model/about_us_model.dart';
import 'package:shantika_cubit/model/detail_artikel_model.dart';
import 'package:shantika_cubit/model/home_model.dart';
import 'package:shantika_cubit/model/notification_model.dart';
import 'package:shantika_cubit/model/response/chat_response.dart';
import 'package:shantika_cubit/model/response/faq_response.dart';
import 'package:shantika_cubit/model/response/privacy_policy_response.dart';
import 'package:shantika_cubit/model/response/terms_and_condition_response.dart';

import '../../config/constant.dart';
import '../../model/address_model.dart';
import '../../model/application_model.dart';
import '../../model/detail_assignment_history_model.dart';
import '../../model/equipment_support_model.dart';
import '../../model/guard_model.dart';
import '../../model/promo_model.dart';
import '../../model/request/transaction_request.dart';
import '../../model/response/api_response.dart';
import '../../model/response/article_detail_response.dart';
import '../../model/response/article_response.dart';
import '../../model/response/auth_response.dart';
import '../../model/response/guard_response.dart';
import '../../model/response/guard_type_response.dart';
import '../../model/response/history_assignment_response.dart';
import '../../model/response/payment_method_response.dart';
import '../../model/response/promo_response.dart';
import '../../model/response/transaction_detail_response.dart';
import '../../model/response/transaction_response.dart';
import '../../model/slider_model.dart';
import '../../model/users_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseApi, parser: Parser.JsonSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/customer/registration")
  @MultiPart()
  Future<HttpResponse<AuthResponse>> registerr({
    @Part() required String name,
    @Part() required String email,
    @Part() required String phone,
    @Part() File? avatar,
    @Part() required String birth,
    @Part() required String birth_place,
    @Part() required String gender,
    @Part() String? uuid,
  });

  @POST("/customer/login/phone")
  @FormUrlEncoded()
  Future<HttpResponse<AuthResponse>> loginByPhone({
    @Field("phone") required String phone,
  });

  // @POST("/customer/registration")
  // @MultiPart()
  // Future<HttpResponse<AuthResponse>> registerr({
  //   @Part() required String name,
  //   @Part() required String email,
  //   @Part() required String phone,
  //   @Part() File? avatar,
  //   @Part() required String birth,
  //   @Part() required String birth_place,
  //   @Part() required String gender,
  //   @Part() String? uuid,
  // });
  //
  // @POST("/customer/login/phone")
  // Future<HttpResponse<dynamic>> loginByPhone({
  //   @Part() required String phone,
  // });

  /// Chat
  @GET("/customer/chats")
  Future<HttpResponse<ChatResponse>> getChats();

  /// Register with email and password
  @POST("/auth/register")
  Future<HttpResponse<ApiResponse<AuthResponse>>> register({
    @Part() required String first_name,
    @Part() String? last_name,
    @Part() required String email,
    @Part() String? password,
    @Part(name: "confirm_password") String? confirmPassword,
    @Part(name: "firebase_uid") String? firebaseUid,
    @Part(name: "apple_id") String? appleId,
  });

  @POST("/auth/register/google-apple")
  Future<HttpResponse<ApiResponse<AuthResponse>>> registerWithGoogleOrApple({
    @Part() required String first_name,
    @Part() String? last_name,
    @Part() required String email,
    @Part(name: "firebase_uid") String? firebaseUid,
    @Part(name: "apple_id") String? appleId,
    @Part() String? fcm_token,
  });

  /// Login With Email & Password
  @POST("/auth/login/email")
  Future<HttpResponse<ApiResponse<AuthResponse>>> login({
    @Part() required String email,
    @Part() required String password,
    @Part() String? firebase_uid,
    @Part() String? fcmToken,
  });

  /// Login With Google
  @POST("/auth/login/google")
  Future<HttpResponse<ApiResponse<AuthResponse>>> loginGoogle({
    @Part() required String email,
    @Part() required String firebase_uid,
    @Part() String? fcmToken,
  });

  /// Login With Apple
  @POST("/auth/login/apple")
  Future<HttpResponse<ApiResponse<AuthResponse>>> loginApple({
    @Part() required String apple_id,
    @Part() String? firebase_uid,
    @Part() String? fcmToken,
  });

  /// Update Fcm Token
  @POST("/update-fcm-token")
  Future<HttpResponse<ApiResponse>> updateFcmToken({
    @Part() required String fcm_token,
  });

  /// FAQ
  @GET("/faq")
  Future<HttpResponse<FAQResponse>> faq();

  /// About Us
  @GET("/about_us")
  Future<HttpResponse<AboutUsModel>> about();

  /// Terms and Contions
  @GET("/term_and_condition")
  Future<HttpResponse<TermsConditionsResponse>> termConditions();

  // Privacy Policy
  @GET("/privacy_policy")
  Future<HttpResponse<PrivacyPolicyResponse>> privacyPolicy();

  // Contact Us
  @POST("/information/contact-us")
  Future<HttpResponse<ApiResponse>> contactUs({
    @Part() required String name,
    @Part() required String email,
    @Part() required String company,
    @Part() required String message,
  });

  /// Logout
  @POST("/logout")
  Future<HttpResponse<ApiResponse>> logout();

  /// Request Reset Password
  @POST("/auth/reset-password")
  Future<HttpResponse<ApiResponse>> sendResetTokenEmail({
    @Part() required String email,
  });

  /// Validation Token Reset Password
  @POST("/auth/reset-password/token")
  Future<HttpResponse<ApiResponse>> validateResetToken({
    @Part() required String email,
    @Part() required String token,
  });

  /// Change Password
  @POST("/auth/reset-password/change")
  Future<HttpResponse<ApiResponse>> changePassword({
    @Part() required String email,
    @Part() required String password,
    @Part() required String confirm_password,
  });

  @GET("/customer/membership")
  Future<HttpResponse<ApiResponse<UsersModel>>> profile();

  /// Update Profile
  @POST("/customer/update")
  @MultiPart()
  Future<HttpResponse<ApiResponse<UsersModel>>> updateProfile({
    @Part() required String name,
    @Part() required String email,
    @Part() required String phone,
    @Part() File? avatar,
    @Part() required String birth,
    @Part() required String birth_place,
    @Part() required String address,
    @Part() required String gender,
    @Part() String? uuid,
  });

  /// Update Profile
  // @POST("/profile/update")
  // @MultiPart()
  // Future<HttpResponse<ApiResponse<UserModel>>> updateProfile({
  //   @Part() List<MultipartFile>? avatar,
  //   @Part() required String first_name,
  //   @Part() String? last_name,
  //   @Part() String? birth_date,
  //   @Part() required String gender,
  //   @Part() String? phone,
  //   @Part() required String email,
  // });

  /// Home
  @POST("/customer/home")
  Future<HttpResponse<HomeModel>> home();

  /// Get Article Detail
  @GET("/article_detail/{id}")
  Future<HttpResponse<DetailArtikelModel>> getArticleDetail(
  @Path("id") int id);

  /// Detail Slug
  @GET("/home/slider/{slug}")
  Future<HttpResponse<ApiResponse<SliderModel>>> detailSlider({
    @Path("slug") required String slug,
  });

  /// Article
  @GET("/article")
  Future<HttpResponse<ApiResponse<ArticleResponse>>> article({
    @Query("sort_by") String? sortBy,
    @Query("article_category_id") String? categoryId,
  });

  /// Article Detail
  @GET("/article/{slug}")
  Future<HttpResponse<ApiResponse<ArticleDetailResponse>>> detailArticle({
    @Path("slug") required String slug,
  });

  /// Memberi Laiks
  @POST("/article/{slug}/review")
  Future<HttpResponse<ApiResponse>> giveLike({
    @Path("slug") required String slug,
    @Part(name: "is_like") required bool isLike,
  });

  /// PROMO
  @GET("/promo")
  Future<HttpResponse<ApiResponse<PromoResponse>>> promo({
    @Query("code") String? code,
  });

  /// DETAIL PROMO
  @GET("/promo/{id}")
  Future<HttpResponse<ApiResponse<PromoModel>>> detailPromo({
    @Path() required String id,
  });

  /// CLAIM PROMO
  @POST("/promo/{code_promo}/claim")
  Future<HttpResponse<ApiResponse>> claimPromo({
    @Path() required String code_promo,
  });

  /// LIST GUARD
  @GET("/guard-types/guard")
  Future<HttpResponse<ApiResponse<GuardResponse>>> guards({
    @Query("guard_class_id") String? guardClassId,
    @Query("sort_by[]") List<String>? sortBy,
  });

  /// DETAIL GUARD
  @GET("/guard-types/guard/{guard_id}")
  Future<HttpResponse<ApiResponse<GuardResponse>>> detailGuard({
    @Path("guard_id") required String guardId,
  });

  /// FAVORITE GUARD
  @POST("/guard-types/guard/{guard_id}/favorite")
  Future<HttpResponse<ApiResponse>> favorite({
    @Path("guard_id") required String guardId,
    @Part(name: "is_favorite") required String isFavorite,
  });

  /// LIST TYPE GUARD
  @GET("/guard-types/{guard_type_id}")
  Future<HttpResponse<ApiResponse<GuardTypeResponse>>> guardTypeById({
    @Path("guard_type_id") required String guardTypeId,
  });

  /// GUARD RECOMENDATION
  @GET("/guard-types/guard/recommendation")
  Future<HttpResponse<ApiResponse<GuardModel>>> guardRecomendation({
    @Query("guard_class_id") String? guardClassId,
    @Query("start_time") required String startTime,
    @Query("end_time") required String endTime,
  });

  /// ADDRESS
  @GET("/profile/address")
  Future<HttpResponse<ApiResponse<List<AddressModel>>>> address();

  /// UPDATE ADDRESS
  @POST("/profile/address/create-update")
  Future<HttpResponse<ApiResponse>> createUpdateAddress({
    @Part(name: "id") String? id, // use id if you want to edit
    @Part(name: "name") required String name,
    @Part(name: "phone") required String phone,
    @Part(name: "address") required String address,
    @Part(name: "note") String? note,
    @Part(name: "is_main_address") required bool isMainAddress,
    @Part(name: "latitude") required String latitude,
    @Part(name: "longitude") required String longitude,
  });

  /// UPDATE LATITUDE & LONGITUDE
  @POST("/profile/update/latlong")
  Future<HttpResponse<ApiResponse>> updateLatLong({
    @Part(name: "latitude") required String latitude,
    @Part(name: "longitude") required String longitude,
  });

  /// DELETE ADDRESS
  @DELETE("/profile/address/{address_id}")
  Future<HttpResponse<ApiResponse>> deleteAddress({
    @Path("address_id") required String id,
  });

  /// PAYMENT METHOD
  @GET("/payment_method")
  Future<HttpResponse<ApiResponse<PaymentMethodResponse>>> paymentMethods();

  /// TRX
  @POST("/transaction")
  Future<HttpResponse<ApiResponse>> createTransaction({
    @Body() required TransactionRequest request,
  });

  /// UPDATE TRX
  @PUT("/transaction/{transaction_id}")
  Future<HttpResponse<ApiResponse>> updateTransaction({
    @Body() required TransactionRequest request,
    @Path("transaction_id") required String id,
  });

  /// CANCEL TRX
  @PUT("/transaction/{transaction_id}/cancel")
  Future<HttpResponse<ApiResponse>> cancelTransaction({
    @Path("transaction_id") required String id,
  });

  /// POST TO SOCKET TRANSACTION
  @POST("/transaction/{transaction_id}/socket")
  Future<HttpResponse<ApiResponse>> socketTransaction({
    @Path("transaction_id") required String id,
    @Part(name: "payment_code") required String paymentCode,
  });

  /// HISTORY TRX
  @GET("/transaction")
  Future<HttpResponse<ApiResponse<TransactionResponse>>> transaction({
    @Query("status") String? status,
  });

  /// DETAIL HISTORY TRX
  @GET("/transaction/{transaction_id}")
  Future<HttpResponse<ApiResponse<TransactionDetailResponse>>> detailTransaction({
    @Path("transaction_id") required String id,
  });

  /// PROMO CHECK
  @POST("/promo/check")
  Future<HttpResponse<ApiResponse>> checkPromo({
    @Body() required TransactionRequest request,
  });

  /// GUARD CHECK AVAILABILITY
  @POST("/guard-types/guard/check-availability")
  Future<HttpResponse<ApiResponse>> checkGuardAvailability({
    @Body() required TransactionRequest request,
  });

  /// INFORMATION APPLICATION
  @GET("/information/application")
  Future<HttpResponse<ApiResponse<ApplicationModel>>> informationApplication();

  /// EQUIPMENT SUPPORT
  @GET("/guard-types/guard/security-equipment")
  Future<HttpResponse<ApiResponse<List<EquipmentSupportModel>>>> equipmentSupports();

  /// HISTORY ASSIGNMENT
  @GET("/guard-histories")
  Future<HttpResponse<ApiResponse<HistoryAssignmentResponse>>> historyAssignment({
    @Query("status") String? status,
  });

  /// HISTORY DETAIL ASSIGNMENT
  @GET("/guard-histories/{guard_history_id}")
  Future<HttpResponse<ApiResponse<DetailAssignmentHistoryModel>>> detailHistoryAssignment({
    @Path("guard_history_id") required String id,
  });

  /// GUARD COMPLAINT
  @POST("/guard-histories/{guard_history_id}/complain")
  Future<HttpResponse<ApiResponse>> complaintGuard({
    @Path("guard_history_id") required String id,
    @Part(name: "complain") required String complain,
  });

  /// ASSIGNMENT REVIEW
  @POST("/guard-histories/{guard_history_id}/review")
  @MultiPart()
  Future<HttpResponse<ApiResponse>> reviewAssignment({
    @Path("guard_history_id") required String id,
    @Part() List<MultipartFile>? attachment,
    @Part(name: "star") required String star,
    @Part(name: "review") required String review,
  });

  /// UPDATE REVIEW
  @POST("/guard-histories/{guard_history_id}/review/update")
  @MultiPart()
  Future<HttpResponse<ApiResponse>> updateReviewAssignment({
    @Path("guard_history_id") required String id,
    @Part() List<MultipartFile>? attachment,
    @Part(name: "star") required String star,
    @Part(name: "review") required String review,
  });

  /// NOTIFICATION
  @GET("/notification")
  Future<HttpResponse<NotificationModel>> notifications({
    @Query('page') required int page,
  });

  @POST("/notification/read")
  Future<HttpResponse<ApiResponse>> readNotification({
    @Path('id') required String id,
  });

  @POST('/notification/read/all')
  Future<HttpResponse<ApiResponse>> readAllNotification();

  // @GET("/notification")
  // Future<HttpResponse<ApiResponse<NotificationsResponse>>> notifications({
  //   @Query("page") required int page,
  // });
  //
  // /// NOTIFICATION READ
  // @POST("/notification/see")
  // Future<HttpResponse<ApiResponse>> readNotification({
  //   @Part(name: "notification_id") required String id,
  // });
  //
  // /// NOTIFICATION READ ALL
  // @POST("/notification/see-all")
  // Future<HttpResponse<ApiResponse>> readAllNotification();
}
