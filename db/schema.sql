-- schema.sql

-- 1. 역
CREATE TABLE IF NOT EXISTS Stations (
    station_id INTEGER PRIMARY KEY AUTOINCREMENT,
    station_name_kr TEXT NOT NULL
);

-- 2. 호선
CREATE TABLE IF NOT EXISTS Lines (
    line_id INTEGER PRIMARY KEY AUTOINCREMENT,
    line_name TEXT NOT NULL UNIQUE,
    operator TEXT,
    color_hex TEXT
);

-- 3. 노선별 역 매핑
CREATE TABLE IF NOT EXISTS Station_Routes (
    route_id INTEGER PRIMARY KEY AUTOINCREMENT,
    station_id INTEGER NOT NULL,
    line_id INTEGER NOT NULL,
    station_code TEXT NOT NULL UNIQUE,
    road_address TEXT,
    admin_dong_code TEXT,
    admin_dong_name TEXT,
    lat REAL,
    lon REAL,
    FOREIGN KEY (station_id) REFERENCES Stations(station_id) ON DELETE CASCADE,
    FOREIGN KEY (line_id) REFERENCES Lines(line_id) ON DELETE CASCADE,
    UNIQUE(line_id, station_id, station_code)
);

--- 4. 역별 혼잡도
CREATE TABLE IF NOT EXISTS Station_Congestion (
    congestion_id INTEGER PRIMARY KEY AUTOINCREMENT,
    quarter_code TEXT NOT NULL,
    station_code TEXT NOT NULL,
    day_of_week INTEGER NOT NULL, -- 0: 평일, 1: 토요일, 2: 일요일
    is_upline INTEGER NOT NULL,
    time_slot INTEGER NOT NULL, -- 05:30 = 1, 06:00 = 2, ...
    congestion_level REAL NOT NULL,
    FOREIGN KEY (station_code) REFERENCES Station_Routes(station_code) ON DELETE CASCADE,
    UNIQUE(station_code, quarter_code, day_of_week, is_upline, time_slot)
);

-- 5. 행정동별 직장인구
CREATE TABLE IF NOT EXISTS Dong_Workplace_Population (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quarter_code TEXT NOT NULL,
    admin_dong_code TEXT NOT NULL,
    admin_dong_name TEXT NOT NULL,
    total_pop INTEGER,
    male_pop INTEGER,
    female_pop INTEGER,
    age_10_pop INTEGER,
    age_20_pop INTEGER,
    age_30_pop INTEGER,
    age_40_pop INTEGER,
    age_50_pop INTEGER,
    age_60_over_pop INTEGER,
    male_age_10_pop INTEGER,
    male_age_20_pop INTEGER,
    male_age_30_pop INTEGER,
    male_age_40_pop INTEGER,
    male_age_50_pop INTEGER,
    male_age_60_over_pop INTEGER,
    female_age_10_pop INTEGER,
    female_age_20_pop INTEGER,
    female_age_30_pop INTEGER,
    female_age_40_pop INTEGER,
    female_age_50_pop INTEGER,
    female_age_60_over_pop INTEGER,
    UNIQUE(quarter_code, admin_dong_code)
);

-- 6. 행정동별 유동인구
CREATE TABLE IF NOT EXISTS Dong_Floating_Population (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quarter_code TEXT NOT NULL,
    admin_dong_code TEXT NOT NULL,
    admin_dong_name TEXT NOT NULL,
    total_floating_pop INTEGER, -- 총 유동인구 수
    male_floating_pop INTEGER, -- 남성 유동인구 수
    female_floating_pop INTEGER, -- 여성 유동인구 수
    age_10_floating_pop INTEGER, -- 연령대 10대 유동인구 수
    age_20_floating_pop INTEGER, -- 연령대 20대 유동인구 수
    age_30_floating_pop INTEGER, -- 연령대 30대 유동인구 수
    age_40_floating_pop INTEGER, -- 연령대 40대 유동인구 수
    age_50_floating_pop INTEGER, -- 연령대 50대 유동인구 수
    age_60_over_floating_pop INTEGER, -- 연령대 60대 이상 유동인구 수
    time_00_06_floating_pop INTEGER, -- 00시 ~ 06시 유동인구 수
    time_06_11_floating_pop INTEGER, -- 06시 ~ 11시 유동인구 수
    time_11_14_floating_pop INTEGER, -- 11시 ~ 14시 유동인구 수
    time_14_17_floating_pop INTEGER, -- 14시 ~ 17시 유동인구 수
    time_17_21_floating_pop INTEGER, -- 17시 ~ 21시 유동인구 수
    time_21_24_floating_pop INTEGER, -- 21시 ~ 24시 유동인구 수
    mon_floating_pop INTEGER, -- 월요일 유동인구 수
    tue_floating_pop INTEGER, -- 화요일 유동인구 수
    wed_floating_pop INTEGER, -- 수요일 유동인구 수
    thu_floating_pop INTEGER, -- 목요일 유동인구 수
    fri_floating_pop INTEGER, -- 금요일 유동인구 수
    sat_floating_pop INTEGER, -- 토요일 유동인구 수
    sun_floating_pop INTEGER, -- 일요일 유동인구 수
    UNIQUE(quarter_code, admin_dong_code)
);

