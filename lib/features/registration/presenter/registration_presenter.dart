import 'package:rxdart/rxdart.dart';
import 'package:testockmbl/base/base_events.dart';
import 'package:testockmbl/features/registration/model/registration_models.dart';
import 'package:testockmbl/features/registration/repository/registration_repo.dart';

class RegistrationScreenPresenter {
  RegistrationRepository registrationRepo;

  BaseBehaviorBloc<UseCaseEvent<LoginModel>> _loginEventBloc;
  BaseBehaviorBloc<UseCaseEvent<RegisterModel>> _registerEventBloc;

  Stream<UseCaseEvent<LoginModel>> get loginEventStream =>
      _loginEventBloc.getStream();

  Stream<UseCaseEvent<RegisterModel>> get registerEventStream =>
      _registerEventBloc.getStream();

  RegistrationScreenPresenter() {
    this.registrationRepo = RegistrationRepository();
    _loginEventBloc = BaseBehaviorBloc();
    _registerEventBloc = BaseBehaviorBloc();
  }

  void performLogin(String email, String password) async {
    _loginEventBloc.updateState(
        UseCaseEvent(null, UseCaseStatus.LOADING, "Verifying user..."));
    try {
      registrationRepo.login(email, password).then((loginResponse) {
        registrationRepo.saveLoginInfo(loginResponse).then((result) {
          _loginEventBloc.updateState(
              UseCaseEvent(loginResponse, UseCaseStatus.SUCCESS, ""));
        });
      });
    } catch (e) {
      _loginEventBloc
          .updateState(UseCaseEvent(null, UseCaseStatus.FAILED, e.toString()));
    }
  }

  void performRegister(String email, String password, String username) async {
    _registerEventBloc.updateState(
        UseCaseEvent(null, UseCaseStatus.LOADING, "Registering user..."));
    try {
           registrationRepo.register(email, password, username).then((registerResponse){
             _registerEventBloc.updateState(UseCaseEvent(
                 registerResponse, UseCaseStatus.SUCCESS, "Please login to continue"));
           });

    } catch (e) {
      print(e.runtimeType);
      _registerEventBloc
          .updateState(UseCaseEvent(null, UseCaseStatus.FAILED, e.toString()));
    }
  }
}
