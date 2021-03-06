# User Story: план действий для разработчика

![Main icon](images/user-story.png)

Процесс разработки ПО состоит из нескольких последовательных этапов. Первоначальным и в итоге во многом определяющим конечный результат является написание User Story.

**Гибкая методология разработки** (Agile software development) — серия подходов к разработке ПО, ориентированные на кооперацию между всеми членами проекта и адаптивность процесса разработки к неизбежным изменениям.
<u>Существует несколько методик:</u>
* Экстремальное программирование
* DSDM
* Scrum
* FDD

Большинство гибких методологий нацелены на минимизацию рисков путём сведения разработки к серии коротких циклов, называемых итерациями,в результате которых команда сдает готовый проект в миниатюре. По окончании каждой итерации команда выполняет переоценку приоритетов разработки. Также важное отличие Agile-методов в том, что упор делается на общение внутри команды. Основой agile-методов является рабочий продукт. Отдавая предпочтение непосредственному общению, agile-методы уменьшают объём письменной документации.

## Что такое User Story?
User Story — это руководство к действиям по созданию, оптимизации и продвижению продукта. Функции User Story успешно заменяют функциональные спецификации. <i> Вместо того, чтобы тратить время на написание, согласование и обновление спецификаций о требованиях к будущему продукту, заказчик  делает короткие высказывания о том, как пользователь будет пользоваться будущей системой. В ходе обсуждений начальные идеи, заложенные в первоначальных высказываниях, обрастают деталями. </i>

Плюсы User Story по сравнению с спецификациями:

1. Во время создания пользовательской истории разработчики выявляют все слабые стороны продукта и продумывают в формате живого общения, как их решить еще до стадии начала разработки.
2. User Stories создаются в том числе для тестировщиков. Они содержат пользовательские сценарии, которые станут основой тестирования после сдачи проекта.



## Какие требования выдвигаются к написанию пользовательских историй?
* присутствие максимального количества заинтересованных человек
* описание целевой аудитории (четко обозначить роли)
>В качестве… (описание представителя ЦА, его роль в приложении), он получает… (действия в приложении) для… (цели его действий в приложении).

![](images/better-user-story.png)

* системаные требования

Хорошая User Story должна соответствовать модели «INVEST»:
1. Внутренне независимой (Independent) - Многие из пользовательских историй по мере наращивания функциональности продукта обретают зависимости, но все же каждый кусочек предоставляет независимую ценность и продукт может быть потенциально доставлен, если разработка будет приостановлена в любой из этих точек.
>Пример:  
1) Как администратор я могу установить правила безопасности пользовательских паролей так, что пользователи будут обязаны создавать и поддерживать безопасные пароли, поддерживая безопасность системы.  
2) Как пользователь я должен следовать правилам безопасности паролей, установленным администратором, чтобы поддерживать безопасность моей учетной записи.    
Здесь стори потребителя зависит от стори администратора – поэтому не несет независимой полезности.  
Путем пересмотра пользовательских историй (и архитектуры системы) мы можем удалить зависимости переразбив стори иным способом – в нашем случае по типу политики безопасности и соединяя воедино установку политики и ее применение в каждой стори:  
1') Как администратор я могу установить период истечения действия пароля, таким образом пользователи будут обязаны периодически менять пароли.  
2') Как администратор я могу установить характеристики сложности пароля, так что пользователи будут обязаны создавать пароли, которые сложно подобрать.  
Теперь каждая история может существовать сама по себе и может быть реализована, оттестирована и доставлена вполне независимо.

2. Структурно изменчивой (Negotiable)
>

3. Ценностно ориентированной (Valuable);
4. Учитывающей критерии оценки каждого этапа (Estimable);
5. Оптимизированной по времени (рассчитаннной на 1 неделю) (Small) ;
6. Проверяемой (легко оценимой в результате) (Testable).

![](images/dilbert-userstories.jpg)

## Рекомендации для написания правильных пользовательских историй

