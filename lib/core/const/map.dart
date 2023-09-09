// ignore_for_file: constant_identifier_names

const List<double> SEOUL_COORD = [37.5642135, 127.0016985];
const double SEOUL_COORD_LAT = 37.5642135;
const double SEOUL_COORD_LON = 127.0016985;

// 맵 출력 시 기본 줌 레벨
const double DEFAULT_ZOOM = 13;
// 바텀시트 출력과 함께 서점의 위치를 기반으로 카메라 이동 시, 마커가 바텀시트에 안가리게 위도 수정
const double LAT_FIXED = 0.02;
const double MAP_APPBAR_LONG_HEIGHT = 103;
const double MAP_APPBAR_SHORT_HEIGHT = 809;

// 마커 zIndex
const double MARKER_ZINDEX = 1;
const double BIG_MARKER_ZINDEX = 2;

const double MAP_BUTTON_HEIGHT = 18;
const double MAP_BUTTON_PADDING = 15;
// 버튼 사이의 간격
const double MAP_BUTTON_MARGIN = 8;

const double STORE_SHEET_HEIGHT = 300;
const double HIDE_RECOMMENDATION_SHEET_HEIGHT = 335;

// 지도 움직일 때 300ms 마다 지도 안에 있는 서점 검색
const int STORES_IN_MAP_INTERVAL = 500;
// 서점 검색 200ms 마다
const int STORES_SEARCH_INTERVAL = 200;

// 내 위치 3분 마다 갱신
const int LOCATION_SEARCH_INTERVAL = 3;
// 검색하고 돌아갈 때 데이터로 주면 숨은 서점 출력
const String SEARCH_WAS_EMPTY = 'search_is_empty';

// 최저 최고 줌 레벨
const double MIN_ZOOM = 6; // 우리나라 다 보고 좀 남음
const double MAX_ZOOM = 16; // 큰 건물 한 개 다 보고 좀 남음
