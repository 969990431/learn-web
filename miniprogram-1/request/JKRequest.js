export function jkRequest(params) {
  return new Promise((resolve, reject) => {
    wx.request({
      ...params,
      success: (res) => {
        resolve(res.data)
      },
      fail: (err) => {
        reject(err)
      }
    })
  })
}

class JKRequest {
  constructor(baseURL) {
    this.baseURL = baseURL
  }
  request(params) {
    const {
      url
    } = params
    return new Promise((resolve, reject) => {
      wx.request({
        ...params,
        url: this.baseURL + url,
        success: ((res) => {
          console.log(res.data);
          resolve(res.data)
        }),
        fail: ((err) => {
          reject(err)
        })
      })
    })
  }
  get(params) {
    return this.request({
      ...params,
      method: "get"
    })
  }
  post(params) {
    return this.request({
      ...params,
      method: "post"
    })
  }
}

export const JKRequestInstance = new JKRequest("http://codercba.com:1888/api/")
export const JKMusicRequestIns = new JKRequest("http://codercba.com:9002")