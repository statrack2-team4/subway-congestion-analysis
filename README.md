# 🚇지하철 혼잡도 분석 프로젝트

## 👥팀원

| <a href="https://github.com/JaeBinary"><img src="https://github.com/JaeBinary.png" width="100"></a> | <a href="https://github.com/leesunforest"><img src="https://github.com/leesunforest.png" width="100"></a> | <a href="https://github.com/miamikyeong-ux"><img src="https://github.com/miamikyeong-ux.png" width="100"></a> | <a href="https://github.com/Virum123"><img src="https://github.com/Virum123.png" width="100"></a> | <a href="https://github.com/beanbean12"><img src="https://github.com/beanbean12.png" width="100"></a> | <a href="https://github.com/jaewon8834-dot"><img src="https://github.com/jaewon8834-dot.png" width="100"></a> | <a href="https://github.com/yeilow"><img src="https://github.com/yeilow.png" width="100"></a> |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **김재빈** | **이혜림** | **정미경** | **김대훈** | **홍채빈** | **유재원** | **이인후** |

## ◽개요

- **진행 기간** : 26.01.05(월)-26.01.15(목)
    | 내용 | 일자 |
    | --- | --- |
    | 프로젝트 주제 탐색 및 확정 | 26.01.05-26.01.07 |
    | 데이터 수집 | 26.01.08-26.01.09 |
    | API수집 코드 작성, 크롤링 구현 | 26.01.10-26.01.11 |
    | DB 설계 및 적재 | 26.01.12 |
    | EDA + 기본 시각화 | 26.01.13 |
    | Plotly 대시보드 | 26.01.14 |
    | 해결 방안 정리, 리포트 | 26.01.15 |

- **사용 언어** : Python
- **DBMS** : SQLite

## ◽프로젝트 배경

- 출퇴근 시간대 지하철 혼잡은 **승객 불편**, **안전 문제**, **운영 비효율**을 초래함
- 혼잡도는 시간·노선·역별로 상이하며, **정량적 분석**이 필요함
- 공공데이터를 활용해 혼잡 패턴을 분석하고 **개선 시사점**을 도출하고자 함

## 📂프로젝트 구조

```
📦 subway-congestion-analysis
 ┣ 📂 data
 ┣ 📂 crawler
 ┣ 📂 api
 ┣ 📂 db
 ┣ 📂 analysis
 ┣ 📂 dashboard
 ┣ 📜 README.md
 ┣ 📜 report.ipynb
```

---

## 🎯 분석 목표

Q1. 출퇴근 시간대 혼잡도는 다른 시간대와 얼마나 차이가 나는가?

Q2. 혼잡도가 가장 높은 노선과 역은 어디인가?

Q3. 환승역은 일반역보다 혼잡도가 높은가?

Q4. 평일과 주말의 혼잡 패턴은 어떻게 다른가?

Q5. 특정 시간·노선 조건에서 혼잡 발생을 예측할 수 있는가?

## 🧠 분석 내용

- **날씨**가 지하철 이용량에 미치는 영향
- **출퇴근 시간대** 혼잡도 분석
- **주요 업무지구 통과** 여부 비교
- **행사·집회** 발생 시 혼잡도 영향
- 시간대·노선별 혼잡도 예측 모델
- **환승역**이 혼잡도에 미치는 영향 분석

---

## 🔗 혼잡도 영향 지표
| 구분 | 요인 |
| --- | --- |
| 구조적 | 출퇴근, 업무지구, 칸 수 |
| 환경적 | 날씨 |
| 이벤트 | 시위, 행사 |

## 🗒️데이터 정의
#### 주요 데이터
- 지하철 : 역 번호/ 역 이름, 승하차 인원, 탑승 인원, 수송 정원
- 인구 정보 : 생활인구, 유동인구, 직장인구
- 상권 정보 : 추정 매출
- 건물 : 주 용도, 세대 수
- 날씨 : 기온, 강수량, 강수 형태


#### 파생 데이터
- 시간대 : 출근 `07시-09시` 퇴근`18시-20시`
- 혼잡도 지수 `혼잡도 = (탑승 인원 / 수송 정원) × 100`

## 🗒️데이터 상세설명
<details>
<summary>지하철 혼잡도</summary>
  <div markdown="1">
  지하철 혼잡도는 열차 한 칸의 정원 대비 실제 탑승 승객 수의 비율을 나타냅니다.
  일반적으로 전동차 한 칸의 정원을 **160명**으로 기준으로 하며, 이는 좌석에 앉은 승객과 손잡이를 잡고 서 있는 승객이 적절히 섞여 있는 상태를 의미합니다.

  수치에 따른 일반적인 분류는 다음과 같습니다:

  - **34% 이하**: 여유 (좌석에 빈 자리가 있음)
  - **34% ~ 100%**: 보통 (좌석이 차고 일부 승객이 서 있음)
  - **100% ~ 150%**: 주의 (이동 시 부딪힘 발생)
  - **150% 이상**: 혼잡 (열차 내 이동이 어려움)

  공공데이터에서 데이터가 분기별로 갱신됩니다.
  </div>
</details>

<details>
<summary>역번호</summary>
<div markdown="1">
동일한 역명이라도 호선에 따라 별도의 역번호가 부여됩니다. 역번호는 승객 편의를 위한 "외부코드"와 시스템 관리용 "내부코드"로 구분됩니다.
외부코드는 하이픈(`-`) 등 특수문자를 포함할 수 있어, 통일성을 위해 **내부코드**를 기준으로 데이터를 처리했습니다. 또한, 데이터 출처별로 상이한 내부코드를 대조하여 정합성을 검증했습니다.
</div>
</details>

