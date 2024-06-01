import {
  getMVInfo,
  getMVRelated,
  getTomMV
} from "../../services/video"

Page({
  data: {
    id: 0,
    url: "",
    info: {},
    related: []
  },
  onLoad(options) {
    this.data.id = options.id
    this.getTopMvUrl()
    this.getDetailInfo()
    this.getMVRelated()
  },

  async getTopMvUrl() {
    const res = await getTomMV(this.data.id)
    this.setData({
      url: res.data.url
    })
  },
  async getDetailInfo() {
    const res = await getMVInfo(this.data.id)
    this.setData({
      info: res.data
    })
  },
  async getMVRelated() {
    const res = await getMVRelated()
    this.setData({
      related: res.data
    })
  }

})