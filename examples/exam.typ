#import "@local/park-typstweb:0.1.0": exams
#import exams: *
#show: exam.with(
  coursename: "Statistical Computing",
  assessment: "Midterm",
  year: "2026",
  school: "Hanyang University",
  sols: false,
  show-instruction: false,
)
#section("Questions", points: true)[
  #question([Compute $1+1$.], [2], points: 2)
]