* Написание пользовательской истории – это своеобразный «мозговой штурм», который следует использовать с максимальной выгодой для продукта. Во время ее написания должны быть заданы все вопросы и получены все ответы. Менять что-то на стадии разработки и тем более после сдачи проекта крайне сложно и затратно.
* Вместо одной большой пользовательской истории лучше написать несколько более мелких и точных. Т.е. крупные и громоздкие истории необходимо фрагментировать с учетом конкретики задач, разбивать на более детализированные и мелкие.
* Оптимальный размер User Story (следует ли ее разбивать на под-этапы или же объединять несколько в одну) определяется просто: на разработку должно уходить от 0,5 до 4 «идеального дня». Если уходит больше четырех, то имеет смысл фрагментировать. Если меньше – надо объединять.
* Обязательно прописывайте в истории критерии приемки, поскольку при их наличии тестировать соответствие готового продукта и истории намного легче.
Хотя в большинстве случаев формат пользовательской истории должен соответствовать основным требованиям, но в некоторых случаях, если, к примеру, речь идет о дизайне, можно ограничиться более свободным форматом в виде скетчей или набросков.
* Следующий совет может кого-то и удивит, но его практическая польза подтверждалась неоднократно. В процессе работы над созданием User Story желательно использовать небольшие бумажные карточки. При командной работе этот метод просто незаменим, поскольку способствует динамике процесса. Готовую пользовательскую историю также не следует убирать с глаз долой в недра ноутбука или письменного стола. Повесьте их на стену, это будет очередной мотиватор для выполнения поставленной задачи.

## Что делать не стоит?
* Чрезмерно детализировать. Из-за слишком подробной, описанной в деталях User Story, процесс ее обсуждения командой может быть сведен к минимуму, что не всегда хорошо для поиска оптимального решения поставленной задачи. Всегда нужно оставлять место для творчества, а формальный подход с ним, как известно, несовместим.
* При всех соблазнах сделать это пропускать обсуждение ни в коем случае не стоит. Даже если, на первый взгляд, все совершенно очевидно. Именно в процессе обсуждения можно, как говорится, расставить все точки над і.
* Формат User Story не предполагает наличие технических задач.

Необходимо отметить, что User Story не является чем-то нерушимым и не приемлющим каких-либо изменений. В принципе, при необходимости заказчик может добавлять новые пользовательские истории, менять приоритеты и т.д. Это вполне допустимо. При этом разработчик со своей стороны обязан объяснить заказчику, чем чревато будет предложенное изменение или добавление. Живое общение на этой стадии — залог успеха в будущем. Ведь создание успешного мобильного приложения – это блестящая идея + не менее блестящее ее воплощение. А для последнего значение правильно написанной User Story вряд ли можно переоценить.

Мы посоветовались с экспертами в области мобильной разработки и выяснили, как с их точки зрения лучше работать с историей.

## Анна Минникова, Гиперболоид, сертифицированный Scrum Professional, работала продакт и проджект менеджером в крупнейших геомобильных приложениях СНГ, сейчас занимается lean коучингом.

### 1. Как правильно написать User Story?

Командой. Причем команда обязательно должна включать в себя менеджера продукта/клиента/стейкхолдера или даже конечных пользователей вашего продукта. Пишите user story не для того, чтобы получить формальные «требования», а чтобы вытащить на свет все важные для вашего продукта, бизнеса и пользователей нюансы.

Обязательно формулируйте персоны вашего продукта до начала работы над user story. Это поможет вам лучше прочувствовать пользовательские нужды/боли/желания и лучше понять, для кого вы проектируете ваш продукт.

Ваша идеальная история должна быть написана по такому образцу:
> Как, <роль пользователя>, я <что-то хочу получить>, <с такой-то целью>


Сейчас вы сформулировали бизнес-ценность для пользователя вашего продукта. Но прелесть пользовательской истории в том, что она формулирует не только бизнес-ценность, но и требования для разработки и тестирования. К этой простой формулировке вы можете добавить критерии приемки, технические заметки, описание обработки ошибок, которые суммируют все задачи, которые вам нужно сделать.

