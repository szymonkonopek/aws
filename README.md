# AWS
## Zaczynamy

1. ssh s221598@csa.edu.jkan.pl (swój nr albumu)

2. ``curl http://adsk.dydaktyka.jkan.pl/_static/id_student -o id_student`` (pobieramy plik id_student)
3. ``ssh ec2-user@3.68.185.254 -i id_student`` (łaczymy się do ec2-user)
* numerki to adres ip z aws
3.71.202.94
4. mam repo ``git@github.com:szymonkonopek/aws.git`` lub ``https://github.com/szymonkonopek/myEcom``

## Kroki od 0️⃣ do milionera 🤑

1. nie ma gita, pobieramy gita 😎😎😎😎
3. Package manager ``tam / dmf``
    * ``dnf search`` (query) - pokazuje dostępne paczki
    * ``sudo dnf install`` (paczka) pobiera 📦
3. Pobieramy nasz projekt z pp4 ``git clone https://github.com/szymonkonopek/myEcom.git`` (lepiej zeby to byl https)
4. ``cd src/main/resources/static/``
5. ``sudo python3 -m http.server 8080``
6. ``netstat -lntp (pokazuje porty)``
- powinno nam w przeglądarce pokazać stronke, pod adresem IP z AWS i port np. 8080 ``(18.184.43.215:8080)``


## Kompilacja⁉️
1. Pobieramy java (która wersja ⁉️)
2. ``sudo dnf install java-17-amazon-corretto`` ☕️
3. Verify ``java -version`` ☕️
4. Pobieramy maven (lub inny np. node ruby itp)

## Install maven 🕊️
1. Pobieramy Maven np. ``https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz``
2. ``wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz``
3. Rozpakowywujemy ``tar zxvf apache-maven-3.9.5-bin.tar.gz`` 🤐
4. Pobieramy mc ``sudo dnf install mc`` 🎤
5. ścieka Maven ``apache-maven-3.9.5/bin/mvn``
6. Zmienna środowiskowa maven ``sudo ln -s /home/ec2-user/apache-maven-3.9.5/bin/mvn /usr/local/bin/mvn``
7. Sprawdźmy czy jest 🆗 ``mvn -v``

## Kompilacja mvn 🕊️
1. ``cd ./naszprojekt`` 🧑‍🎨
2. kompilacja mvn ``mvn compile`` lub test ``mvn test`` 🧪
3. ``mvn package -Dmaven.test.skip=true`` ✅
4. ``find target/ | grep .jar`` (ten plik ma być na dole) 📁
5. ``java -jar target/my-ecommerce-0.1.jar`` 🫙

# Naprawiamy no manifest 📖
1. ``https://www.baeldung.com/spring-boot-fix-the-no-main-manifest-attribute``
2. Można otworzyć w nano i to wkleić ale to bez sensu troche 🤦. Lepiej otworzyć w vscode ten projekt i dodać sobie po prostu do pluginów kod poniżej.
2. Pluginy są w pliku ``pom.xml`` 🍑
2. ```
    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <configuration>
            <mainClass>com.baeldung.demo.DemoApplication</mainClass>
            <layout>JAR</layout>
        </configuration>
    </plugin>

    * LUB (chyba lepszy sposób)

    ```
        <?xml version="1.0" encoding="UTF-8"?>
        <project xmlns="http://maven.apache.org/POM/4.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>

        <groupId>pl.jkanclerz</groupId>
        <artifactId>my-ecommerce</artifactId>
        <packaging>jar</packaging>       <------- Tutaj dodajemy tą linijke
        <version>0.1</version>

    ```
        <plugins>
            ...
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>    

3. ``mvn install`` instaluje zmiany
4. jeszcze raz ``java -jar target/my-ecommerce-0.1.jar``
5. Potem teoretycznie powinno zadziałać ``<twoje publiczne ip>:<port>`` czyli np: ``https://3.71.53.56:8000`` ale mi to np nie działa
6. Port mozna zobaczyć w ``src/main/resources/application.yaml``

## Here we go again 🤷🏾‍♂️


### Systemd shit
```
cd /
cd etc/systemd/system
sudo nano ecom.service
```

```
sudo systemctl daemon-reload
sudo systemctl start ecom
sudo systemctl status ecom
```
Mozemy zobaczyc sobie logi `journalctl -u ecom`
Follow `journalctl -u ecom -f`

# Ansible
```
eval `ssh-agent`
```
2. add ssh ➕ `ssh-add id_student`
3. ping pong 🏓 `ansible -m ping -i hosts.ini app_nodes` 
4. run script 🏃 `ansible-playbook -i hosts.ini install_java_app.yaml`

```
- name: "Install eceommerce app"
  hosts: app_nodes
  become: yes
  vars:
    app_url: https://github.com/szymonkonopek/myEcom/releases/download/v1.31/my-ecommerce-0.1.jar
    app_dir: /opt/ecommerce
    app_name: ecommerce
    my_favourite_software:
      - cowsay
      - mc
      - tree
    my_must_have_software:
      - java-17-amazon-corretto
  tasks:
    - name: "My first command via ansible"
      shell: "echo 'hello world :)' > hello_world.txt"
    - name: "install my favourite software: eg cowsay"
      dnf:
        name: "{{ my_favourite_software }}"
        state: latest
    - name: "install my must have  software"
      dnf:
        name: "{{ my_must_have_software }}"
        state: latest
    - name: "create app dir"
      file:
        path: "{{app_dir}}"
        state: directory
    - name: "Download my app"
      get_url:
        url: "{{ app_url }}"
        dest: "{{app_dir}}/{{app_name}}.jar"
    - name: "create systemd config"
      template:
        src: templates/app.service.j2
        dest: "/etc/systemd/system/{{ app_name }}.service"
    - name: "restart my service & add to autostart"
      systemd_service:
        name: "{{app_name}}"
        state: restarted
        enabled: yes
        daemon_reload: yes
