# SDL Lab1

## Содержимое проекта
  - dump
    - backup.sql (резервная копия хранилища данных, используемого в проекте)
  - nginx
    -  nginx.conf (главный конфигурационный файл nginx)
  - templates
    - index.html (файл вёрстки веб-сайта)
  - docker-compose.yml (файл конфигурации сети контейнеров)
  - Dockerfile (файл с инструкциями, необходимыми для создания образа контейнера)
  - main.py (файл веб-приложения на Flask)
  - requirements.txt (файл с необходимым набором модулей и пакетов)

## Используемые контейнеры
  - PostgreSQL (postgres_1lab_docker)
  - Flask (python_1lab_docker)
  - Nginx (nginx_1lab_docker)

## Запуск проекта
  1. Установить Docker Desktop
  2. Открыть командную строку из директории скачанного проекта
  3. Выполнить команду
     ```
     docker-compose up
     ``` 
  4. В pgAdmin создать новый сервер с настройками
     ```
     hostname: localhost
     port: 5509
     database: db_person
     username: earth04
     password: s3IsL49E
     ``` 
  5. Создать новую таблицу "Person" c колонками (или восстановить бэкап backup.sql из папки dump):
     ```
     id (int)
     full_name (varchar(100))
     group_number (varchar(100))
     ```
  6. Заполнить таблицу "Person" информацией
  7. Сделать запрос в браузере по адресу:
     ```
     http://127.0.0.1/1
     ```

## Результаты выполнения проекта
  - Скриншот работоспособности веб-сайта
    
    ![Рисунок1](https://github.com/marininvp/SDL/assets/71025913/f121e894-1bfc-45b0-8d8f-288ec83d09b2)
    
  - Скриншот хранилища данных
    
    ![screen_2](https://github.com/marininvp/SDL/assets/71025913/3c630cee-9bb0-4659-bcfd-8e5b89468170)

## Обнаруженные уязвимости (сканирование Docker Scout)
1. В контейнере PostgreSQL
     
- Общий результат
     
  ![Рисунок3](https://github.com/marininvp/SDL/assets/71025913/426b7c1f-6eac-4060-8951-2a0d354233cf)
     
- Наиболее значимые уязвимости по оценкам сканера
  - Уязвимость 1
    - Код уязвимости:
      ```
      CVE-2023-24540
      ``` 
    - Описание уязвимости:
        
      Не все допустимые пробельные символы JavaScript считаются пробельными. Шаблоны, содержащие пробельные символы за пределами набора символов "\t\n\f\r \u0020\u2028\u2029" в контекстах JavaScript, которые также содержат действия, могут не подвергаться надлежащей очистке во время выполнения.
          
    - Устранение уязвимости:
          
      Избегание использования пробельных символов, которые не входят в набор "\t\n\f\r \u0020\u2028\u2029", в особенности в шаблонах, где они могут быть введены пользователем или внешними источниками
           
    - Скриншот отображения уязвимости
        
      ![Рисунок4](https://github.com/marininvp/SDL/assets/71025913/abaa3b26-2905-4f03-8a03-75b1528527f3)
          
  - Уязвимость 2
    - Код уязвимости:
      ```
      CVE-2023-24538
      ```  
    - Описание уязвимости:
          
      Шаблоны неправильно рассматривают обратные кавычки (`) в качестве разделителей строк Javascript и не экранируют их, как ожидалось. Обратные кавычки используются, начиная с ES6, для литералов шаблона JS. Если шаблон содержит действие шаблона Go внутри литерала шаблона Javascript, содержимое действия можно использовать для завершения литерала, вводя произвольный код Javascript в шаблон Go. Поскольку шаблонные литералы ES6 довольно сложны и сами по себе могут выполнять интерполяцию строк, было принято решение просто запретить использование внутри них действий шаблона Go (например, "var a = {{.}}"), поскольку не существует явно безопасного способа разрешить такое поведение. Здесь используется тот же подход, что и github.com/google/safehtml. С помощью fix, Template.Parse возвращает ошибку при обнаружении шаблонов, подобных этому, с кодом ошибки, равным значению 12. Этот код ошибки в настоящее время не экспортирован, но будет экспортирован в выпуске Go 1.21. Пользователи, которые полагаются на предыдущее поведение, могут повторно включить его, используя флаг GODEBUG jstmpllitinte
           
    - Устранение уязвимости:
          
      Отредактировать код в части избегания использования обратных кавычек в шаблонах Go, если такие шаблоны содержат действия внутри литералов шаблона JavaScript
            
    - Скриншот отображения уязвимости
        
      ![Рисунок5](https://github.com/marininvp/SDL/assets/71025913/6c7653a1-2f4b-4d36-8084-c40414fabe06)
          
  2. В контейнере Flask
     
    Общий результат (включая скриншот Уязвимости 1)
     
     ![Рисунок6](https://github.com/marininvp/SDL/assets/71025913/7dd088bc-cb71-4339-be3f-d0e29bc29d7a)
     
     - Уязвимость 1
      - Код уязвимости:
        ```
        CVE-2018-20225⁠
        ```  
      - Описание уязвимости:
        
        В pip (все версии) обнаружена проблема, поскольку он устанавливает версию с наибольшим номером версии, даже если пользователь намеревался получить закрытый пакет из частного индекса. Это влияет только на использование параметра `--extra-index-url`, и для его использования требуется, чтобы пакет еще не существовал в общедоступном индексе (и, таким образом, злоумышленник может поместить туда пакет с произвольным номером версии).
        
      - Устранение уязвимости:
        
        Обновить pip до последней версии. Новые версии pip могут содержать исправления.
        ```
          pip install --upgrade pip
        ``` 
  3. В контейнере Nginx
     
    Общий результат
     
     ![Рисунок7](https://github.com/marininvp/SDL/assets/71025913/ae38819a-8da3-48f2-b9bf-3d99f49a5215)
     
    Наиболее значимые уязвимости по оценкам сканера
      - Уязвимость 1
        - Код уязвимости:
          ```
          CVE-2023-52425⁠
          ```  
        - Описание уязвимости:
          
          libexpat до версии 2.5.0 допускает отказ в обслуживании (потребление ресурсов), поскольку в случае большого токена, для которого требуется многократное заполнение буфера, требуется много полных повторных запросов.
          
        - Устранение уязвимости:
          
          Обновить libexpat до версии 2.5.0 или более новой. В новых версиях libexpat исправлены уязвимости, включая уязвимость, описанную в CVE-2023-52425.
          ```
            sudo apt update
            sudo apt install libexpat-dev
          ```  
        - Скриншот отображения уязвимости
        
          ![Рисунок8](https://github.com/marininvp/SDL/assets/71025913/244cfd69-4ec8-4981-a95d-6541c857c27d)

