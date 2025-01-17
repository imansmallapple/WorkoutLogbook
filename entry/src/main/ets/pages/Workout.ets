import DateUtil from '../Utils/DateUtils';
import systemDateTime from '@ohos.systemDateTime';
import { BusinessError } from '@ohos.base';
import { Sport } from '../model/dailyExercise'
import { Record } from '../model/record'
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import TaskItem from '../Component/taskItem';

export class FinishObject {
  date: string = ''
  isFinish: boolean = false
}

PersistentStorage.persistProp<Sport[]>('todaySports', [])
AppStorage.setOrCreate<Record[]>("recordList", []);
PersistentStorage.persistProp<FinishObject>('finishObj', new FinishObject())


export class SportSchedule {
  date: string = ''
  sports: Sport[] = []
}

@Entry
@Component
export struct Workout {
  @State convertedDate: string = ''
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @StorageLink('current_date') currentDate: string = ''
  @State selectedDate: string = DateUtil.timestampToDate(new Date().getTime());
  @StorageProp('recordList') records: Record[] = []
  @State todaySports: Sport[] = AppStorage.get("todaySports") ?? []
  @State todayRecord: Record = new Record()
  // @State finishObj: FinishObject = new FinishObject()
  @StorageProp('finishObj') finishObj: FinishObject = new FinishObject()
  @State isTodayFinish: boolean = false
  @State num: number = 0
  @State sportSchedule: SportSchedule = new SportSchedule()
  @State burnedCalories: number = 0
  @State isTouch: boolean = false

  aboutToAppear(): void {
    systemDateTime.getCurrentTime((error: BusinessError, time: number) => {
      this.convertedDate = DateUtil.timestampToDate(time);
    });
  }

  build() {
    Column() {
      Column() {
        Column() {
          Row() {
            Image($r('app.media.history'))
              .width(40)
              .onClick(() => {
                if (1) {
                  router.pushUrl({
                    url: 'pages/Record'
                  })
                }
              })
              .margin({ top: 10, right: 10 })
              .opacity(0.5)
          }
          .width('100%')
          .justifyContent(FlexAlign.End)

          Row() {
            Text(`${this.selectedDate}`)
              .fontSize(15)
              .fontWeight(500)
          }
          .width('50%')
          .height(50)
          .backgroundColor(Color.White)
          .margin({
            bottom: 30
          })
          .borderRadius(10)
          .justifyContent(FlexAlign.Center)
          .shadow({
            radius: 20,
            offsetX: 10,
            offsetY: 10,
            color: '#8044a04f'
          })

          Row() {
            if (this.finishObj.date !== this.selectedDate) {
              Text('Have you worked out today?')
                .fontSize(18)
                .fontColor('#ff0b256e')
            }
            else {
              Text('Good Job! Keep going~')
                .fontSize(18)
                .fontColor('#ff0b256e')
            }
          }
          .width('80%')
          .height('20%')
          .margin({
            bottom: ('10%')
          })
          .justifyContent(FlexAlign.Center)
        }
        .justifyContent(FlexAlign.Start)
        .backgroundColor(Color.White)
        .width('100%')
      }

      if (this.finishObj.date !== this.selectedDate) {
        Button() {
          Column() {
            Text('+     Add workout')
              .fontSize(20)
              .fontColor(Color.White)
          }
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/AddSport'
          })
        })
        .backgroundColor('#b770c805')
        .type(ButtonType.Normal)
        .borderRadius(20)
        .fontWeight(800)
        .padding({
          top: 10,
          bottom: 10,
          left: 30,
          right: 30
        })
        .zIndex(1)
        .shadow({
          radius: 30,
          offsetY: 10,
          color: Color.Gray
        })
        .margin({
          bottom: 25
        })
      }

      Column() {
        Row() {
          Text("Task List")
            .fontSize(13)
            .fontWeight(700)
            .margin({ left: 20, top: 20, bottom: 10 })
          Blank()
          if (this.finishObj.date !== this.selectedDate) {
            Button('Finish')
              .type(ButtonType.Normal)
              .borderRadius(5)
              .width(80)
              .fontSize(15)
              .margin({ right: 10 })
              .backgroundColor(Color.Black)
              .onClick(() => {
                if (this.todaySports.length == 0) {
                  promptAction.showToast({
                    message: "Please add a sport first!"
                  })
                }
                else {
                  this.finishObj.date = this.selectedDate
                  this.finishObj.isFinish = true
                  AppStorage.setOrCreate<FinishObject>("finishObj", this.finishObj);

                  this.records.push(this.todayRecord)
                  console.info(`${this.todayRecord.date}`)
                  this.todayRecord.sports = this.todaySports
                  this.todayRecord.date = this.selectedDate
                  AppStorage.setOrCreate<Record[]>("recordList", this.records);

                  promptAction.showToast({
                    message: 'Task finished! Keep going~'
                  })
                  router.pushUrl({ url: 'pages/Record',
                    params: {
                      record: this.todayRecord
                    }
                  })
                }
              })
          }
        }
        .width('100%')

        if (this.finishObj.date == this.selectedDate) {
          Column({ space: 8 }) {
            Image($r('app.media.congratulation'))
              .width(100)
              .height(100)
            Text('Congratulations, you finished all tasks today!')
              .fontSize(20)
              .opacity(0.4)
          }
          .width('100%')
          .margin({ top: 20 })
        } else {
          if (this.todaySports.length !== 0) {
            Column() {
              List() {
                ForEach(this.todaySports, (item: Sport) => {
                  ListItem() {
                    TaskItem({
                      item: item,
                      isComplete: item.isFinish,
                      burnedCalories: $burnedCalories
                    })
                      .onClick(() => {
                        console.info(`burned:${item.burnedCalories}`)
                      })
                  }
                  .width('75%')
                })
              }
              .width('100%')
              .alignListItem(ListItemAlign.Start)
            }
            .width('100%')
          }
          else {
            Column({ space: 8 }) {
              Image($r("app.media.no_task"))
                .width(100)
                .height(100)
                .margin({ left: 15 })
                .opacity(0.4)
              Text('No task, please add')
                .fontSize(20)
                .opacity(0.4)
            }
            .width('100%')
            .margin({ top: 20 })
          }
        }
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}

