# Practice 2
==========================================================

## Введение в БД

### Сущности и связи. ER-модель.
-----------------------------
Так как мы уже имее формулировку задания (файл - ExampleTask), на его основе мы
можем выделить основные сущности:  
* Студент  
* Преподаватель  
* Группа  
* Предмет  
* Занятие  

 <i>так как сущность Студент и Преподаватель имеет одинаковые поля, их можно вынести
 в новую сущность Человек, атрибутами которой будут имя, фамили и признак. </i>  
Сущности могут иметь определенную взаимосвязь между друг другом. Например
мы знаем, что группа состоит из студентов, что группа ходит на занятия, которое
поясвящено конкретному предмету и ведет определенный преподаватель.

---------------------
### ER-модель
--------------------


Одним из вариантов представления структуры предметной области является диаграмма
сущностей и связей (ER-diagram).
Построим для начала **диаграмму, используя обозначения Питера Чена:**
![ОбозначенияПитераЧена](http://upload.akusherstvo.ru/image925319.png)

**Затем построим концептуальную ER-диагрмму:**
![Концептуальная](http://upload.akusherstvo.ru/image925333.png)

И перейдем к **физической ER-диагрмме (воспользуемся MySQL Workbench):**
![Концептуальная](http://upload.akusherstvo.ru/image925379.png)