<details>
<summary>주소</summary>
<div markdown="1">
"서울교통공사 역주소" 데이터는 도로명주소와 지번주소를 제공하지만, 분석에 필수적인 **행정동** 정보는 포함되어 있지 않습니다.
이를 보완하기 위해 "역사마스터정보"에서 위도·경도 좌표를 추출하고, 카카오 로컬 API를 활용하여 각 역의 정확한 행정동 정보를 매핑했습니다.
</div>
</details>

<details>
<summary>인구정보</summary>
<div markdown="1">
지하철역 주변의 상권 및 유동성 분석을 위해 다음과 같은 인구 데이터를 수집했습니다.

- 생활인구
  - 내국인
  - 단기체류외국인
  - 장기체류외국인
- 유동인구
- 직장인구
- 추정매출

생활인구란 특정 지역에 거주하거나 체류하며 생활을 영위하는 인구를 의미하며, 다음과 같이 분류됩니다.

- **① 주민등록인구**: 주민등록법 제6조 제1항에 따라 등록된 거주자
- **② 체류인구**: 통근, 통학, 관광 등의 목적으로 특정 지역에 월 1회, 하루 3시간 이상 체류하는 방문객
- **③ 외국인**: 출입국관리법 제31조에 의한 외국인등록자 또는 재외동포법 제6조에 의한 국내거소신고인

공공데이터에서는 이들을 각각 내국인(①), 단기체류외국인(②), 장기체류외국인(③)으로 구분하여 제공합니다.
내국인은 성별 및 연령대별로, 외국인은 국적(중국/비중국)에 따라 세분화됩니다.

데이터 집계 범위는 자치구 > 행정동 > 집계구 단위로 세분화되나, 앞서 구축한 지하철역 데이터와의 연계를 위해 **행정동** 기준으로 통일했습니다.
한편, 서울시에서 제공하던 기존 [유동인구](https://data.seoul.go.kr/dataList/OA-21704/F/1/datasetView.do) 통계는 2015년부로 중단되었습니다.
이에 따라 [서울시 상권분석서비스](https://golmok.seoul.go.kr/source.do)에서 제공하는 실시간 및 분기별 **"길단위인구"** 데이터를 활용하여 이를 보완했습니다.

[직장인구](https://data.seoul.go.kr/dataList/OA-22184/S/1/datasetView.do#)와 [추정매출](https://data.seoul.go.kr/dataList/OA-22175/S/1/datasetView.do) 데이터 또한 동일하게 행정동 단위로 수집했습니다. (직장인구는 1년 단위, 그 외 데이터는 분기별로 갱신됩니다.)
</div>
</details>

<details>
<summary>건물</summary>
<div markdown="1">
지하철역 좌표를 기준으로 반경 500m(역세권) 이내의 건물 정보를 "GIS 건물통합정보"에서 추출했습니다.
주로 건물의 **주용도**와 **세대수** 데이터를 활용하여 역세권 특성을 분석했습니다.
</div>
</details>

<details>
<summary>날씨</summary>
<div markdown="1">
내용
</div>
</details>

---

## 🗄데이터베이스
### ERD 
![ERD](./images/erd.png)

---

## 데이터 분석

### 혼잡도 분석

### 원인 분석

### 행사

### 날씨

### 배차간격

### 인구

### 상권


---

### 데이터 출처
- **서울 열린데이터 광장**:
  - [서울시 지하철역 주소](https://data.seoul.go.kr/dataList/OA-12035/S/1/datasetView.do)
  - [서울시 지하철역 좌표](https://data.seoul.go.kr/dataList/OA-21232/S/1/datasetView.do)
  - [서울시 지하철호선별 역별 승하차 인원 정보](https://data.seoul.go.kr/dataList/OA-12914/S/1/datasetView.do)
  - 서울시 생활인구 (행정동)
    - [내국인](https://data.seoul.go.kr/dataList/datasetList.do#)
    - [장기 체류 외국인](https://data.seoul.go.kr/dataList/datasetList.do#)
    - [단기 체류 외국인](https://data.seoul.go.kr/dataList/datasetList.do#)
  - [서울시 유동인구 (행정동)](https://data.seoul.go.kr/dataList/OA-22178/S/1/datasetView.do)
  - [서울시 직장인구 (행정동)](https://data.seoul.go.kr/dataList/OA-22184/S/1/datasetView.do)
  - [서울시 추정매출 (행정동)](https://data.seoul.go.kr/dataList/OA-22175/S/1/datasetView.do)
  - [서울시 지하철 혼잡도 정보](https://data.seoul.go.kr/dataList/OA-12928/F/1/datasetView.do#)
  - [서울 도시철도 열차운행 시각표](https://data.seoul.go.kr/dataList/OA-22522/F/1/datasetView.do)
- **V-World GIS**: [GIS 건물통합정보](https://www.vworld.kr/dtmk/dtmk_ntads_s002.do?svcCde=NA&dsId=18).
- **카카오 API**: [카카오맵 로컬 REST API](https://developers.kakao.com/docs/latest/ko/local/dev-guide)
- **기상청 기상자료개방포털**: [기상예보 - 동네예보(초단기실황)](https://data.kma.go.kr/data/rmt/rmtList.do?code=400&pgmNo=570)
- **KOPIS 공연예술통합전산망**: [행사 일정](https://kopis.or.kr/por/db/pblprfr/pblprfr.do?menuId=MNU_00020)
- **KBO 공식 홈페이지**: [야구 일정](https://www.koreabaseball.com/Record/Crowd/GraphDaily.aspx)
- **빅카인즈**: [시위 발생 일정](https://www.bigkinds.or.kr)




