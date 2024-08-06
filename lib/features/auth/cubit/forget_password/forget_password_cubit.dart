import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/functions/checkinternet.dart';
import '../../data/data_source/forgetpassword_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo _forgetPasswordRepo;

  ForgetPasswordCubit(this._forgetPasswordRepo)
      : super(ForgetPasswordInitial());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  void sendPhone(String phone) async {
    if (await checkInternet()) {
      emit(ForgetPasswordLoadingState());
      final result = await _forgetPasswordRepo
          .sendForgetPasswordVerificationCodeToPhone(phone);
      result.fold((l) => emit(ForgetPasswordErrorState(message: l)),
          (r) => emit(ForgetPasswordSuccessState()));
    } else {
      emit(const ForgetPasswordErrorState(message: "لا يوجد اتصال بالانترنت"));
    }
  }

  void reSendForgetPasswordVerificationCodeToPhone(String phone) async {
    emit(ReSendForgetPasswordVerificationCodeToEmailLoadingState());
    final result = await _forgetPasswordRepo
        .reSendForgetPasswordVerificationCodeToPhone(phone);
    result.fold(
      (l) => emit(
          ReSendForgetPasswordVerificationCodeToPhoneErrorState(message: l)),
      (r) => emit(ReSendForgetPasswordVerificationCodeToPhoneState(message: r)),
    );
  }

  void verifyPhoneWithCode(String phone, int code) async {
    if (await checkInternet()) {
      emit(ForgetPasswordOTPCodeLoadingState());
      final result =
          await _forgetPasswordRepo.
          verifyClientForgetPasswordCode(phone, code);
      result.fold((l) => emit(ForgetPasswordOTPErrorState(message: l)),
          (r) => emit(ForgetPasswordOTPSuccessState()));
    } else {
      emit(const ForgetPasswordOTPErrorState(
          message: "لا يوجد اتصال بالانترنت"));
    }
  }

  void newPassword(String password) async {
    if (await checkInternet()) {
      emit(NewForgetPasswordLoadingState());
      final result = await _forgetPasswordRepo.sentNewPassword(password);
      result.fold((l) => emit(NewForgetPasswordErrorState(message: l)),
          (r) => emit(NewForgetPasswordSuccessState()));
    } else {
      emit(const NewForgetPasswordErrorState(
          message: "لا يوجد اتصال بالانترنت"));
    }
  }
}
