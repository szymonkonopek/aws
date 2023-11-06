# AWS
## Zaczynamy

1. ssh s221598@csa.edu.jkan.pl (swój nr albumu)

2. ``curl http://adsk.dydaktyka.jkan.pl/_static/id_student -o id_student`` (pobieramy plik id_student)
3. ``ssh ec2-user@18.184.43.215 -i id_student`` (łaczymy się do ec2-user)
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

## Automatyzacja 🎰
1. Tworzymy skrypt cs2/example.sh

### Przykład skryptu ec2/example_remotely.sh
```
#!/bin/bash

#ssh ec2-user@3.71.202.94 -i id_student 'sudo bash -s' < ~/ec2/example_remotely.sh

MY_NAME=${MY_NAME:-"Szymon"}
PACKAGES_TO_BE_INSTALLED='cowsay mc tree'

echo "hello $MY_NAME"
dnf install -y -q ${PACKAGES_TO_BE_INSTALLED} #y zgadza się na wszystko

#Install java
dnf -y -q install java-17-amazon-corretto

#dir structure
mkdir -p /opt/ecommerce

##Going to download app jar
# https://github.com/influxdata/influxdb

cowsay 'it works 🐄'
```

* Github actions: ``https://docs.github.com/en/actions/quickstart``
* Java with Maven:  ``https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-java-with-maven``
* Kanclerz acitons:  ``https://github.com/jkanclerz/computer-programming-4/tree/master/.github/workflows``

2. Tworzymy akcje takie jak zrobił Mr. Kanclerz 🎬
3. W między czasie mozna zobaczyć zakładke release dodać tak i coś tam zrobić?
4. Dodajmy taga ``git tag -a 'v1.11' -m 'my 1.11'``
# Praca domowa: Zainstalować wordpress