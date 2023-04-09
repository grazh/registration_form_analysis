# Аналитика новой страницы регистрации.

Для начала нужно определиться с метриками, по которым мы будем оценивать качество новой страницы с регистрацией. Стоит отметить, что пользовательский опыт отличается только у пользователей, которые зашли на страницу с регистрацией. Поэтому исследование их поведения до того, как они зашли на регистрационную страницу, не входит в рамки данного исследования.

Теперь нужно определиться, что является целевым действием для бизнеса. В данном случае это рост клиентской базы, поэтому самой верхнеуровневой метрикой будет являться конверсия в успешную регистрацию. На нее косвенно будет влиять количество попыток регистрации. Также важной метрикой будет являться активность зарегистрировавшхся пользователей на сайте (количество заходов на страницы сайта на пользователя), она поможет оценить насколько в среднем изменяется активность аудитории, зарегистрировавшейся новым способом.

## Перед анализом можем предположить связь изменения выбранных метрик с изменениями новой страницы с регистрацией:

1. если **количество попыток регистрации** выросло, то вероятно в форме есть баг и это негативно влияет на конверсию в успешную регистрацию

**H0:** количество попыток регистрации в тестовой группе меньше, чем в контрольной

2. если **конверсия в успешную регистрацию** упала, то значит новый способ стал более сложным для пользователей (как вариант, он может содержать баг, из-за которого части пользователей вообще не доступна регистрация). Если выросла, то наоборот на сайте стало регистрироваться больше пользователей.

**H1:** конверсия в успешную регистрацию в тестовой группе больше, чем в контрольной

3. теперь нужно понять как изменилось качество новых пользователей, например, новая регистрация могла обрезать ботов и парсеры (например, введением капчи) и качество аудитории тогда выросло, или наоборот сократить количество активных клиентов (например, поле с адресом проживания стало обязательным и часть активных пользователей перестала регистрироваться, чтобы защитить свои данные). Будем проверять это с помощью метрики “**количество заходов на страницы сайта на пользователя**”.

**H2:** конверсия в успешную регистрацию в тестовой группе больше, чем в контрольной

## Далее перейдем к анализу датасета:

Проверим данные на дубли - оказывается есть 34к дублей, избавимся от них. Посмотрим на значения и проверим на пропуски. В датасете отсутствуют пропуски. Данные об ивентах представлены с 1 января по 7 апреля 2021 года. Всего представлено 5 типов ивентов:

- landing - заход на разводящую
- main - заход на главную
- registration - регистрация по старой форме
- registration_new - регистрация по новой форме
- login - заход в личный кабинет

Далее удаляем из датасета все строки, описывающие пользователей, которые по тем или иным причинам не дошли до формы регистрации. Остается 277 815 наблюдений.

## Проверка гипотез

**H0:** сравним среднее количество попыток регистрации в тестовой и контрольной группых, для этого посчитаем среднее количество попыток на пользователя в каждой группе и проверим с помощью t-test’а. 

Различия между тестом (2.14) и контролем (2.08) в среднем количестве попыток регистрации не являются статзначимыми.
p-value: 0.35

Значит форма статзначимо не сократила количество заходов на страницу с регистрацией.

**H1:** сравним конверсию в успешную регистрацию. Успешной регистрацией будем считать такую регистрацию, после которой пользователь зашел на главную страницу.

Различия между тестом (0.29) и контролем (0.27) в конверсии в успешную регистрацию являются статзначимыми.
p-value: 0.03

Значит форма повысила конверсию в успешную регистрацию.

**H3:** проверим, если пользователи, прошедшую новую форму регистрации стали более или менее активными, чем в контроле.

Различия между тестом (11.39) и контролем (11.69) в среднем количестве посещений разделов сайта не являются статзначимыми.
p-value: 0.84

Значит, новая форма регистрации не ухудшила качество регистрирующихся пользователей.

## Итог исследования

Таким образом, на основе доступных данных удалось установить, что новая форма регистрации повысила конверсию в успешную регистрацию, при этом не испортив метрики активности аудитории и количества попыток регистрации.


![Task](https://github.com/grazh/registration_form_analysis/blob/main/task.png)
