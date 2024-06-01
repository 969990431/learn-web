import { createPinia } from "pinia";
import type { App } from "vue";
import useLoginStore from "./login/login";

export const pinia = createPinia()

export function registerStore(app:App) {
  app.use(pinia)
  const loginStore = useLoginStore()
  loginStore.loadLocalCacheAction()
}