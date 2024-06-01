import { JKMusicRequestIns } from "../request/JKRequest";

export function getBanner(type = 0) {
  return JKMusicRequestIns.get({
    url:"/banner",
    data: {
      type
    }
  })
}