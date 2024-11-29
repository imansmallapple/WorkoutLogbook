class DateUtil {
  formatDate(num: number) {
    let date = new Date(num)
    let year = date.getFullYear()
    let month = date.getMonth() + 1
    let day = date.getDay()
    let m = month < 10 ? '0' + month : month
    let d = day < 10 ? '0' + day : day
    return `${d}/${m}/${year}`
  }

  beginTime(date: Date) {
    let day = new Date(date.getFullYear(), date.getMonth(), date.getDay())
    return day.getTime()
  }
}


let dateUtil = new DateUtil()

export default dateUtil as DateUtil