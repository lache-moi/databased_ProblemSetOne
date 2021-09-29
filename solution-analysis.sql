-----------
/* 4.1.1 */
-----------

SELECT 
	author.id, author.name, COUNT(*) as cnt 
FROM 
	authored JOIN author ON authored.id = author.id
GROUP BY 
	author.id 
ORDER BY cnt DESC 
LIMIT 20; 

/*
   id    |         name         | cnt  
---------+----------------------+------
  900067 | H. Vincent Poor      | 2309
 1789965 | Mohamed-Slim Alouini | 1753
 2018984 | Philip S. Yu         | 1626
 2670223 | Wei Zhang            | 1574
 2669545 | Wei Wang             | 1534
 1441908 | Lajos Hanzo          | 1481
 2826988 | Yu Zhang             | 1478
 2763832 | Yang Liu             | 1463
 1463749 | Lei Zhang            | 1373
 1463390 | Lei Wang             | 1341
 2898818 | Zhu Han              | 1334
 2733317 | Xin Wang             | 1321
 2624924 | Victor C. M. Leung   | 1321
 2678269 | Wen Gao 0001         | 1315
  511271 | Dacheng Tao          | 1275
  904073 | Hai Jin 0001         | 1265
 2702302 | Witold Pedrycz       | 1256
 2668787 | Wei Li               | 1230
 1293731 | Jun Wang             | 1215
 1514644 | Luca Benini          | 1198
(20 rows)

Time: 22084.504 ms (00:22.085)
                                     */

-----------
/* 4.1.2 */
-----------

SELECT
    author.id, author.name, COUNT(*) as cnt
FROM
    author JOIN authored ON author.id = authored.id
           JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                AND inproceedings.booktitle='UIST'
GROUP BY 
	author.id 
ORDER BY cnt DESC 
LIMIT 20; 

/* For UIST
   id    |         name          | cnt 
---------+-----------------------+-----
 2282330 | Scott E. Hudson       |  41
 2575943 | Tovi Grossman         |  33
 2113010 | Ravin Balakrishnan    |  30
  830152 | George W. Fitzmaurice |  30
 1968220 | Patrick Baudisch      |  29
  434949 | Chris Harrison 0001   |  27
 1581494 | Maneesh Agrawala      |  25
  315675 | Björn Hartmann        |  23
 2312710 | Shahram Izadi         |  21
 2488316 | Takeo Igarashi        |  20
  327626 | Brad A. Myers         |  19
  535833 | Daniel Wigdor         |  19
 2151955 | Robert C. Miller      |  19
  535467 | Daniel Vogel 0001     |  18
  990426 | Hrvoje Benko          |  18
  784817 | François Guimbretière |  18
  970121 | Hiroshi Ishii 0001    |  18
 2700199 | Wilmot Li             |  17
  311243 | Bing-Yu Chen          |  17
 2735151 | Xing-Dong Yang        |  17
(20 rows)

Time: 3182.721 ms (00:03.183)
                                     */

SELECT
    author.id, author.name, COUNT(*) as cnt
FROM
    author JOIN authored ON author.id = authored.id
           JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                AND inproceedings.booktitle='STOC'
GROUP BY 
	author.id 
ORDER BY cnt DESC 
LIMIT 20; 

/* For STOC
   id    |           name            | cnt 
---------+---------------------------+-----
  252772 | Avi Wigderson             |  58
 2153518 | Robert Endre Tarjan       |  33
 2104499 | Ran Raz                   |  30
 1805063 | Moni Naor                 |  29
 1901373 | Noam Nisan                |  29
 2597067 | Uriel Feige               |  28
 2265681 | Santosh S. Vempala        |  27
 2087709 | Rafail Ostrovsky          |  27
 2620063 | Venkatesan Guruswami      |  26
 1754583 | Mihalis Yannakakis        |  26
  781874 | Frank Thomson Leighton    |  25
 1916801 | Oded Goldreich 0001       |  25
 1760193 | Mikkel Thorup             |  24
  459072 | Christos H. Papadimitriou |  24
 2038787 | Prabhakar Raghavan        |  24
 1810891 | Moses Charikar            |  23
 2793537 | Yin Tat Lee               |  23
 2167392 | Rocco A. Servedio         |  22
 1903520 | Noga Alon                 |  22
 1563894 | Madhu Sudan               |  22
(20 rows)

Time: 3067.714 ms (00:03.068)
                                     */

