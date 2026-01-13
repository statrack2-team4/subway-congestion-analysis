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
    station_number TEXT NOT NULL UNIQUE,
    road_address TEXT,
    administrative_dong TEXT,
    lat REAL,
    lon REAL,
    FOREIGN KEY (station_id) REFERENCES Stations(station_id) ON DELETE CASCADE,
    FOREIGN KEY (line_id) REFERENCES Lines(line_id) ON DELETE CASCADE,
    UNIQUE(line_id, station_id, station_number)
);

--- 4. 역별 혼잡도
CREATE TABLE IF NOT EXISTS Station_Congestion (
    congestion_id INTEGER PRIMARY KEY AUTOINCREMENT,
    quarter_code TEXT NOT NULL, -- 연분기코드 ex) 20241
    station_number TEXT NOT NULL,
    day_of_week INTEGER NOT NULL, -- 요일 구분 0: 평일, 1: 토요일, 2: 일요일
    is_upline INTEGER NOT NULL, -- 상행 구분 0: 하행, 1: 상행
    time_slot INTEGER NOT NULL, -- 05:30 = 1, 06:00 = 2, ...
    congestion_level REAL NOT NULL,
    FOREIGN KEY (station_number) REFERENCES Station_Routes(station_number) ON DELETE CASCADE,
    UNIQUE(station_number, quarter_code, is_weekend, is_upline, time_slot)
);
