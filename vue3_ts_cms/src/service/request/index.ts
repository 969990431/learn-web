import axios from 'axios'
import type { AxiosInstance } from 'axios'
import type { JKAxiosRequestConfig } from './type'

class JKRequest {
  instance: AxiosInstance
  constructor(config: JKAxiosRequestConfig) {
    this.instance = axios.create(config)
    this.instance.interceptors.request.use(
      (config) => {
        // 全局请求成功拦截
        return config
      },
      (err) => {
        // 全局请求失败拦截
        return err
      }
    )
    this.instance.interceptors.response.use(
      (res) => {
        // 全局响应成功拦截
        return res.data
      },
      (err) => {
        // 全局响应失败拦截
        return err
      }
    )

    // if (config.interceptors) {
    this.instance.interceptors.request.use(
      config.interceptors?.requestSuccessFn,
      config.interceptors?.requestFailureFn
    )
    this.instance.interceptors.response.use(
      config.interceptors?.responseSuccessFn,
      config.interceptors?.responseFailueFn
    )
    // }
  }

  request<T = any>(config: JKAxiosRequestConfig<T>) {
    // return this.instance.request(config)
    return new Promise<T>((resolve, reject) => {
      this.instance
        .request<any, T>(config)
        .then((res) => {
          resolve(res)
        })
        .catch((err) => {
          reject(err)
        })
    })
  }

  get<T = any>(config: JKAxiosRequestConfig<T>) {
    return this.request({ ...config, method: 'GET' })
  }
  post<T = any>(config: JKAxiosRequestConfig<T>) {
    return this.request({ ...config, method: 'POST' })
  }
  delete<T = any>(config: JKAxiosRequestConfig<T>) {
    return this.request({ ...config, method: 'DELETE' })
  }
  patch<T = any>(config: JKAxiosRequestConfig<T>) {
    return this.request({ ...config, method: 'PATCH' })
  }
}

export default JKRequest
