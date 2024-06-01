import {
  JKMusicRequestIns
} from "../request/JKRequest";

export function getTomMV(id) {
  return JKMusicRequestIns.get({
    url: "/mv/url",
    data: {
      id
    }
  })
}

export function getMVInfo(mvid) {
  return JKMusicRequestIns.get({
    url: "/mv/detail",
    data: {
      mvid
    }
  })
}

export function getMVRelated(id) {
  return JKMusicRequestIns.get({
    url: "/related/allvideo",
    data: {
      id
    }
  })
}