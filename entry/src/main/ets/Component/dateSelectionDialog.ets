PersistentStorage.persistProp<string>('current_date', '')

@CustomDialog
@Preview
@Component
export default struct DateDialog {
  @StorageLink('current_date') currentDate: string = ''
  controller: CustomDialogController
  date: Date = new Date();
  @State selectDate: Date = new Date()
  build() {
    Column() {
      DatePicker({
        start: new Date(),
        end: new Date('2050-12-31'),
        selected: this.date
      })
        .onDateChange((value: Date) => {
          this.selectDate = value
          this.currentDate = value.toString()
          this.date.setFullYear(value.getFullYear(), value.getMonth(), value.getDay())
        })
      Row({ space: 20 }) {
        Button('Cancel')
          .width(120)
          .backgroundColor(Color.Orange)
          .onClick(() => {
            this.controller.close()
          })
        Button('Confirm')
          .width(120)
          .backgroundColor(Color.Orange)
          .onClick(() => {
            AppStorage.setOrCreate('date', this.date.getTime())
            this.controller.close()
          })
      }
      Text(`current_date:${this.currentDate}`)
      Text(`${this.selectDate}`)
      Text(`${this.date.getTime()}`)
    }
    .padding(12)
  }
}