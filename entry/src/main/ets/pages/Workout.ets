import DateUtil from '../Utils/DateUtils';
import { WorkoutItem } from './WorkoutItem';
import DateDialog from '../Component/dateSelectionDialog'
import systemDateTime from '@ohos.systemDateTime';
import { BusinessError } from '@ohos.base';

@Entry
@Component
export struct Workout {
  pathStack: NavPathStack = new NavPathStack()
  private tabController: TabsController = new TabsController()
  @State convertedDate: string = ''
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @StorageLink('current_date') currentDate: string = ''

  dateSelectionController: CustomDialogController = new CustomDialogController({
    builder: DateDialog({
      date: new Date(this.date)
    })
  })

  @Builder
  PagesMap(name: string) {
    if (name == "Workout List") {
      WorkoutItem()
    }
  }

  aboutToAppear(): void {
    AppStorage.setOrCreate("PathStack", this.pathStack)
    systemDateTime.getCurrentTime((error: BusinessError, time: number) => {
      this.convertedDate = DateUtil.timestampToDate(time);
    });
  }

  build() {
    Navigation(this.pathStack) {
      Stack() {
        Column() {
          Column() {
            Text(`${this.currentDate}`)
            Row() {
              Text(`${this.currentDate == '' ? this.convertedDate : this.currentDate}`)
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
            .onClick(()=>{
              this.dateSelectionController.open()
            })
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

