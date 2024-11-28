import { Record } from './Record';
import { WorkoutItem } from './WorkoutItem';

@Entry
@Component
export struct Workout {
  pathStack: NavPathStack = new NavPathStack()
  private tabController: TabsController = new TabsController()
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
        Button('+')
          .onClick(() => {
            this.pathStack.pushPathByName("Workout List", '');
          })
      }
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .title('Index')
    .navDestination(this.PagesMap)
    .hideBackButton(true)
  }
}

