import { Record } from './Record';
@Entry
@Component
export struct Workout {
  pathStack: NavPathStack = new NavPathStack()
  private tabController: TabsController = new TabsController()
  @Builder
  PagesMap(name: string) {
    if (name == 'Record') {
      Record()
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
            this.pathStack.pushPathByName('Record', '');
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