SELECT
    author.id, author.name, COUNT(*) as cnt
FROM
    author JOIN authored ON author.id = authored.id
           JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                AND inproceedings.booktitle='CHI'
GROUP BY 
	author.id 
ORDER BY cnt DESC 
LIMIT 20; 

/* For CHI
   id    |         name          | cnt 
---------+-----------------------+-----
 1971164 | Patrick Olivier       |  69
  366933 | Carl Gutwin           |  67
 2575943 | Tovi Grossman         |  65
 2282330 | Scott E. Hudson       |  62
 2425397 | Steve Benford         |  59
 1968220 | Patrick Baudisch      |  56
 2113010 | Ravin Balakrishnan    |  56
 1229940 | John Vines            |  52
 1346073 | Kasper Hornbæk        |  52
  830152 | George W. Fitzmaurice |  50
  213572 | Antti Oulasvirta      |  48
 1084076 | Jacob O. Wobbrock     |  46
 2359120 | Shumin Zhai           |  46
 1095187 | James A. Landay       |  46
 2002892 | Peter C. Wright       |  45
 2420158 | Stephen A. Brewster   |  45
  434949 | Chris Harrison 0001   |  44
 2153192 | Robert E. Kraut       |  44
 1146069 | Jennifer Mankoff      |  44
 2119684 | Regan L. Mandryk      |  44
(20 rows)

Time: 2143.420 ms (00:02.143)
                                     */

-----------
/* 4.1.3 */
-----------

SELECT
    author.id, author.name
FROM
    author JOIN authored ON author.id = authored.id
           JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                AND inproceedings.booktitle='SIGMOD Conference'
    GROUP By author.id
    HAVING COUNT(*) >= 10
EXCEPT
    SELECT
        author.id, author.name
    FROM
        author JOIN authored ON author.id = authored.id
               JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                    AND inproceedings.booktitle='PODS';

SELECT
    author.id, author.name
FROM
    author JOIN authored ON author.id = authored.id
           JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                AND inproceedings.booktitle='PODS'
    GROUP By author.id
    HAVING COUNT(*) >= 5
EXCEPT
    SELECT
        author.id, author.name
    FROM
        author JOIN authored ON author.id = authored.id
               JOIN inproceedings ON authored.pubid = inproceedings.pubid 
                    AND inproceedings.booktitle='SIGMOD Conference';

/*
   id    |          name           
---------+-------------------------
  492679 | Cristian Riveros
 1599980 | Marco A. Casanova
 1884377 | Nicole Schweikardt
 1688161 | Matthias Niewerth
  853595 | Giuseppe De Giacomo
 1137022 | Jef Wijsen
 2532788 | Thomas Schwentick
 1649289 | Martin Grohe
  613100 | Domagoj Vrgoc
 1903504 | Nofar Carmeli
  772531 | Francesco Scarcello
  247175 | Atri Rudra
 2402308 | Srikanta Tirthapura
  160029 | Andreas Pieris
 1601320 | Marco Console
 1753050 | Miguel Romero 0001
 1846656 | Nancy A. Lynch
 1403031 | Kobbi Nissim
 2617714 | Vassos Hadzilacos
  673662 | Eljas Soisalon-Soininen
 2121910 | Reinhard Pichler
   74718 | Alan Nash
 1760777 | Mikolaj Bojanczyk
 2110560 | Rasmus Pagh
 1734603 | Michael Mitzenmacher
 2406851 | Stavros S. Cosmadakis
  562934 | David P. Woodruff
 1338906 | Kari-Jouko Räihä
  998887 | Hubie Chen
(29 rows)

Time: 3450.462 ms (00:03.450)
                            */


