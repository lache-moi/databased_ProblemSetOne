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
/*
   id    |           name            
---------+---------------------------
  673680 | Elke A. Rundensteiner
  408029 | Chee Yong Chan
  743723 | Fatma Özcan
 1320288 | K. Selçuk Candan
  323544 | Boon Thau Loo
  169298 | Andrew Pavlo
 2518006 | Theodoros Rekatsinas
 1418215 | Krithi Ramamritham
 1149100 | Jens Teubner
  857634 | Goetz Graefe
 1181388 | Jignesh M. Patel
 2406045 | Stanley B. Zdonik
 2544963 | Tim Kraska
  268343 | Badrish Chandramouli
 1709917 | Meihui Zhang
  484536 | Cong Yu 0001
 2725542 | Xiaokui Xiao
 1846220 | Nan Zhang 0004
  747675 | Feifei Li 0001
 1877901 | Nick Roussopoulos
  695197 | Eric Lo 0001
  831074 | Georgia Koutrika
  380276 | Carsten Binnig
 1287171 | Juliana Freire
 1177033 | Jiawei Han 0001
 2890000 | Zhifeng Bao
  312162 | Bingsheng He
 1262462 | José A. Blakeley
  322298 | Bolin Ding
  369046 | Carlo Curino
  413986 | Chengkai Li
 1739169 | Michael Stonebraker
 1730458 | Michael J. Cafarella
 2767382 | Yanlei Diao
 1484830 | Lijun Chang
 1141943 | Jeffrey Xu Yu
 2733144 | Xin Luna Dong
 2572006 | Torsten Grust
 2516717 | Themis Palpanas
 1042131 | Ioana Manolescu
   43984 | Aditya G. Parameswaran
 1814140 | Mourad Ouzzani
 1881007 | Nicolas Bruno
  889163 | Guy M. Lohman
 2885155 | Zhenjie Zhang
  884711 | Guoliang Li 0001
 2399171 | Sourav S. Bhowmick
 1462813 | Lei Chen 0002
 2723287 | Xiaofang Zhou 0001
 1525081 | Luis Gravano
 1192930 | Jingren Zhou
 2796846 | Yinghui Wu
 1381962 | Kevin Chen-Chuan Chang
 2744190 | Xu Chu
  146845 | Anastasia Ailamaki
  710598 | Eugene Wu 0002
 1293972 | Jun Yang 0001
 2669556 | Wei Wang 0011
 2001300 | Peter A. Boncz
 2442899 | Suman Nath
  550286 | David B. Lomet
  606924 | Dirk Habich
  923388 | Hans-Arno Jacobsen
 2591821 | Ugur Çetintemel
  528407 | Daniel J. Abadi
  479535 | Clement T. Yu
 2707612 | Wook-Shin Han
  203477 | Anthony K. H. Tung
 1846139 | Nan Tang 0001
  141214 | AnHai Doan
  618211 | Donald Kossmann
 1248862 | Jorge-Arnulfo Quiané-Ruiz
   21343 | Aaron J. Elmore
 1029571 | Ihab F. Ilyas
 1384720 | Kevin S. Beyer
 1043779 | Ion Stoica
  340382 | Bruce G. Lindsay 0001
 1172171 | Jianhua Feng
  812799 | Gang Chen 0001
   57571 | Ahmed K. Elmagarmid
 2794029 | Yinan Li
  235231 | Arun Kumar 0001
 2413303 | Stefano Ceri
 1173072 | Jianliang Xu
 2239007 | Sailesh Krishnamurthy
  818565 | Gautam Das 0001
 2368847 | Sihem Amer-Yahia
  240604 | Ashraf Aboulnaga
 1167182 | Jian Pei
  373470 | Carlos Ordonez 0001
 2438617 | Sudipto Das
 2432310 | Stratos Idreos
 2631728 | Viktor Leis
  125548 | Alvin Cheung
 1035983 | Immanuel Trummer
 1128294 | Jayavel Shanmugasundaram
 2731998 | Xifeng Yan
 2061960 | Qiong Luo 0001
 1096594 | James Cheng
 1173547 | Jiannan Wang
  108616 | Alfons Kemper
 2357889 | Shuigeng Zhou
 2114651 | Raymond Chi-Wing Wong
  348352 | Byron Choi
 2252504 | Samuel Madden
  813762 | Gao Cong
  309567 | Bin Cui 0001
 2648780 | Volker Markl
 1356265 | Kaushik Chakrabarti
 1183795 | Jim Gray 0001
 1787469 | Mohamed F. Mokbel
  279982 | Barzan Mozafari
 1512833 | Lu Qin
(113 rows)

Time: 3512.878 ms (00:03.513)
                            */
                            
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

