enum CacheType {
  Local,
  Session
}

class Cache {
  storage: Storage
  constructor(type: CacheType) {
    this.storage = type === CacheType.Local ? localStorage : sessionStorage
  }
  setCache(key: string, value: any) {
    // 此处coderwhy不应该判断value,如果是存bool值就无效了
    if (value) {
      this.storage.setItem(key, JSON.stringify(value))
    }
  }
  getCache(key: string) {
    const value = this.storage.getItem(key)
    if(value) {
      return JSON.parse(value)
    }
  }
  removeCache(key: string) {
    this.storage.removeItem(key)
  }
  clear() {
    this.storage.clear()
  }

  setBool(key:string, value:boolean) {
    this.storage.setItem(key,JSON.stringify(value))
  }
  getBool(key: string) {
    const value = this.storage.getItem(key) ?? '0'
    return JSON.parse(value)

  }
}

export const localCache = new Cache(CacheType.Local)
export const sessionCache = new Cache(CacheType.Session)
