export class Sport {
  name: string = ''
  icon?: Resource = $r('app.media.app_icon')
  consume: number = 0
  num?: number | string = 0
  target?: number | string = 0
  unit: string = ''
  isFinish?: boolean = false
  isStart?: boolean = false
  burnedCalories: number = 0
  usedTime: number = 0
}