const GET_EMAIL_OTP = "account/v2/email/get-otp/";
const GET_ACCESS_TOKEN = "account/v2/email/sign-in/";

const GET_MATIC_GAS_PRICE = "account/v2/gas-config/";

const GET_AVATAR_CONFIG = "account/v2/avatar-configurator/";
const GET_DEFAULT_AVATAR_CONFIG = "account/v2/default-avatars/";
const SAVE_DEFAULT_AVATAR_CONFIG = "account/v2/default-avatars/save/";
const GET_WORKOUT_CONFIG = "gameplay/workout/get-tracker-config/";
const GET_REFERRAL_ADD_FRIENDS_LIST = "account/v2/default-friends-to-add/";
const UPLOAD_APPLE_HEALTH_DATA_URL = "gameplay/workout/apple-health-data/";

const String GET_AUDIO_CUE = "account/v2/user/preferences/";
const String PATCH_AUDIO_CUE = "account/v2/user/preferences/";

const SET_FIRST_NAME = "account/v2/user/action/0/";
const SET_REFERRAL_CODE = "account/v2/user/action/1/";
const POST_LVLUP_SEEN = "account/v2/user/action/2/";
const AVATAR_REFERRAL_SEEN = "account/v2/user/action/3/";
const RESTORE_USER_LVL = "account/v2/user/action/4/";
const LOGOUT_URL = "account/v2/user/action/5/";
const SEND_IP_DATA_URL = "account/v2/user/action/6/";
const POST_RANKING_SEEN = "account/v2/user/action/7/";
const GET_REFERRAL_ADD_FRIENDS_SAVE = "account/v2/user/action/8/";
const FORCE_CLOSE_WORKOUT = "account/v2/user/action/9/";

const GET_PERCENT_USERS = "account/v2/user/category-map/";

//api/core/support-ticket/
// const POST_SUBMIT_BUG = "core/support-ticket/";
const POST_SUBMIT_BUG = "core/send-mail/<int:action_id>/";

///api/core/file/upload/
const UPLOAD_SUBMIT_BUG_FILE = "core/file/upload/";

const GET_POST_LVL_FREEZE = "account/v2/user/level-freeze/";

//  Friends APIs
const GET_FRIENDS_LIST = "gameplay/friends/leaderboard/";
const GET_FRIEND_REQ = "gameplay/friends/pending-requests/";
const ACCEPT_FRIEND_REQ = "gameplay/friends/1/";
const SEARCH_FRIENDS = "gameplay/friends/search/";
const SEND_FRIEND_REQ = "gameplay/friends/0/";
const DELETE_FRIEND_REQ = "gameplay/friends/2/";
const CHEER_FRIEND = "gameplay/friends/4/";
const GET_FRIENDS_PROFILE = 'gameplay/friends/';
const REMOVE_FRIEND = "gameplay/friends/3/";
const MUTE_FRIEND = "gameplay/friends/6/";
const UNMUTE_FRIEND = "gameplay/friends/7/";
const ADD_ALL_MEMBERS_AS_FRIEND_FROM_CLUB = "gameplay/friends/8/";
const REMIND_FRIENDS_FROM_PROMO_FITT = "gameplay/friends/10/";
// Clubs API
const GET_CLUBS = 'gameplay/clubs/';
const GET_CLUB_PENDING_REQUEST = "gameplay/clubs/pending-requests/";
const CREATE_CLUB_URL = "gameplay/clubs/create/";
const GET_CLUB_DETAIL = "gameplay/clubs/<club_uuid>/detail/";
const GET_CLUB_MEMBER_LIST = "gameplay/clubs/<club_uuid>/members/";
const SEND_CLUB_INVITE_REQUEST = "gameplay/clubs/<club_uuid>/action/2/";
const ACCEPT_CLUB_PENDING_REQUEST = "gameplay/clubs/<club_uuid>/action/3/";
const REJECT_CLUB_PENDING_REQUEST = "gameplay/clubs/<club_uuid>/action/4/";
const CREATE_PENDING_INVITE_FOR_CLUB = "gameplay/clubs/<club_uuid>/action/5/";

// Activities API
const GET_ACTIVITIES_LIST = 'account/v2/activities/';
const GET_ANNOUNCEMENTS = 'account/v2/campaigns/';
const SEEN_ANNOUNCEMENT = 'account/v2/campaigns/<uuid>/';

// Collections APIs
const GET_USER_ASSETS = 'account/v2/user/assets/';
const GET_USER_AVATAR_CONFIG = 'account/v2/user-avatar-config/';
const GET_USER_ORIGIN_PASSES = 'account/v2/origin-pass/';
const WEAR_ASSET = 'gameplay/rewards';
const GET_MYSERYBOX = 'gameplay/rewards/mystery-boxes/';

// const SETTINGS_URL = "v1/get-user-profile/";
const GET_USER_PROFILE_URL = "account/v2/user-profile/";
const POST_USRNAME_CHECK = "account/v2/user/check-username/";
//{{local_server}}/api/core/file/upload/

