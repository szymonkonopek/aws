# aws

# ARRANGE
0. ssh s221598@.....
1.  curl http://adsk.dydaktyka.jkan.pl/_static/id_student -o id_student

* ``ssh ec2-user@{IP} -i id_student``

3. mam repo ``git@github.com:szymonkonopek/aws.git`` lub ``https://github.com/szymonkonopek/myEcom``
18.184.43.215	

## KROKI OD 0️⃣ do milionera 🤑

1. Sync / clone repo (git clone ) 🎸
2. nie ma gita, pobieramy gita 😎😎😎😎
3. Package manager ``tam / dmf``
    * ``dnf search`` (query) (git)
    * ``dnf install`` (paczka) 📦
4. ``cd src/main/resources/static/``
5. ``sudo python3 -m http.server 8080``
6. ``netstat -lntp (pokazuje porty)``

## Kompilacja⁉️
1. Pobieramy java (która wersja ⁉️)
2. ``sudo dnf install java-17-amazon-corretto`` ☕️
3. Verify ``java -version`` ☕️
4. Pobieramy maven (lub inny np. node ruby itp)

## Install maven 🕊️
1. Pobieramy Maven np. ``https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz``
2. ``wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz``
3. Rozpakowywujemy ``tar zxvf apache-maven-3.9.5-bin.tar.gz`` 🤐
4. Pobieramy mc ``dnf install mc`` 🎤
5. ścieka Maven ``apache-maven-3.9.5/bin/mvn``
6. Zmienna środowiskowa maven ``sudo ln -s /home/ec2-user/apache-maven-3.9.5/bin/mvn /usr/local/bin/mvn``

## Kompilacja mvn 🕊️
1. ``cd ./naszprojekt``
2. kompilacja mvn ``mvn compile`` lub test ``mvn test`` 
3. ``mvn package -Dmaven skip=true``
4. ``find target/ | grep .jar`` (bedzie 1 plik)
5. ``java -jar target/my-ecommerce-0.1.jar``

# Naprawiamy no manifest 📖
1. ``https://www.baeldung.com/spring-boot-fix-the-no-main-manifest-attribute``
2. ``<plugins>
    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <configuration>
            <mainClass>com.baeldung.demo.DemoApplication</mainClass>
            <layout>JAR</layout>
        </configuration>
    </plugin>
</plugins>``



## ASSERT
open: http://123.123.123.111 -> our app

dnf search git