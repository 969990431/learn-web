# ts面试题

#### 1.什么是联合类型?什么是交叉类型?

在 TypeScript 中，联合类型（Union Types）和交叉类型（Intersection Types）是两种常用的高级类型。

1. **联合类型（Union Types）**： 联合类型表示一个值可以是几种不同类型之一。用竖线 `|` 分隔每个类型来创建联合类型。例如：

   ```
   typescript
   Copy code
   let x: number | string;
   x = 10; // 合法
   x = "hello"; // 合法
   x = true; // 错误，布尔值不是 number 或 string 类型
   ```

   在上面的示例中，变量 `x` 可以是 `number` 类型或 `string` 类型，但不能是其他类型。

2. **交叉类型（Intersection Types）**： 交叉类型表示一个值同时具有多种类型的特性。用 `&` 符号连接多个类型来创建交叉类型。例如：

   ```
   typescript
   Copy code
   interface A {
       name: string;
   }
   
   interface B {
       age: number;
   }
   
   type AB = A & B;
   
   let obj: AB = {
       name: "John",
       age: 30
   };
   ```

   在上面的示例中，`AB` 类型是同时具有 `A` 和 `B` 接口的特性。因此，`obj` 变量必须具有 `name` 属性和 `age` 属性。

总结：

- 联合类型用于表示一个值可以是多种类型之一。
- 交叉类型用于表示一个值同时具有多种类型的特性。

#### 2.类型别名(Type)和接口类型(Interface)有什么关系和区别?

在 TypeScript 中，类型别名（Type Alias）和接口类型（Interface）都是用来定义自定义类型的工具，它们有一些相似之处，但也有一些区别。

### 关系：

1. **相似性**：
   - 类型别名和接口类型都可以用来定义自定义类型。
   - 它们都可以表示对象、函数、联合类型、交叉类型等。
2. **互相转换**：
   - 在某些情况下，类型别名和接口类型是可以互相转换的。例如，可以使用类型别名定义一个对象类型，然后将其转换为接口类型，反之亦然。

### 区别：

1. **语法**：
   - 类型别名使用 `type` 关键字进行定义，而接口类型使用 `interface` 关键字进行定义。
2. **可扩展性**：
   - 接口类型可以被扩展，即可以通过 `extends` 关键字来继承其他接口类型。而类型别名目前不支持继承其他类型。
3. **使用场景**：
   - 通常情况下，当要描述一个对象的形状时，使用接口类型是比较合适的，因为接口提供了更清晰的语义，并且可以被继承扩展。
   - 当需要给一个复杂类型起一个简短易记的名字时，或者需要使用联合类型、交叉类型等高级类型时，使用类型别名是比较方便的。

举例来说，如果要描述一个简单的对象形状，可以使用接口类型：

```
typescript
Copy code
interface Person {
    name: string;
    age: number;
}
```

如果要给一个复杂的类型起一个名字，可以使用类型别名：

```
typescript
Copy code
type ComplexType = {
    data: number[];
    processData: (input: number) => number;
};
```

总的来说，接口类型更适用于描述对象的形状和结构，而类型别名更适用于给复杂类型起一个简短易记的名字。

#### 3.什么是TypeScript类型缩小?有啥用?

TypeScript 类型缩小（Type Narrowing）是指在 TypeScript 中通过条件语句或者其他方式，缩小（或者说确定）某个变量的类型范围。这个过程通常发生在编译器能够确定变量在某一分支上具有特定类型的情况下。

类型缩小的主要用途是在编译时增强类型的精度，从而使编译器能够更准确地推断变量的类型，提供更好的代码提示和类型检查。这有助于减少错误，并提高代码的可维护性和可读性。

以下是几种常见的 TypeScript 类型缩小方式和用法：

1. **类型保护（Type Guards）**： 使用条件语句来检查变量的类型，以确定它的具体类型。例如：

   ```
   typescript
   Copy code
   function isString(value: any): value is string {
       return typeof value === "string";
   }
   
   let x: any = "hello";
   if (isString(x)) {
       console.log(x.toUpperCase()); // 在这个分支上，x 被缩小为 string 类型
   }
   ```

2. **使用 instanceof 运算符**： 在面向对象的代码中，使用 `instanceof` 运算符来检查对象的类型。例如：

   ```
   typescript
   Copy code
   class Animal {}
   class Dog extends Animal {}
   
   function makeSound(animal: Animal) {
       if (animal instanceof Dog) {
           animal.bark(); // 在这个分支上，animal 被缩小为 Dog 类型
       } else {
           animal.makeNoise(); // 在这个分支上，animal 仍然是 Animal 类型
       }
   }
   ```

3. **nullish 合并运算符（??）**： 使用 nullish 合并运算符可以帮助缩小 null 或 undefined 的类型。例如：

   ```
   typescript
   Copy code
   let input: string | undefined;
   let result = input ?? "default"; // 在这个分支上，input 被缩小为 string 类型
   ```

通过使用类型缩小，我们可以更精确地描述变量的类型，提高代码的可靠性和可读性。