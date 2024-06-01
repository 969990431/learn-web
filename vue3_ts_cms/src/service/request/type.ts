import type { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from 'axios'

export interface JKInterceptors<T = AxiosResponse> {
  requestSuccessFn?: (config: InternalAxiosRequestConfig) => InternalAxiosRequestConfig
  requestFailureFn?: (err: any) => any
  responseSuccessFn?: (res: T) => T
  responseFailueFn?: (err: any) => any
}
export interface JKAxiosRequestConfig<T = AxiosResponse> extends AxiosRequestConfig {
  interceptors?: JKInterceptors<T>
}