-- 7. 행정동별 추정매출
CREATE TABLE IF NOT EXISTS Dong_Estimated_Revenue (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quarter_code TEXT NOT NULL,
    admin_dong_code TEXT NOT NULL,
    admin_dong_name TEXT NOT NULL,
    service_type_code TEXT NOT NULL,
    service_type_name TEXT NOT NULL,
    month_sales_amt REAL,
    month_sales_cnt INTEGER,
    weekday_sales_amt REAL,
    weekend_sales_amt REAL,
    mon_sales_amt REAL,
    tue_sales_amt REAL,
    wed_sales_amt REAL,
    thu_sales_amt REAL,
    fri_sales_amt REAL,
    sat_sales_amt REAL,
    sun_sales_amt REAL,
    time_00_06_sales_amt REAL,
    time_06_11_sales_amt REAL,
    time_11_14_sales_amt REAL,
    time_14_17_sales_amt REAL,
    time_17_21_sales_amt REAL,
    time_21_24_sales_amt REAL,
    male_sales_amt REAL,
    female_sales_amt REAL,
    age_10_sales_amt REAL,
    age_20_sales_amt REAL,
    age_30_sales_amt REAL,
    age_40_sales_amt REAL,
    age_50_sales_amt REAL,
    age_60_over_sales_amt REAL,
    weekday_sales_cnt INTEGER,
    weekend_sales_cnt INTEGER,
    mon_sales_cnt INTEGER,
    tue_sales_cnt INTEGER,
    wed_sales_cnt INTEGER,
    thu_sales_cnt INTEGER,
    fri_sales_cnt INTEGER,
    sat_sales_cnt INTEGER,
    sun_sales_cnt INTEGER,
    time_00_06_sales_cnt INTEGER,
    time_06_11_sales_cnt INTEGER,
    time_11_14_sales_cnt INTEGER,
    time_14_17_sales_cnt INTEGER,
    time_17_21_sales_cnt INTEGER,
    time_21_24_sales_cnt INTEGER,
    male_sales_cnt INTEGER,
    female_sales_cnt INTEGER,
    age_10_sales_cnt INTEGER,
    age_20_sales_cnt INTEGER,
    age_30_sales_cnt INTEGER,
    age_40_sales_cnt INTEGER,
    age_50_sales_cnt INTEGER,
    age_60_over_sales_cnt INTEGER,
    UNIQUE(quarter_code, admin_dong_code, service_type_code)
);

-- 8. 행정동별 생활인구
CREATE TABLE IF NOT EXISTS Dong_Living_Population (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    base_date TEXT NOT NULL, -- 기준일ID (YYYYMMDD)
    time_slot TEXT NOT NULL, -- 시간대구분 (HH)
    admin_dong_code TEXT NOT NULL, -- 행정동코드
    
    -- Local People (Korean)
    local_total_living_pop REAL, -- 총생활인구수
    local_male_age_0_9_pop REAL,   -- 남자0세부터9세생활인구수
    local_male_age_10_14_pop REAL, -- 남자10세부터14세생활인구수
    local_male_age_15_19_pop REAL, -- 남자15세부터19세생활인구수
    local_male_age_20_24_pop REAL, -- 남자20세부터24세생활인구수
    local_male_age_25_29_pop REAL, -- 남자25세부터29세생활인구수
    local_male_age_30_34_pop REAL, -- 남자30세부터34세생활인구수
    local_male_age_35_39_pop REAL, -- 남자35세부터39세생활인구수
    local_male_age_40_44_pop REAL, -- 남자40세부터44세생활인구수
    local_male_age_45_49_pop REAL, -- 남자45세부터49세생활인구수
    local_male_age_50_54_pop REAL, -- 남자50세부터54세생활인구수
    local_male_age_55_59_pop REAL, -- 남자55세부터59세생활인구수
    local_male_age_60_64_pop REAL, -- 남자60세부터64세생활인구수
    local_male_age_65_69_pop REAL, -- 남자65세부터69세생활인구수
    local_male_age_70_over_pop REAL, -- 남자70세이상생활인구수
    
    local_female_age_0_9_pop REAL,   -- 여자0세부터9세생활인구수
    local_female_age_10_14_pop REAL, -- 여자10세부터14세생활인구수
    local_female_age_15_19_pop REAL, -- 여자15세부터19세생활인구수
    local_female_age_20_24_pop REAL, -- 여자20세부터24세생활인구수
    local_female_age_25_29_pop REAL, -- 여자25세부터29세생활인구수
    local_female_age_30_34_pop REAL, -- 여자30세부터34세생활인구수
    local_female_age_35_39_pop REAL, -- 여자35세부터39세생활인구수
    local_female_age_40_44_pop REAL, -- 여자40세부터44세생활인구수
    local_female_age_45_49_pop REAL, -- 여자45세부터49세생활인구수
    local_female_age_50_54_pop REAL, -- 여자50세부터54세생활인구수
    local_female_age_55_59_pop REAL, -- 여자55세부터59세생활인구수
    local_female_age_60_64_pop REAL, -- 여자60세부터64세생활인구수
    local_female_age_65_69_pop REAL, -- 여자65세부터69세생활인구수
    local_female_age_70_over_pop REAL, -- 여자70세이상생활인구수

    -- Foreigner (Long Term)
    long_term_chinese_stay_pop REAL, -- 장기 + 중국인체류인구수
    long_term_non_chinese_stay_pop REAL, -- 장기 + 중국외외국인체류인구수
    
    -- Foreigner (Short Term)
    short_term_chinese_stay_pop REAL, -- 단기 + 중국인체류인구수
    short_term_non_chinese_stay_pop REAL, -- 단기 + 중국외외국인체류인구수
    
    UNIQUE(base_date, time_slot, admin_dong_code)
);

