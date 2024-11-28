@Entry
@Component
export struct Record {
  pathStack: NavPathStack = new NavPathStack()
  onPageShow(): void {
    AppStorage.setOrCreate("PathStack", this.pathStack)
  }

  build() {
    NavDestination() {

    }
    .title('Record')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}