```

# Load balancer
1. trzeba zrobić 2 maszyny (1 zwykła i load balancer)
2. logujemy do load balancera
3. `sudo dnf install nginx`
4. `sudo systemctl restart nginx`
5. plik `install.yaml` do automatyzacji
```
host: lb_nodes
tasks:
  - name: "install nginx"
    dnf:
      name: nginx
      state: latest
  - name: "restart nginx"
    systemd_service:
      name: nginx
      state: restarted
      enabled: yes
      daemon_reload: yes
```

6. `cd /etc/nginx`
7. robimy plik config `conf.d/web.conf`
```
server {
        listen 80;
        root /var/www;

        location / {
                proxy_pass http://172.31.20.113:80;
                proxy_set_header Host $host;
        }
}
```

8. potem na pierwszą maszyne
9. 
```
eval `ssh-agent` 
```
10. `ssh-add ~/id_student`


# Docker 🐳
1. `sudo dnf install docker -y`
2. `docker --version`
3. `sudo systemctl start docker`
4. `sudo systemctl status docker`

### Dockerhub
`https://hub.docker.com/_/alpine` minimalny start

5. `sudo docker run alpine sh -c "echo 'Hello'"` - wypisywanie 'echo' w spoób izolowany na alpine.
6. Wyświell liste procesów które działają `sudo docker ps`
7. Wyświell liste procesów które działają plus te poprzednie? `sudo docker ps -a`

### Apache HTTP 🪶
* `https://hub.docker.com/_/httpd`
8. `sudo docker run -p 8080:80 httpd:2.4.12`
9. Idziemy na nasze ip i port 8080
10. `sudo docker run -d -p 5000:80 httpd:2.4.12` d- background, p - port\ (5000 nie działa na uek)
###
11. Nginx -  `sudo docker run -d -p  80:80 nginx:latest` 🦫

### Usuwanie procesów
1. `sudo docker ps` - sprawdzamy co jakie procesy działają
2. `sudo docker rm -f <POCZATEK_ID>` - np. a8 przy a808e43...

### Wchodzimy w alpine
1. `sudo docker run -it alpine sh` (uproszczony bash)

### Próbujemy zainstalować naszą aplikacje
* apk - project manager w apline
1. `apk add openjdk17`
2. `wget https://github.com/szymonkonopek/myEcom/releases/download/v1.31/my-ecommerce-0.1.jar -O app.jar`
3. `java -Dserver.port=8080 -jar app.jar`
* działa

## Dockerfile 🐳📁
1. nano `Dockerfile`
```
FROM alpine:latest

RUN mkdir -p /opt/ecommerce

RUN apk add openjdk17
RUN wget https://github.com/szymonkonopek/myEcom/releases/download/v1.31/my-ecommerce-0.1.jar -O /opt/ecommerce/app.jar

RUN adduser ecommerce --disabled-password

USER ecommerce

EXPOSE 8080
CMD ["/usr/bin/java/", "-Dserver.port=8080", "-jar", "/opt/ecommerce/app.jar"]
```

2. budowa obrazu 🧱 `sudo docker build -t my_ecommerce ./` - jak uruchomimy jeszcze raz to cache działą
3. `sudo docker images` -> my_ecommerce

# Telegraf zadanie 📁
## Oprogramowanie
* InfluxDB 🧢
* Telegraf ☎️
* Grafana 📊

1. Tworzymy maszynę metrics w amazon ws
2. `sudo dnf install https://dl.influxdata.com/telegraf/releases/telegraf-1.29.1-1.x86_64.rpm`
3. `telegraf --sample-config > mytelegraf.conf` 
4. Usuwamy komentarze # `grep -v "#" mytelegraf.conf | uniq > clear_telegraf.conf`
5. `elegraf --config clear_telegraf.conf --test` (bez outputów)

```
[global_tags]

[agent]
  interval = "10s"
  round_interval = true

  metric_batch_size = 1000

  metric_buffer_limit = 10000

  collection_jitter = "0s"

  flush_interval = "10s"
  flush_jitter = "0s"

  precision = "0s"

  hostname = ""
  omit_hostname = false

[[inputs.cpu]]
  percpu = true
  totalcpu = true
  collect_cpu_time = false
  report_active = false
  core_tags = false

[[inputs.disk]]
  mount_points = ["/"]
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]

[[inputs.mem]]

[[inputs.ping ]]
urls = ["8.8.8.8", "uek.krakow.pl"]

[[inputs.system]]
```

7. `df -h` (h - humanize) ☠️
8. `sudo dnf install https://dl.influxdata.com/influxdb/releases/influxdb2-2.7.5-1.x86_64.rpm`
9. `sudo yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-10.2.3-1.x86_64.rpm`
10. Grafa operuje na porcie `3000` ale uek blokuje więc zmieniamy 🎓
11. `sudo nano /etc/grafana/grafana.ini` zmieniamy na `8080` 📈
12. `sudo systemctl restart grafana-server.service` 🚀