Вот как в укороченном виде выглядела пользовательская история в одном из моих проектов:
Как водитель с загоревшейся лампочкой бензина я хочу быстро найти ближайшую хорошую заправку, чтобы заправиться качественным бензином.

Критерии приемки:

1. Как водитель с загоревшейся лампочкой я могу просмотреть все ближайшие заправки.
2. Как … я могу выбрать заправки подходящих мне брендов АЗС.
3. Как … я могу видеть ближайшие заправки выбраннах брендов списком.
4. Как … я могу видеть ближайшие заправки выбранных на карте.

### 2. Как объективно оценить ее полезность и востребованность?
Пользовательские истории полезны, если вы понимаете, что с написанием пользовательской истории для самого простого проекта вы ступили на тяжелый путь сомнений: «зачем мы делаем наш продукт»?, «точно ли нужна эта фича в продукте?», «да пользователей с такими потребностями днем с огнем не сыщешь», «кто будет пользоваться тем, что мы делаем?». Эти вопросы не очень приятны, но честные ответы на них помогут вам спроектировать лучший продукт.

### 3. Чего делать не стоит при работе с User Story?
Писать их в гордом одиночестве или поручать написать пользовательские истории, к примеру, менеджеру проекта. Если, конечно, вы не являетесь конечным core пользователем продукта, который вы разрабатываете :)

Также не очень здорово писать объемные, большие истории. Если ваша история не вмещается в стандартную итерацию вашей команды (я надеюсь, что это максимум 4 недели:), то она слишком велика и стоит задуматься, как можно ее поделить на несколько.

И самые главные грабли – писать пользовательские истории, которые пойдут в разработку, до того, как вы прошли через процесс customer development. Хорошо сделать это для общего понимания того, что пользователь, по вашему мнению, будет делать с продуктом.

Но пользовательские истории нужно писать не только для того, чтобы выразить ваше мнение о продукте или мнение заказчика. Они должны выражать мнение тех, кто будет покупать и пользоваться продуктом (не забудьте о том, что это не только конечные пользователи, но и те, кто оказывают влияние на совершение покупки. К примеру, конечными пользователями игр часто являются дети, но покупают их родители).

Поэтому для того, чтобы написать ценную и реалистичную пользовательскую историю, вам нужно получить максимум информации о ваших будущих пользователях:
* считают ли они проблему, которую решает ваш продукт, достаточно серьезной (к примеру, все * * игры решают серьезную проблему – убийство времени и побег от скуки);
* как они решают свои проблемы сейчас;
* какие заменители или конкуренты есть у вашего продукта;
* и еще массу важных моментов, которые стоит узнать до того, как вы написали гору кода :).


## Selet Team
Определим ЦА:  

1) **Гости** (незарегистрированные пользователи)  
* Я, как гость, хочу **увидеть список текущих проектов**, чтобы ознакомиться с актуальными проектами.
* Я, как гость, хочу **перейти на страницу проекта**, чтобы получить больше информации о нем.
* Я, как гость, хочу **подать заявку на участие в проекте**, чтобы мои данные экспортировались руководителю.
- требуется **регистрация**, ввод паспорт данных и доп полей проекта.

2) **Пользователи** (зарегестрированные пользователи)  
* Я, как пользователь, хочу **видеть список текущих проектов**, чтобы ознакомиться с актуальными проектами.  
* Я, как пользоватлеь, хочу **перейти на страницу проекта**, чтобы получить больше информации о нем.
* ? Я, как пользователь, хочу **видеть список участников проекта**, чтобы познакомиться с ними.
* Я, как пользователь, хочу **подать заявку на участие в проекте**, чтобы мои данные экспортировались руководителю.
 - если нет паспортных данных, необходимо ввести
 - если есть доп поля в анкете участника, необходимо ввести
