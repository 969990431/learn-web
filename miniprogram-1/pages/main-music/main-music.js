import {
  getBanner
} from "../../services/music"
import querySelect from "../../utils/query-select"
import {
  throttle
} from "underscore"

const throttleQuerySelect = throttle(querySelect, 100)

Page({
  data: {
    banners: [],
    bannerHeight: 0
  },
  onLoad(options) {
    this.getBanner()
  },

  async getBanner() {
    const res = await getBanner()
    this.setData({
      banners: res.banners
    })
  },

  onBannerImageLoad() {
    this.getBannerHeight()
    
  },

  getBannerHeight() {
    throttleQuerySelect(".cover-image").then(res => {

      // console.log(res[0].height);
      this.setData({
        bannerHeight: res[0].height
      })
    })
  },

  gotoSearch() {
    wx.navigateTo({
      url: '/pages/detail-search/detail-search',
    })
  }
})