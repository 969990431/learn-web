// pages/index/index.js

const {
  jkRequest, JKRequestInstance
} = require("../../request/JKRequest");

Page({
  data: {
    houseList: [],
    currentPage:1
  },
  onLoad() {
    // jkRequest({
    //   url: "http://codercba.com:1888/api/home/houselist",
    //   data: {
    //     page: 1
    //   }
    // }).then((res) => {
    //   console.log(res);
    //   this.setData({
    //     houseList: res.data
    //   })
    // })

     this.getData()
     
  },

  onReachBottom() {
    console.log("到底了");
    this.getData()
  },

  getData() {
    JKRequestInstance.get({
      url:"home/houselist",
      data: {
        page: this.data.currentPage
      }
    }).then((res)=> {
      console.log(res);
      this.setData({
        houseList:[...this.data.houseList, ...res]
      })
      this.data.currentPage ++
    })   
  }
})