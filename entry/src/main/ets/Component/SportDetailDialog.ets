import DateUtil from '../Utils/DateUtils';
import { Callback } from '@ohos.base';

@Preview
@CustomDialog
export struct SportDetailDialog {
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @State show: boolean = true
  keyboardArray: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.']
  controller: CustomDialogController

  @Builder
  confirmButton(text: string, color: ResourceColor | string, onClick: ((event: ClickEvent) => void)) {
    Button() {
      Text(text)
        .fontSize(20)
        .fontWeight(800)
        .opacity(0.9)
    }
    .width(100)
    .height(50)
    .type(ButtonType.Normal)
    .backgroundColor(color)
    .borderRadius(5)
    .padding({ left: 5, right: 5 })
    .margin({top: 15})
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.icon'))
          .width(20)
          .height(20)
          .onClick(() => {
            this.controller.close()
          })

        Blank()

        Text(DateUtil.timestampToDate(this.date))
          .fontSize(15)
          .fontWeight(600)
      }
      .width('95%')
      .justifyContent(FlexAlign.End)

      Column({ space: 10 }) {
        Image($r('app.media.icon'))
          .width(90)
          .height(90)
        Text('Swimming')
          .fontSize(20)
          .fontWeight(700)
          .fontColor(Color.Gray)
        Row() {
          TextInput()
            .width('35%')
            .fontSize(35)
            .fontColor('#ff033ba7')
            .caretColor(Color.Transparent)
            .textAlign(TextAlign.Center)
            .copyOption(CopyOptions.None)
          Text('/ hour')
            .fontSize(35)
            .opacity(0.7)
            .fontWeight(800)
        }

        Panel(this.show) {
          Column() {
            Grid() {
              ForEach(this.keyboardArray, (item: string) => {
                GridItem() {
                  Text(item)
                    .fontSize(20)
                    .fontWeight(500)
                }
                .keyboardButtonStyle()
                .onClick(() => {
                  // todo: add keyboard click event
                })
              })

              GridItem() {
                Text('Delete')
                  .fontSize(20)
                  .fontWeight(500)
              }
              .keyboardButtonStyle()
              .onClick(() => {
                // todo: add delete button click event
              })

              GridItem() {
                this.confirmButton('Confirm', '#ff0ef3eb', () => {
                  this.show == false
                })
              }
              .columnStart(0)
              .columnEnd(2)

            }
            .columnsTemplate('1fr 1fr 1fr')
            .columnsGap(4)
            .rowsGap(4)
            .width('95%')
            .padding({ top: 15 })
          }
        }
        .mode(PanelMode.Half)
        .halfHeight(1050)
        .type(PanelType.Temporary)
        .dragBar(false)
        .width('100%')

      }
    }
    .width('95%')
    .height('95%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Extend(GridItem)
function keyboardButtonStyle() {
  .backgroundColor(Color.White)
  .opacity(0.7)
  .height(50)
  .borderRadius(15)
}