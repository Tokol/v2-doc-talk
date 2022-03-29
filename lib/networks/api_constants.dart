// ignore_for_file: constant_identifier_names

const String BASE_URL = 'https://docktalktestingapp.herokuapp.com/';
const String SOCKET_URL = 'https://docktalktestingapp.herokuapp.com';

const String REGISTER_URL = BASE_URL + 'auth/register';
const String LOGIN_URL = BASE_URL + 'auth/login';
const String LOGOUT_URL = BASE_URL + 'auth/logout';
const String FORGOT_PASSWORD_URL = BASE_URL + '/forgot-password';
const String RESET_PASSWORD_URL = BASE_URL + '/reset-password';
const String CHANGE_PASSWORD_URL = BASE_URL + '/change-password';

const String VERIFY_OTP_URL = BASE_URL + 'auth/verify/contact/otp/';
const String RESEND_OTP_URL = BASE_URL + 'auth/user/registration/otp/resend';

const String CHANGE_USER_PROFILE_IMAGE =
    BASE_URL + 'api/users/user/change/profile-image';
const String CHANGE_USER_PROFILE_DETAIL =
    BASE_URL + 'api/users/user/change/profile/details';
//Dashboard

const String USER_LOG_OUT = BASE_URL + 'auth/logout';
const String GET_USER_DETAIL = BASE_URL + 'api/users/user/';

//forget Password

const String REQUEST_PHONE_NUMBER_FORGET_PASSWORD =
    BASE_URL + 'auth/forgot-password/generate/otp';

const String Change_PASSWORD_FROM_FORGET_REQUEST =
    BASE_URL + 'auth/forgot-password/change-password';

//change Password;
const String CHANGE_USER_PASSWORD = BASE_URL + 'api/users/user/change-password';

const String GET_USER_LIST_FROM_CONTACTS =
    BASE_URL + 'api/users/numbers/associated';

const String GET_USER_CHAT_GROUPS = BASE_URL + "api/chatgroup/filter/";

const String CREATE_GROUP_CHAT = BASE_URL + 'api/chatgroup/add';

const String GET_TOTAL_GROUP_USER = BASE_URL + 'api/chatgroup/group/members';

const String GET_MESSAGE_FROM_GROUP = BASE_URL+'api/chatgroup/group/messages?page=';

const String GET_IMAGE_PATH_FOR_CHAT_MESSAGE = BASE_URL+'api/chatgroup/image/upload';