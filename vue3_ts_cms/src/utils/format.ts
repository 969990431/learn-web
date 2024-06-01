import dayjs from "dayjs"

export function formatUTC(timeString: string, format = 'YYYY-MM-DD HH:mm:ss') {
  const formatTime = dayjs(timeString).format(format)
  return formatTime
}
