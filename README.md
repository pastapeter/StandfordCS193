# StandfordCS193

## studying URL : https://www.edwith.org/swiftapp/joinLectures/13694?isDesc=false

### 스탠포드 강의를 기반으로한 ios 스터디

### 7/15일 chap1
didset - property observer 사용법에 대한 간단한 이해
하나의 global 변수를 여러 UI 객체가 다 건들고 있을때, 그 변수의 값을 변경시킨다면, didset property observer로 그 변수의 값이 변경되었다면 didset 옵저버가 발동된다. 그렇게 된다면 UIlabel.text를 변경하는 것과 같은 UI 변경이 가능하다.

### 7.16 chap2
MVC 패턴으로 짜기
Model은 UI와 독립적으로 작성해야한다는 것이다. 따라서 Model에 UI와 관련된 것을 넣어둘 필요가 없다. 결국 Model은 UI에 독립적이며 View와 소통할수 없으며, View 또한 Model과 소통할 수가 없다.

View와 Controller의 소통방법
Controller는 outlet를 활용해서 view와 소통한다. 
View는 controller에게 delegate, datasource를 통해 controller에게 행위에 대한 요청, 데이터에 대한 요청을 할 수 있다. 그리고 action(view) - target(controller)의 구조로 사용자의 행위에 따라 필요한 함수를 호출 가능하다.

Static property & Static method
모델에서 공유하는 property를 만들 때, 우리는 static property를 사용한다. 인스턴스를 만들지 않고 type으로 접근한다. 그래서 모델에서 identifier을 만들때, 우리는 static property를 사용하고, static 메소드를 사용해서 static property의 값을 변경하고, 이를 init에 넣어준다면? 인스턴스.identifier은 인스턴스가 생길때마다 static 메소드의 연산이 적용된 채로 나오게 된다.

### 7.19 과제1
내가 푼 방법:
테마를 UIViewController에서 공유하기 위해서 싱글톤으로 만들어보았다.
Model과 View를 분리시키기 위해서 Model에서 notificationcenter의 post기능으로 신호를 보내고, view에서 notification.default.addObserver로 신호를 받아서 점수 - 구현을 했다.
시작버튼을 눌렀을때, 게임시작이 되고, 그러면 게임시작을 다시 누르게 된다면, 다시 작동하게 만들었다.
셔플함수를 만들었다.
