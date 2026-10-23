# park-typstweb 0.1.0 — 로고 없는 배포본

Seoncheol Park의 Typst 웹 앱용 공통 강의·시험 템플릿입니다.
첨부하신 template.typ, exam.typ, rcode.typ를 바탕으로 구성했습니다.
**학교 로고 이미지 파일은 모두 제외했고, 기본 logo와 logo-small은 none입니다.**
Calepin용 park-lecture와 별개로 관리합니다. references.bib와 폰트 파일은 포함하지 않습니다.

## 1. GitHub에 보관하기

1. GitHub에서 park-typstweb 저장소를 만듭니다.
2. 압축을 풀고 **typst.toml, lib.typ, template.typ 등이 저장소 최상위에 오도록** 올립니다.
3. 이 배포본에는 images 폴더가 없습니다. 기본 상태는 로고 없이 컴파일됩니다.

패키지의 시작 파일은 lib.typ입니다. preview.typ는 패키지 자체를 확인하는 문서입니다.
실제 강의 원고를 lib.typ에 넣지 않습니다.
GitHub에 올리는 것만으로 다른 Typst 프로젝트에서 자동 import되는 것은 아닙니다.
다음 단계의 Private Package 등록이 필요합니다.

## 2. 웹 앱의 Private Package로 등록하기 (Typst Pro 필요)

1. Typst 웹 앱에서 새 프로젝트를 만들고 이 ZIP을 가져오거나, 위 GitHub 저장소를 연결합니다.
2. 프로젝트 최상위에 typst.toml이 있는지 확인합니다. 폴더가 이중으로 중첩되지 않게 합니다.
3. preview.typ를 미리보기 대상으로 선택하여 컴파일되는지 확인합니다.
4. typst.toml을 열면 패키지 설정 화면이 표시됩니다.
5. name: park-typstweb, version: 0.1.0, entrypoint: lib.typ를 확인합니다.
6. Publish를 눌러 비공개 패키지 버전을 등록합니다.
7. **다른 문서 프로젝트**에서 아래 예제를 사용합니다.

이 Publish는 Typst Universe 공개 등록이 아닙니다.
GitHub와 웹 앱을 연결하면 GitHub 수정사항을 앱에서 Pull할 수 있습니다.
수정 후에는 typst.toml 버전을 0.1.1 등으로 올리고 다시 Publish합니다.
기존 문서에서 새 버전을 사용할 때 import의 버전도 바꿉니다.
GitHub push나 Pull만으로 이미 등록된 버전의 내용이 갱신되지는 않습니다.

공식 안내:
- https://typst.app/docs/web-app/private-packages/
- https://typst.app/docs/web-app/git-sync/

## 3. 강의노트에서 사용하기

```typst
#import "@local/park-typstweb:0.1.0": *

#show: lecture.with(
  lecturetype: "note",
  title: "확률론",
  authors: ("Seoncheol Park",),
)

= 확률공간

#definition[확률공간][여기에 정의를 작성합니다.] <def-space>
#theorem[예시 정리][여기에 명제를 작성합니다.] <thm-demo>
#proof[여기에 증명을 작성합니다.]

See @def-space and @thm-demo.
```

기존의 lecture.with(...) 옵션 이름을 유지했습니다.
정리 번호 초기화와 common-style은 lecture가 적용하므로 별도로
#show: thmbox-init(...)를 중복해서 넣을 필요가 없습니다.
필요하면 lecture.with(counter-level: 2, ...)처럼 지정할 수 있습니다.

기본 상태에서는 로고를 표시하지 않습니다. 필요한 경우 문서 프로젝트에서만 로고를 지정합니다.
기본 폰트는 원본 설정을 유지했습니다. 웹 앱에서 폰트 경고가 나오면
해당 글꼴 파일을 문서 프로젝트에 올리거나 main-font/title-font/mono-font를 지정하세요.
각주에는 IBM Plex Serif와 Noto Serif KR를 순서대로 사용합니다.

## 4. 슬라이드에서 사용하기

```typst
#import "@local/park-typstweb:0.1.0": *
#show: lecture.with(
  lecturetype: "slide",
  title: "Newton's method",
  subtitle: "Statistical Computing",
  authors: ("Seoncheol Park",),
  firstlevelheading: false,
)

== Root finding
#definition[A root][A root satisfies $f(x)=0$.]

=== An iteration
$ x_(k+1) = x_k - frac(f(x_k), f'(x_k)) $

== The next slide
본문
```

원본 앱용 템플릿처럼 title 옵션으로 표지가 자동 생성됩니다.
==는 새 슬라이드, ===는 슬라이드 안의 소제목입니다.
=의 동작은 기존 firstlevelheading 옵션을 유지합니다.
Calepin 패키지의 '=을 표지로 사용'하는 규칙과 구분해주세요.

#slidebreak()는 슬라이드에서만, #notebreak()는 note/note-horiz에서만 작동합니다.
#slide-columns(2)[...]와 #note-columns(2)[...]도 각각의 모드에서만 적용됩니다.
단 나누기 제목은 해당 블록 밖에 두는 편이 편리합니다.

## 5. 시험지에서 사용하기

시험지 함수와 강의 함수가 충돌하지 않도록 exams 모듈로 제공합니다.

```typst
#import "@local/park-typstweb:0.1.0": exams
#import exams: *

#show: exam.with(
  coursename: "전산통계",
  assessment: "중간고사",
  year: "2026",
  school: "Hanyang University",
  sols: false,
  show-instruction: false,
)

#section("Questions")[
  #question([Compute $1+1$.], [2], points: 2)
]
```