const GET_APP_CONFIG_URL = "account/v2/app-config/";
const USER_BALANCES_URL = "account/v2/user/balances/";
const LOCKED_PROMO_FITT_BALANCE_URL = "account/v2/user/locked-balances/";
const WALLET_IMPORT_QUESTION_LIST_URL = "account/v2/wallet-questions/";
const WALLET_PARTS_SAVE_URL = "account/v2/mpc-wallet/";
const WALLET_HISTORY_URL = "account/v2/mpc-wallet/<wallet>/history/";
const WALLET_TXN_SAVE_URL = "account/v2/mpc-wallet/<wallet>/create-txn/";
const GET_MY_NFT_LIST_URL = "account/v2/nft/list/";

const ACCESS_TOKEN_REFRESH_URL = "v1/auth-token/refresh/";

// const CLAIM_WALLET_ADDRESS_URL = "v1/claim-wallet-address/";
const IMPORT_WALLET_ADDRESS_URL = "account/v2/user-wallet/0/";
const CREATE_WALLET_ADDRESS_URL = "account/user-wallet/1/";

const WALLET_IN_GAME_TRANSFER = "account/v2/user-wallet/2/";
const WALLET_OUT_GAME_TRANSFER = "account/v2/user-wallet/3/";

const DISCORD_CONNECT_URL = "account/v2/discord/connect/";
const DISCORD_DISCONNECT_URL = "account/v2/discord/disconnect/";

const WALLET_STATUS_URL = "v1/wallet-status/onboarding/";
const TRANSFERRED_NFT_HASH_POST_URL = "account/v2/nft/transfer-hash/verify/";

const NFT_LEVEL_UP_URL = "v1/nft/<token_id>/action/0/";
const NFT_REPAIR_URL = "v1/nft/<token_id>/action/1/";
const NFT_ADD_ATTRIBUTES_POINT_URL = "v1/nft/<token_id>/action/2/";

const APPLE_PURCHASE_STATUS_URL = "v1/apple/nft/purchase/";

const MP_SNEAKER_LIST_URL = "v1/market/listed-items/?page_size=20";
const INVENTORY_LIST_URL = "account/v2/item/list/";
const MP_SNEAKER_BUY_URL = "v1/market/item/<token_id>/";
const MP_SNEAKER_DELIST_URL = "v1/market/item/<token_id>/delist/";
const MP_SNEAKER_LIST_ON_PRICE_URL = "v1/item/list/";

const DISCARD_SNEAKER_PART_URL = "v1/nft/sneaker-part/discard/";
const CRAFT_SNEAKER_NFT_URL = "v1/nft/craft/";
const CRAFT_SNEAKER_STATUS_URL = "v1/nft/craft/status/";
const UPDATE_NFT_STATS_URL = "v1/nft/<token_id>/action/3/";

const WORKOUT_START_URL = "gameplay/workout/start/";
const WORKOUT_UPDATE_URL = "gameplay/workout/<workout_uuid>/2/";
const WORKOUT_CLOSE_URL = "gameplay/workout/<workout_uuid>/3/";
const WORKOUT_CLOSE_4_URL = "gameplay/workout/<workout_uuid>/6/";

const WORKOUT_SYNC_URL = "gameplay/workout/sync/";

const WORKOUT_SESSION_URL = "gameplay/workout/<workout_uuid>/<action_id>/";
const WORKOUT_ANALYTICS_URL =
    "gameplay/workout/analytics/<period_type>/"; //period_type = 0 for day, 1 for week, 2 for month

const WORKOUT_REWARDS_URL = "gameplay/rewards/<reward-uuid>/1/";
const WORKOUT_HISTORY_FULL_PAGE = "account/get-workout-history/";
const WORKOUT_SUMMARY_LIST_URL =
    "gameplay/workout/<workout_uuid>/get-workout-summary/";

const WORKOUT_HISTORY_PAGE = "v1/get-workout-history/";

const FITT_STAKE_BALANCE_URL = "v2/staking/balance/";
const FITT_STAKE_REWARDS_LIST_URL = "v2/staking/rewards/";
const FITT_STAKE_REWARD_CLAIM_URL = "v2/staking/rewards/";
const FITT_STAKE_REWARD_STATUS_VERIFY_URL = "v2/staking/rewards/";
const FITT_STAKE_REWARD_USE_URL = "v2/staking/rewards/";

const FITT_STAKE_TOKEN_URL = "v2/staking/stake-token/";
const FITT_STAKE_WITHDRAW_TOKEN_URL = "v2/staking/withdraw-token/";

// Challengers URL'S

const challengersUserListUrl = "gameplay/challenges/list/?type=1";
const challengersDiscoverListUrl = "gameplay/challenges/list/";
const challengeJoinUrl = "gameplay/challenges/";
const challengeJoinNotificationUrl = "gameplay/challenges/";
