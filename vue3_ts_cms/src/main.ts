import { createApp } from 'vue'
import App from './App.vue'
import 'normalize.css'
import './assets/css/index.less'
import router from './router'
import { registerStore } from './store'
import { registerIcons } from './global/register-icons'
import 'animate.css'

const app = createApp(App)

app.use(registerIcons).use(registerStore).use(router).mount('#app')
