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

### 7.20 과제 refactor
emoji를 받아오는 것을 싱글톤의 함수로 만들었다.
theme은 enum으로 두고 enum은 Int, caseIterable 프로토콜을 적용시켜서, Int.random(in: )메소드를 써서 한줄로 가져오게 만들었다.

### chap3
### Computed properties   
get{} : 여기서 계산된결과를 return.   
set{} :  값을 할당할때, 여기 코드가 실행된다.    

* get-only(가능)

- 그래서 computed property는 언제 쓰일까???

많은 경우에 class나 struct 내에서 볼수 있는 속성들이 구조체의 다른 상태로부터 얻어졌을 수 있다.  
이때의 경우 computed properties를 쓰지 않았을 경우, 결국은 같은 정보를 다른 변수에 저장하고 있을 가능성이 높다.   
같은 정보를 다른 변수에 담다보면, 정보의 동기화가 안될 수도 있고, 그렇다보면 많은 문제들이 발생하게 된다.   
그래서 computed property를 사용한다.  
사용 예시:
~~~
private var indexOfOneAndOnlyFaceUpCard: Int? //앞면인 카드의 index를 찾아준다.
~~~
하지만 이 변수는 결국에는 우리가 카드 배열에서 앞면인 것을 찾으면 바로 return 해주는 computed properties로 구현한다면, 변수의 변화에 대한 신경을 안써도 된다.
~~~
private var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
        // 카드를 다보면서, 앞면인 카드가 있다면 그것을 return
        // 없다면? return nil
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
        return foundIndex
        }
    set {
        // newValue의 카드를 제외하고, 다 카드를 뒤집어 엎는다.
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
}
~~~

- 그렇다면 언제 computed property or method???


해당 작업이 속성으로 인식되는지에 달려있다.  
위의 index는 속성으로 인식된다. -> 앞면인 카드이기 때문이다.
그렇지만 get or set에 많은 일을 넣어야한다면? method를 만들어야할 것이다.

### Access Control
- internal : default임, 앱 내의 어떤 사람, 어떤 객체가 그 메소드나 변수에 접근 가능하다.
- private : 그 객체 안에서만 쓸수 있는 메소드나 변수
- privage(set) : set은 private이고, get은 어디서든 접근 가능
 - fileprivate: 파일 내에 여러 class가 있더라도 서로 접근 가능
 - 일단 다 private으로 하고 필요할 경우에 private을 빼주자
 
 ### enum
 - 값 타입 
 - associated Data
    ~~~
    enum FastFoodMenuItem {
        case hamburger(numberOfPatties: Int)
        case fries(size: FryOrderSize)
        case drink(String, ounces: Int) //안정해진 것은 우리가 그냥 임의적으로 넣어줄 수 있다.
        case cookie
    }
    
    enum FryOrderSize {
        case large
        case small
    }
    
    let menuItem: FastFoodMenuItem.hamburger(patties: 2)
    
    //switch
    var menuItem = FastFoodMenuItem.hamburger(patties: 2)
    switch menuItem { //이때는 associated Data를 신경안써도된다.
        case FastFoodMenuItem.hamberger: print("burger")
        case FastFoodMenuItem.fries: print("fries")
        case FastFoodMenuItem.drink: print("drink")
        case FastFoodMenuItem.cookie: print("cookie")

    }
    ~~~
   -  Associated Data에 대한 switch 문은 let 을 사용한다.
    ~~~
    var menuItem = FastFoodMenuItem.drink("coke", ounces: 2)
    switch menuItem { //이때는 associated Data를 신경안써도된다.
        case .hamberger(let pattyCount): print("burger with \(pattycount)")
        case .fries(let size): print("\(size)size fries")
        case .drink(let brand, let ounces): print("\(ounces)oz \(brand)")
        case .cookie: print("cookie")
    }
    ~~~
    - Properties는 안되지만, methods은 있어도 된다.
    - enum을  수정할때는 값타입이기 때문에 mutating이기 때문이다.
    ~~~
    enum FastFoodMenuItem{
        mutating func switchToBeingACookie() {
        ,,,,
        }
    }
    ~~~
    