기존 시험지의 /exam.typ import를 위 두 줄로 바꾸는 방식입니다.
나머지 question, mcq 등의 문법은 기존대로 사용합니다.
sols: true이면 기존 기능대로 해설을 표시합니다.

문서 프로젝트의 R 파일에서 구간을 읽으려면 **path(...)**로 전달하세요.
문자열 경로는 패키지 안을 기준으로 해석될 수 있습니다.

```typst
#include-code-section(path("example.R"), "# BEGIN", "# END")
```

파일 내용을 읽어 보여주는 기능이며 R 코드를 실행하지 않습니다.
새 프로젝트에 examples/example.R을 따로 올린 뒤 테스트할 수 있습니다.

## 6. 미리 처리한 R 코드 표시

기존 원고가 Skylighting, NormalTok 등을 직접 호출한다면:

```typst
#import "@local/park-typstweb:0.1.0": rcode
#import rcode: *

#Skylighting(number: true, (
  [#NormalTok("x ")#OperatorTok("<-")#DecValTok(" 1")],
  [#FunctionTok("sqrt")#NormalTok("(2)")],
))
```

기존 /rcode.typ import를 위 두 줄로 바꾸면 됩니다.
기본 lib.typ를 *로 가져온 경우에는 rcode.Skylighting(...)처럼 호출할 수도 있습니다.
R/Python 실행 결과·그림·표는 기존대로 미리 생성해서 문서 프로젝트에 넣으세요.

## 7. 참고문헌은 각 문서 프로젝트에

references.bib는 이 패키지에 포함하지 않았습니다.
문서 프로젝트에 직접 올리고 평소처럼 사용합니다.

```typst
본문에서 @문헌키 를 인용합니다.
#bibliography("references.bib", style: "apa")
```

## 8. 필요한 문서에서만 로고 사용

이 배포본은 학교 로고를 포함하지 않습니다. logo와 logo-small은 기본값 none이며,
로고가 없어도 note·slide·시험지를 컴파일할 수 있습니다.

학교 사용 지침상 허용되는 문서에서만, 해당 문서 프로젝트에 이미지를 올리고 지정합니다.
패키지 저장소에 로고를 다시 넣을 필요는 없습니다.

```typst
#show: lecture.with(
  title: "Course title",
  authors: "Author",
  logo: path("images/my-logo.png"),
  logo-small: path("images/my-mini.png"),
)
```

시험지는 exam.with(logo: path("images/my-logo.png"), ...)로 지정합니다.
GitHub에 문서 프로젝트도 올릴 경우 해당 프로젝트에 로고가 포함되지 않았는지도 확인하세요.

## 9. 파일별 편집 위치

| 파일 | 내용 |
|---|---|
| template.typ | note·slide·note-horiz 디자인, 정리·증명, 글꼴·여백 기본값 |
| exam.typ | 시험지·문제·선택지·해설·점수 처리 |
| rcode.typ | 토큰 색상과 소스 코드 줄 배치 |
| lib.typ | 패키지에서 공개하는 함수와 모듈 |
| typst.toml | 이름·버전·시작 파일 |
| preview.typ | 패키지 프로젝트 자체의 미리보기 원고 |
| examples/ | 새 문서에 복사해서 사용할 예제 |

원본 파일을 바탕으로 패키지 경로를 정리했고, import된 함수에 show 규칙이 적용되도록 했습니다.
note 저자명이 배열 괄호째 표시되던 부분, proof/remark가 한 문단에 붙던 부분,
Skylighting 여러 코드 줄이 한 줄에 붙던 부분도 정리했습니다.
정리의 공유 카운터, 기존 디자인과 시험 문항 함수의 기본 동작은 유지했습니다.

## 10. 검증 범위

Typst 0.15.1 CLI에서 패키지 import를 통해 note·slide·시험지 예제를 컴파일했습니다.
별도 소비자 프로젝트에서도 해설과 객관식 문제, 문서 R 파일의 구간 읽기,
문서 자체의 .bib 인용을 확인했습니다.
웹 앱 계정에 실제 등록하거나 GitHub에 push한 상태는 아닙니다.

의존 패키지는 thmbox 0.3.0, cades 0.3.1, scienceicons 0.1.0이며 자동으로 불러옵니다.
원본 scienceicons 0.1.0에서 Typst 0.15의 raw 문법 관련 경고가 나올 수 있습니다.
현재 컴파일 오류는 아니며, 새 Typst 주요 버전으로 바꿀 때 호환성을 다시 확인하세요.

## 로고 포함 배포본과의 관계

패키지 이름/버전은 park-typstweb:0.1.0으로 유지했습니다. 아직 등록하기 전이라면 이 ZIP으로 등록하세요.
이미 로고 포함 0.1.0을 Publish했다면 typst.toml을 0.1.1로 바꾸고 새 버전을 등록해야 합니다.
이 경우 사용 예제의 import도 0.1.1로 바꿉니다. 기존 배포 버전에서 이미지를 제거하려면
웹 앱에서 해당 버전 삭제도 별도로 필요하며, 그 버전을 쓰는 문서는 새 버전으로 전환해야 합니다.
이미 GitHub에 로고를 커밋했다면 이 묶음으로 교체해도 과거 커밋에는 이미지가 남습니다.
