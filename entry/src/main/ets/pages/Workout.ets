import DateUtil from '../Utils/DateUtils';
import { Record } from './Record';
import { WorkoutItem } from './WorkoutItem';

@Entry
@Component
export struct Workout {
  pathStack: NavPathStack = new NavPathStack()
  private tabController: TabsController = new TabsController()
  @State date: number = DateUtil.beginTime(new Date())

  @Builder
  PagesMap(name: string) {
    if (name == "Workout List") {
      WorkoutItem()
    }
  }

  aboutToAppear(): void {
    AppStorage.setOrCreate("PathStack", this.pathStack)
  }

  build() {
    Navigation(this.pathStack) {
      Stack() {
        Column() {
          Column() {
            Row() {
              Text(DateUtil.formatDate(this.date))
                .fontSize(15)
                .fontWeight(500)
              Image($r('app.media.drop_icon'))
                .width(15)
                .margin({ left: 10 })
            }
            .width('90%')
            .height(50)
            .backgroundColor(Color.White)
            .margin({
              bottom: 30
            })
            .borderRadius(20)
            .borderWidth(1)
            .justifyContent(FlexAlign.Center)
          }
          .justifyContent(FlexAlign.End)
          .backgroundColor(Color.Pink)
          .height('40%')
          .width('100%')
        }
        .height('100%')

        Button('+')
          .onClick(() => {
            this.pathStack.pushPathByName("Workout List", '');
          })
          .margin(20)
      }
      .alignContent(Alignment.BottomEnd)
      .width('100%')
      .height('100%')
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .title('Index')
    .navDestination(this.PagesMap)
    .hideBackButton(true)
  }
}

