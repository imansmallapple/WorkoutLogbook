import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';

const DB_FILENAME: string = 'WorkoutLogbook.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore;

  //initialize database
  initDB(context: common.UIAbilityContext): Promise<void> {
    //
    let config: relationalStore.StoreConfig = {
      name: DB_FILENAME,
      //Security level
      //S1 is the lowest level
      securityLevel: relationalStore.SecurityLevel.S1
    }
    return new Promise<void>((resolve, reject) => {
      //resolve return data after initialize
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => { //make async operation
          this.rdbStore = rdbStore
          console.info('rbdStore initial finish')
          resolve()
        })
        .catch((err: BusinessError) => {
          console.error(`rdbStore initialize fail, reason:${JSON.stringify(err)}`)
          reject(err)
        })
      //reject returned when initialization failed
    })
  }
}

let dbUtil: DbUtil = new DbUtil()
export default dbUtil as DbUtil