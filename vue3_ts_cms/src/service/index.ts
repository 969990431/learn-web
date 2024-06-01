import { localCache } from '@/utils/cache'
import { BASE_URL, TIMEOUT } from './config/config'
import JKRequest from './request'
import { TOKEN } from '@/global/constants'
// 可以单独拦截的axios实例
const jkRequest = new JKRequest({
  baseURL: BASE_URL,
  timeout: TIMEOUT,
  interceptors: {
    requestSuccessFn: (config) => {
      const token = localCache.getCache(TOKEN)
      if (token) {
        config.headers.Authorization = token
      }
      return config
    },
    requestFailureFn: (err) => {
      return err
    },
    responseSuccessFn(res) {
      return res
    },
    responseFailueFn(err) {
      return err
    }
  }
})

export default jkRequest
