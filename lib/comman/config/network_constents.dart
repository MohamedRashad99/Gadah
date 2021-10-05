// ? base
const kServerUrlWithourSlach = 'http://gadha.con-point.com';
const kServerUrl = '$kServerUrlWithourSlach/';
// const kServerUrl = 'http://192.168.1.21:8000/';

// * auth routes
const kLogin = '/auth/login';
const kSignUp = '/auth/register';
const kCheckUserOTP = '/auth/checkcode';
const kUserData = '/auth/user';
const kUpdateUser = '/auth/update_user';
const kLogoutUser = '/logout';
const kDriverMetadata = '/driver/meta';

// * slider routes
const kSlider = '/sliders';

// * notifications routes
const kUserNotifications = '/notifications';

// * catigories routes
const kCategories = '/categories';

// * coupon routes
const kCoupon = '/coupon';

//* client orders
const kClientOrders = '/client/orders';

// * compaints
const kCompalints = '/complaints';

// * bank bills
const kBankBills = '/driver/bank_bills';

// * order bills
const kFindOrderById = '/orders/:id/bills';

// * media files
const kMediaFile = '/media_files';
//* old routes
const kMercureUrl = 'http://ghadhasymf.ga:3000/.well-known/mercure';
const kMapsApi = 'https://maps.googleapis.com/maps/api';
const kNewServerUrl = 'http://laravel.ghadha.ga';
const kLocationDecoder = '$kMapsApi/geocode/json';
const kSeachInNearByPlaces = '$kMapsApi/place/nearbysearch/json';
const kPlaceDetails = '$kMapsApi/place/details/json';
const kPlaceDetailsByLatLang = '$kMapsApi/geocode/json';
const kApiUrl = '$kServerUrl/api';
const kNewAppApiUrl = '$kNewServerUrl/public/api/en';
/*const kClientReview = '/user';*/

const kAppSettings = '/settings';
const kDriverConfirmation = '/driver/bank_confirmation';
const kCategorieyById = '/categories/:id';
const kSubCatigories = '/categories/:id/childrens';
const kOrderBillsPath = '/order/:id/bills';
const kCreateBill = '/orders/:id/new_bill';

// const kFinishOrderById = '/client/orders/:id/take_order';
const kFinishOrderById = '/driver/finish-order/:id';