* Я, как пользователь, хочу иметь возможность **редактировать свою анкету**, чтобы менять информацию о себе.
* Я, как пользователь, хочу иметь возможность **удалить свою анкету**, чтобы больше не быть участником Салят.
* ? Я, как пользователь, хочу иметь возможность **увидеть список завершенных проектов**, в которых я учавствовал, чтобы вспомнить.
* ? Я, как пользователь, хочу иметь возможность **увидеть список проектов, на которые я подал заявку, но ее еще не одобрили**.
* Я, как пользователь, хочу иметь возможность **поделиться своим решением учавствовать в проекте с друзьями в соц. сети**, чтобы они тоже знали и поддержали меня.
* Я, как пользователь, хочу подать заявку на роль руководителя, чтобы иметь возможность создавать проекты.

3) **Руководители** (пользователи, которым дали права на управление проектами)

* Я, как руководитель, хочу **создавать проекты**, чтобы пользователи ознакомились с ними.  
* Я, как руководитель, хочу **добавлять доп поля в анкету**, которую заполняют потенциальные участники, чтобы иметь нужную информацию о них.
* ? Я, как руководитель, хочу **помечать проекты завершенными**, чтобы пользователи больше не имели возможность подать на него заявку.
* Я, как руководитель, хочу **удалять свои проекты**, чтобы у них больше не было персональной страницы.
* Я, как руководитель, хочу **одобрять заявку**, чтобы пользователь стал участником моего проекта.
* Я, как руководитель, хочу **отвергать заявку**, чтобы пользователь не участвовал в моем проекте.
* Я, как руководитель, хочу **редактировать информацию о проекте**, чтобы своевременно обновлять информацию для пользователей.
* Я, как руководитель, хочу **видеть список созданных мной проектов**, чтобы просматривать их.
* Я, как руководитель, хочу **открывать персональную страницу проекта**, чтобы работать с ним.
* Я, как руководитель, хочу **просматривать список пользователей**, подавших заявку на участие в проекте, чтобы одобрять или отклонять заявки.
* ? * Я, как руководитель, хочу по окончанию проекта **награждать участников достижениями**, чтобы мотивировать их.

4) **Администратор**

* Я, как администратор, хочу **просматривать список пользователей**, чтобы познакомиться с ними.
* Я, как администратор, хочу **просматривать портфолио пользователей**, чтобы иметь больше информации о них.
* Я, как администратор, хочу **редактировать портфолио пользователей**, чтобы следить за правильностью заполнения.
* Я, как администратор, хочу **редактировать достижения пользователей**, чтобы награждать или отменять награждение.
* Я, как администратор, хочу **удалять пользователя**, чтобы обеспечивать нормальную работу салят.
*  Я, как администратор, **хочу назначать пользователя руководителем**, чтобы он мог создавать свои проекты.
*  Я, как администратор, хочу **разжаловить руководителя до обычного пользователя**, чтобы он больше не мог создавать свои проекты.



#### Links
https://ru.wikipedia.org/wiki/ Пользовательские_истории на вики  
http://apps4all.ru/post/06-17-15-andrash-gusti-begemot-begemot-yuzerstori-eto-kontseptualno-prosto-i-modnohttps://habrahabr.ru/company/luxoft/blog/82066/ - Основы пользов историй (3 части)  
http://devprom.ru/news/История-пользователя-User-Story  
http://2tickets2dublin.com/how-to-write-good-user-stories-part-1/ - как писать хорошие польз истории  
https://megamozg.ru/company/friifond/blog/8686/  
http://apptractor.ru/develop/user-story-plan-deystviy-dlya-razrabotchika.html - User Story: план действий для разработчика  
http://agilerussia.ru/practices/%D0%BE%D0%B1-agile-%D0%BF%D0%BE-%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%B8-user-stories/ Agile по-русски
http://www.enter-agile.com/2010/02/user-story-primer-invest.html Основы польз Историй
http://agilevision.blogspot.ru/2013/07/user-stories.html как писать польз истории
