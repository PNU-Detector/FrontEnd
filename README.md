# PNUTOUR
## 1. 프로젝트 소개

기존의 고등학생, 신입생을 대상으로 한 부산대학교 탐방은 홍보대사 학생들이 학교 소개와 해설을 담당한다. 그러나 홍보대사 한두명이 많은 인원의 탐방을 진행하면서 정보 전달이 어려워지고, 야외에서의 진행으로 전달력이 부족해진다. 이러한 문제점을 해설가 애플리케이션 제작으로 해결할 수 있다고 생각했다. 부산대학교 지리에 익숙한 재학생이 아닌 부산대학교를 탐방하는 고등학생, 신입생과 같은 일반인 에게도 다양한 정보를 제공하는 목적으로 애플리케이션을 제작하였다.

## 2. 팀 소개
|                                                          | 이름                                   | 이메일                | 역할                               |
|----------------------------------------------------------|--------------------------------------|--------------------|----------------------------------|
| <img src="https://github.com/YoungHanLi.png" width="70"> | [이영한](https://github.com/YoungHanLi) | 9908yong@naver.com | 1. 데이터 수집 <br/>2.데이터 전처리         |
| <img src="https://github.com/yunzae.png" width="70">     | [김윤재](https://github.com/yunzae) | dsa05037@naver.com | 1. 모바일 애플리케이션 개발<br/>2.서버, DB 담당 |

## 3. 구성도
![구성도](https://github.com/pnucse-capstone/Capstone-Template-2023/assets/81746373/7083aa20-cdca-4296-ac06-34c465f8c107)

## 4. 소개 및 시연 영상
<img src="https://github.com/pnucse-capstone/Capstone-Template-2023/assets/81746373/7fabef03-a7fe-47c7-b547-7ea092831c2d">
[시연영상]

## 5. 사용법
### 5.1 간단 사용법
이 방법은 도커허브에 미리 올려 놓은 도커이미지를 사용합니다.
#### 서버 실행
0. 도커가 설치 되어 있어야 한다.
1. docker-compose 파일을 다운 받는다.
2. 필요에 따라 docker-compose 파일을 수정한다. (ex. 포트 수정)
3. 터미널에서 `docker-compose up` 명령어를 입력한다.

#### 서버에 초기 데이터 넣기
1. `cd ../data_init` 명령어로 디렉토리를 이동한다.
2. 필요에 따라 main.py의 hosturl을 수정한다.
3. `python main.py `명령어로 파이썬 파일을 실행한다.

#### 안드로이드 애플리케이션
1. `frontend/pnutour/app-release.apk` apk 파일을 다운 받는다.
2. 안드로이드 디바이스에 apk 파일을 설치 한다.

### 5.2 사용법
#### 서버실행
0. 도커가 설치 되어 있어야 한다.
1. fastapi 도커 이미지 생성: 
   1. `cd backend/ai` 명령어로 도커파일이 있는 디렉토리로 이동한다.
   2. `docker build --tag <도커이미지이름> <태그>` 명령어로 도커 이미지를 생성한다.
2. 스프링부트 도커 이미지 생성:
   1. `cd backend/pnutour` 명령어로 도커파일이 있는 디렉토리로 이동한다.
   2. `/gradlew build` 명령어를 이용하여 jar파일을 생성한다.
   3. `docker build --tag <도커이미지이름> <태그>` 명령어를 이용하여 도커 이미지를 생성하다.
3. docker-compose 파일을 본인이 설정한 도커이미지 이름으로 수정하고 실행환경에 맞게 포트를 수정한다.
4. `docker-compose up` 명령어를 사용하여 실행한다.


#### 서버에 초기 데이터 넣기
1. `cd ../data_init` 명령어로 디렉토리를 이동한다.
2. 필요에 따라 main.py의 hosturl을 수정한다.
3. `python main.py `명령어로 파이썬 파일을 실행한다.


#### 안드로이드 애플리케이션
1. `frontend/pnutour/app-release.apk` apk 파일을 다운 받는다.
2. 안드로이드 디바이스에 apk 파일을 설치 한다.
