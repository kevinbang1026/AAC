# Automatic Assignment Checker

## Introduction

This program automatically checks students' assignments for the **Introduction to Software Design** lecture.

## How to Use

For each question, you can perform multiple tests by setting various input and answer output files.

### File Naming Convention

- **Input Files:** `{question number}-{test number}.txt`
  - Example: `2-1.txt`
- **Output Files:** `a{question number}-{test number}.txt`
  - For alternative answers: `a{question number}-{test number}-alt{number}.txt`
    - Example: `a3-3.txt`, `a3-3-alt1.txt`, `a3-3-alt2.txt`

### Steps to Run

1. **Download** the zip file containing the assignments from the LMS and **unzip** it.
2. **Unzip** all the zip files inside the base directory.
3. **Create** the input and output files following the naming convention. Ensure these files are in the same directory as `auto.sh`.
4. **Set** the base directory in the `auto.sh` file.
5. **Run** the script using the following command:
   ```bash
   bash ./auto.sh
   ```

---

# 자동 과제 채점기

## 소개

이 프로그램은 **소프트웨어 입문 설계** 강의의 학생 과제를 자동으로 채점합니다.

## 사용 방법

각 질문에 대해 다양한 입력 및 정답 출력 파일을 설정하여 여러 테스트를 수행할 수 있습니다.

### 파일 명명 규칙

- **입력 파일:** `{문제 번호}-{테스트 번호}.txt`
  - 예시: `2-1.txt`
- **출력 파일:** `a{문제 번호}-{테스트 번호}.txt`
  - 대체 정답: `a{문제 번호}-{테스트 번호}-alt{번호}.txt`
    - 예시: `a3-3.txt`, `a3-3-alt1.txt`, `a3-3-alt2.txt`

### 실행 방법

1. LMS에서 과제가 포함된 zip 파일을 **다운로드**하고 **압축을 해제**합니다.
2. 기본 디렉터리 내의 모든 zip 파일의 압축을 **해제**합니다.
3. 명명 규칙에 따라 입력 및 출력 파일을 **생성**합니다. 이 파일들은 `auto.sh` 파일과 동일한 디렉터리에 있어야 합니다.
4. `auto.sh` 파일에서 기본 디렉터리를 **설정**합니다.
5. 아래 명령어를 사용하여 스크립트를 **실행**합니다:
   ```bash
   bash ./auto.sh
   ```