vue2响应式原理语言组织:

视频day68-1214,vue中有多个对象,每个对象都有各自的属性,当我们需要某些对象或者其属性实现响应式时,vue底层是有一个总的objMap,这个objMap的映射关系是每个obj对应一个Map,这个obj的Map里边的映射关系是每个obj的每个key对应其相应的依赖对象(dep),我们可以根据从objMap.get(obj)获取对应的obj所对应的Map,然后再根据Map.get(key)来获取某个key对应的依赖(dep),然后这个依赖再去执行相应的需要做出响应的方法,执行过程是在obj的defineProperty方法里的set方法中,当obj对象的属性发生变化时,set方法中根据key获取对应的dep对象,然后通过for循环执行dep中的依赖方法,形成响应式,((render函数中h函数中的依赖发生变化,就会重新调用render函数,形成响应式))

![](/Users/yangjiakui/Desktop/截屏2024-04-17 12.40.14.png)

![截屏2024-04-17 13.05.13](/Users/yangjiakui/Desktop/截屏2024-04-17 13.05.13.png)

![截屏2024-04-17 13.11.19](/Users/yangjiakui/Desktop/截屏2024-04-17 13.11.19.png)

![截屏2024-04-17 13.20.40](/Users/yangjiakui/Desktop/截屏2024-04-17 13.20.40.png)

![](/Users/yangjiakui/Desktop/截屏2024-04-17 14.28.23.png)