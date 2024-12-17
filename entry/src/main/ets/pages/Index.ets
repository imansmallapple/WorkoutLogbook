import { RecordPage } from '../pages/Record'
import { Workout } from './Workout'
import { Exercise } from './WorkoutItem';

PersistentStorage.persistProp<Exercise[]>('exerciseList', [])

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;
  @StorageLink('exerciseList') exerciseList: Exercise[] = []

  build() {
    Tabs() {
      TabContent() {
        Workout()
      }
      .tabBar(this.barBuilder(0, $r('app.string.workout'), $r('app.media.workout_not_selected_icon'), $r('app.media.workout_selected_icon')))

      TabContent() {
        RecordPage()
      }
      .tabBar(this.barBuilder(1, $r('app.string.record'), $r('app.media.record_not_selected_icon'), $r('app.media.record_selected_icon')))
    }
    .barPosition(BarPosition.End)
    .onChange((index) => {
      this.currentTabIndex = index;
    })
  }

  @Builder
  barBuilder(index: number, title: string | Resource, icon: Resource, iconSelected: Resource) {
    Column() {
      Image(this.currentTabIndex === index ? iconSelected : icon)
        .width(25)
        .height(25)
      Text(title)
        .tabTitleStyle(this.currentTabIndex === index ? Color.Black : '#959595')
    }
  }
}

@Extend(Text)
function tabTitleStyle(color: ResourceColor) {
  .fontSize(10)
  .fontWeight(FontWeight.Medium)
  .margin({ bottom: 2 })
  .fontColor(color)
}