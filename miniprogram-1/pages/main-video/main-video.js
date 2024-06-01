const {
  JKMusicRequestIns
} = require("../../request/JKRequest")

// pages/main-video/main-video.js
Page({
  data: {
    videoList: [],
    offset: 0
  },
  onLoad: function (options) {
    this.getVideoData()
  },
  async onPullDownRefresh() {
    this.data.videoList = []
    this.data.offset = 0
    await this.getVideoData()
    wx.stopPullDownRefresh()
  },
  onReachBottom() {
    this.getVideoData()
  },

  navtoDetail(event) {
    wx.navigateTo({
      url: '/pages/detail-video/detail-video'+"?id="+event.currentTarget.dataset.item.id,
    })
  },

  async getVideoData() {
    const res = await JKMusicRequestIns.get({
      url: "/top/mv",
      data: {
        limit: 20,
        offset: this.data.offset
      }
    })

    if (!res.data) return
    this.data.offset += 20
    this.setData({
      videoList: [...this.data.videoList, ...res.data]
    })
  }

})