-- 9. 열차운행시각표
CREATE TABLE IF NOT EXISTS Subway_Timetable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source_id INTEGER, -- 고유번호
    line_id INTEGER NOT NULL, -- 호선ID
    station_code TEXT NOT NULL, -- 역사코드
    station_name TEXT NOT NULL, -- 역사명
    day_type TEXT NOT NULL, -- 주중주말 (DAY, SAT, END)
    direction TEXT NOT NULL, -- 방향 (UP, DOWN, IN, OUT)
    is_express INTEGER NOT NULL, -- 급행여부 (0, 1)
    train_number TEXT NOT NULL, -- 열차코드
    arrival_time TEXT, -- 열차도착시간 (HH:MM:SS)
    departure_time TEXT, -- 열차출발시간 (HH:MM:SS)
    origin_station TEXT, -- 출발역
    destination_station TEXT, -- 도착역
    FOREIGN KEY (station_code) REFERENCES Station_Routes(station_code) ON DELETE CASCADE,
    FOREIGN KEY (line_id) REFERENCES Lines(line_id) ON DELETE CASCADE,
    UNIQUE(line_id, station_code, day_type, direction, train_number)
);

-- 10. 역별 일별 승하차 인원
CREATE TABLE IF NOT EXISTS Station_Daily_Passengers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usage_date TEXT NOT NULL, -- 사용일자 (YYYYMMDD)
    line_name TEXT NOT NULL, -- 노선명
    station_name TEXT NOT NULL, -- 역명
    boarding_count INTEGER DEFAULT 0, -- 승차총승객수
    alighting_count INTEGER DEFAULT 0, -- 하차총승객수
    registration_date TEXT, -- 등록일자
    UNIQUE(usage_date, line_name, station_name)
);

-- 11. 역세권 건물 정보
CREATE TABLE IF NOT EXISTS Station_Catchment_Buildings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    station_id INTEGER NOT NULL,
    building_name TEXT,       -- A24 (건물명)
    building_detail_name TEXT,-- A25 (상세건물명)
    usage_type TEXT,          -- A9 (주용도)
    structure_type TEXT,      -- A11 (구조)
    approval_date TEXT,       -- A13 (사용승인일)
    height REAL,              -- A16 (높이)
    floor_area REAL,          -- A18 (연면적)
    households INTEGER,       -- A26 (세대수)
    families INTEGER,         -- A27 (가구수)
    FOREIGN KEY (station_id) REFERENCES Stations(station_id) ON DELETE CASCADE
);


-- 12. 일별 기온 (최저/최고)
CREATE TABLE IF NOT EXISTS Daily_Temperature (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    base_date TEXT NOT NULL, -- YYYYMMDD
    min_temp REAL,
    max_temp REAL,
    UNIQUE(base_date)
);

-- 13. 시간대별 기상정보
CREATE TABLE IF NOT EXISTS Hourly_Weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    base_date TEXT NOT NULL, -- YYYYMMDD
    hour INTEGER NOT NULL,
    temperature REAL,
    rain_prob REAL,
    rain_type REAL,
    UNIQUE(base_date, hour)
);

-- 14. 행정동 코드 매핑
CREATE TABLE IF NOT EXISTS Admin_Dong_Mapping (
    admin_dong_code TEXT PRIMARY KEY,
    admin_dong_name TEXT NOT NULL
);

-- 15. 영향 분석 결과 (Option A)
CREATE TABLE IF NOT EXISTS Impact_Analysis_OptionA (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    base_date TEXT NOT NULL, -- 날짜 (YYYY-MM-DD)
    line_name TEXT NOT NULL, -- 호선
    station_name TEXT NOT NULL, -- 역명
    station_name_normalized TEXT, -- 역명_정규화
    day_of_week TEXT, -- 요일
    category TEXT, -- 카테고리
    boarding_count INTEGER, -- 승차
    alighting_count INTEGER, -- 하차
    total_count INTEGER, -- 승하차합계
    avg_boarding_count REAL, -- 평균_승차
    avg_alighting_count REAL, -- 평균_하차
    avg_total_count REAL, -- 평균_승하차합계
    increase_rate REAL, -- 상승률_%
    increase_status TEXT, -- 상승여부
    UNIQUE(base_date, line_name, station_name, category)
);