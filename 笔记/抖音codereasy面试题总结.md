抖音codereasy面试题总结

### 1.var let const区别

作用域不同: var是全局作用域和函数作用域,后两者是块作用域

var定义的变量可以重新定义和修改,let不可以重新定义但可以修改,const都不可以

变量提升:都可以变量提升,在其作用域内定义后,会被变量提升到它作用域的顶部,var会被js引擎初始化为undefined,后两者提升后不会被初始化,访问会报错

### 2.点符号和[]访问属性的区别

点访问是访问的静态属性(必须是有效的js标识符),代码编译阶段已经确定的属性值;[key]访问是访问的动态属性,是在代码运行时通过计算来获取的属性,key可以是字符串,变量,也可以是表达式.

点访问不能访问数字开头的属性,[]可以访问数字key,因为js自动将数字转为了字符串

### 3. 输出结果?

`var test = 'hello'`

`(function test() {`

test='coder'

clg(test) //结果为function函数  test是个函数,函数名是不能修改的,在其作用域内,打印就是test函数(变量遮蔽,访问不到外部变量)

`})`()`

### 4.科里化函数?

是将可以传递多个参数的函数转换为传递单独或者固定个数的参数,转换后的函数可以被链式调用,f(a,b,c)转换为f(a)(b)(c),原理是比较参数的个数和给定的lenth,直接计算结果,没有达到lenth,返回新函数

`function foo(a,b,c) {`
`return a+b+c`
`}`

`//转换为科里化函数`
`function curry(f) {`
`return function curried(...args) {`
`if(args.length >= f.lenth) {//fn.length获取的是foo参数的个数`
`//如果参数个数大于原函数参数length,执行原函数`
`f.apply(this,...args)`
`}else {`
`//否则返回新函数`
`return function(...args2) {`
`//递归调用curried函数`
`return curried.apply(this,args.concat(args2))`
`}`
`}`
`}`
`}`

### 5.函数的length值

第一个默认参数前面有几个参数,就是几 

foo(a, b='123')  //foo.length = 1

foo(a='123',b)  //0

foo(a, ...arg) //1  剩余参数不计算到length

### 6.this是在定义时绑定,不是运行时

### 7.什么是纯函数?js中有哪些纯函数

相同的输入参数,永远是相同的输出

不会修改外部变量,包括全局变量,输入参数对象等

sort()不是纯函数,因为修改了原始数组,tosort()是纯函数,因为返回了新数组,原数组并没有改变.类似的还有toreverse(),tosplice()等

```
var a = 0

foo(b,c) {

a += 1

return a+b+c

}
//第一次调用 foo(1,1)输出3 第二次输出4 所以不是纯函数

```

### 8.如何设置私有属性?

ES12前用symbol,缺点:可以通过引用访问私有属性:obj[nameSymbol]

可以通过内部函数访问

```
let nameSymbol = Symbol("name")

let obj =  {

[nameSymbol]:"yjk"

}
```

ES12后使用#name,就是私有属性,可以通过内部函数访问

### 9.隐式转换,比较[0]==true,先将这个数组通过valueOf转为原始值(基本数据类型),如果不是原始值(基本类型),通过tostring转为字符串,数组转字符串相当于数组调用join方法,返回一个0就是false

### 10.Math.floor和parseInt区别

前者是向下取整,不管正负都取比他小的整数,例如-4.5就是-5,后者是正数就取比他小的,负数就是比他大的 

### 11.Object和Map区别

创建方式不同:前者可通过字面量创建,后者通过new Map()创建

key不同:前者key只能是字符串或者symbol类型 ,后者key可以是对象,函数,字符串类型

key顺序不同:前者顺序与插入顺序无关,后者顺序就是插入顺序

### 12.如何安全获取对象的属性

使用keyof myObject可以获取对象所有key的联合类型

### 13.watch函数中flush配置

Pre:默认值,dom更新前执行

post:更新之后执行,举例:监听页面滚动到某个位置在执行回调

sync:同步执行,响应式数据发生变化时立即执行

### 14.数组的索引可以是任意值,最终都会被转换为字符串,symbol没有被转换,因为symbol设计的初衷就是唯一性

### 15.什么是管道函数?

一个值通过一系列函数,前一个函数的返回值作为后一个函数的参数,最终输出结果

```js
function pipe(...fns) {

  return function(x) {

​    return fns.reduce((acc, fn)=>fn(acc), x)

  }

}

foo1 = function(x) {

 return x+1

}

foo2 = function(x) {

 return x*2

}

function output = pipe(foo1, foo2)

output(5)//(5+1)*2=12
```

### 16.watch和watchEffect区别

watch监听指定的源,默认第一次不执行,数据变化时执行;后者会自动收集依赖,默认执行一次.

watch可以设置imidiately让他立即执行,也可以设置deep,监听更深的对象的属性,watch也可以监听多个数据源

都可以通过flush配置在dom更新前后执行(pre,post)

### 17.解构的本质是什么?什么是生成器,迭代器

内部有一个生成器方法,生成器方法内部用yeild控制,通过生成器obj[Symbol.iterator]()方法返回一个迭代器,调用迭代器的next()方法依次获取其中的值,遇到yield就会终端执行,到最后一次next()会返回done