-----------
/* 4.1.4 */
-----------
CREATE TABLE temp1 as (
	SELECT 
		pubid, 
		year-MOD(year,10) AS decade 
	FROM PUBLICATION
	);
SELECT decade, COUNT(*) FROM temp1 GROUP BY decade;
DROP TABLE IF EXISTS temp1 CASCADE;
/*
Time: 11329.187 ms (00:11.329)
dblp=# SELECT decade, COUNT(*) FROM temp1 GROUP BY decade; 
 decade |  count
--------+---------
   1930 |      56
   1940 |     192
   1950 |    2617
   1960 |   13335
   1970 |   47266
   1980 |  138895
   1990 |  461642
   2000 | 1436105
   2010 | 3000916
   2020 |  680882
        |       3
(11 rows)

Time: 961.943 ms 
Total Time: 12-13s

-----------
/* 4.1.5 */
-----------

CREATE TABLE temp1 as (
	SELECT DISTINCT a.id aid, b.id bid
	FROM authored a, authored b 
	WHERE a.pubid=b.pubid 
);
-- Time: 181051.330 ms (03:01.051)
CREATE TABLE temp2 as (
	SELECT aid, COUNT(*) - 1 cnt
	FROM temp1
	GROUP BY aid
	ORDER BY cnt DESC
	LIMIT 20
);
-- Time: 25564.455 ms (00:25.564)
SELECT 
	name, aid, cnt 
FROM 
	temp2 JOIN author ON aid=id;
-- Time: 3.865 ms
DROP TABLE IF EXISTS temp1, temp2 CASCADE;
-- Total Time: ~3:27 mins

/* 
   name    |   aid   | cnt  
-----------+---------+------
 Wei Wang  | 2669545 | 4138
 Yang Liu  | 2763832 | 4132
 Wei Zhang | 2670223 | 4080
 Lei Zhang | 1463749 | 3777
 Yu Zhang  | 2826988 | 3769
 Wei Li    | 2668787 | 3564
 Lei Wang  | 1463390 | 3529
 Xin Wang  | 2733317 | 3135
 Wei Liu   | 2669012 | 3067
 Yi Zhang  | 2786259 | 2978
 Xin Li    | 2732952 | 2932
 Jing Wang | 1189643 | 2904
 Yang Li   | 2763715 | 2902
 Jing Li   | 1189298 | 2843
 Jian Wang | 1167306 | 2821
 Yan Li    | 2760396 | 2802
 Li Zhang  | 1475932 | 2792
 Jun Wang  | 1293731 | 2790
 Wei Chen  | 2668181 | 2755
 Yan Zhang | 2760990 | 2753
                           */

-----------
/* 4.1.6 */
-----------
CREATE TABLE temp1 as (
	SELECT 
		pubid, 
		year-MOD(year,10) AS decade 
	FROM PUBLICATION
);
-- 11736.906 ms (00:11.737)
CREATE TABLE temp2 as(
    SELECT id, decade, count(*)
    FROM authored JOIN temp1 ON authored.pubid = temp1.pubid
    GROUP BY id, decade
;
-- 33875.413 ms (00:33.875)
CREATE TABLE temp3 as(
    SELECT decade, max(count)
    FROM temp2
    GROUP BY decade
);
-- Time: 562.929 ms

SELECT author.name, temp2.id, temp2.decade, temp3.max 
FROM author, temp2, temp3 
WHERE author.id=temp2.id AND temp2.decade=temp3.decade AND temp2.count=temp3.max
ORDER BY temp2.decade;
-- Time: 1640.675 ms (00:01.641)
-- Total Time: ~48s

DROP TABLE IF EXISTS temp1, temp2, temp3 CASCADE;

/*
          name           |   id    | decade | max  
-------------------------+---------+--------+------
 Willard Van Orman Quine | 2692081 |   1930 |    7
 Willard Van Orman Quine | 2692081 |   1940 |   10
 Hao Wang 0001           |  926178 |   1950 |   14
 Henry C. Thacher Jr.    |  955661 |   1960 |   39
 Jeffrey D. Ullman       | 1139737 |   1970 |   80
 Azriel Rosenfeld        |  260047 |   1970 |   80
 Azriel Rosenfeld        |  260047 |   1980 |  172
 Toshio Fukuda           | 2574653 |   1990 |  256
 Wen Gao 0001            | 2678269 |   2000 |  564
 H. Vincent Poor         |  900067 |   2010 | 1214
 Yang Liu                | 2763832 |   2020 |  507
                                                 */

-----------
/* 4.1.7 */
-----------
