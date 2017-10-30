Is it a license plate in that frame of the video;

  The aspect of a license plate is 5 width/ height 4 = 1.25

  INPUT (png image d:/png/rpt.png )
  ===================================

  The numbers are in blue and the outline is in black


      ********************************
      *                              *
      *   *     ***    ***      *    *
      *  **    *   *  *   *    **    *
      *   *        *      *   * *    *
      *   *      **     **   *****   *
      *   *     *         *     *    *
      *   *    *      *   *     *    *
      * *****  *****   ***      *    *
      *                              *
      ********************************

   PROCESS
   =======

      %utl_submit_py64('
      from PIL import Image;
      newimage2 = Image.open("d:/png/rpt.png");
      pix = newimage2.load();
      [width, height] = newimage2.size;
      f = open("d:/txt/pixle_x_y.txt", "w");
      for x in range(width):;
      .   for y in range(height):;
      .       cpixel = pix[x, y];
      .       if (cpixel ==(0, 0, 0, 255)):;   ** black only;
      .           f.write("%i %i \n" % (x, y));
      .           print(x,y);
      ');

    OUTPUTS

       It is a license because aspect fits

       select
          range(x)/range(y) as aspect

       aspect=1.28


      Intermediate results

      Python output d:/txt/pixle_x_y.txt

        37 7
        37 18
        37 29
        37 40
        37 51
        37 62
        37 73
        37 84
        37 95
        37 106
       ....

     * create sas dataset from python file;
     data roundtrip;
       infile "d:/txt/pixle_x_y.txt";
       input x y;

     * just to prove we got it;
     proc plot data=roundtrip;
       plot y*x='*';

       Y |
         |
     128 +  ********************************
     117 +  *                              *
     106 +  *                              *
      95 +  *                              *
      84 +  *                              *
      73 +  *                              *
      62 +  *                              *
      51 +  *                              *
      40 +  *                              *
      29 +  *                              *
      18 +  *                              *
       7 +  ********************************
         |
         ---+---------+---------+---------+---------+--
           37        87        137       187       237


see
https://goo.gl/ghiU4Q
http://answers.opencv.org/question/94845/python-opencv-extracting-xy-coordinates-of-point-features-on-an-image/

V Coder profile ( I had to make some edits to get it too work)
https://stackoverflow.com/users/4374531/v-coder
                                X

*                _           _
 _ __ ___   __ _| | _____   (_)_ __ ___   __ _  __ _  ___
| '_ ` _ \ / _` | |/ / _ \  | | '_ ` _ \ / _` |/ _` |/ _ \
| | | | | | (_| |   <  __/  | | | | | | | (_| | (_| |  __/
|_| |_| |_|\__,_|_|\_\___|  |_|_| |_| |_|\__,_|\__, |\___|
                                               |___/
;

options printerpath=png ps=96 ls=128 ;
ods printer file="d:/png/rpt.png" color=mono  ;
data _null_;
  file print;
    do y=1 to 12;
      if y in (1,12) then put "       ................................";
      else        put         "       .                              .";
    end;
run;quit;
ods printer close;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_submit_py64('
from PIL import Image;
newimage2 = Image.open("d:/png/rpt.png");
pix = newimage2.load();
[width, height] = newimage2.size;
f = open("d:/txt/pixle_x_y.txt", "w");
for x in range(width):;
.   for y in range(height):;
.       cpixel = pix[x, y];
.       if (cpixel ==(0, 0, 0, 255)):;
.           f.write("%i %i \n" % (x, y));
.           print(x,y);
');

* create sas datset;
data roundtrip;
  infile "d:/txt/pixle_x_y.txt";
  input x y;
run;quit;

* plot it;
options ls=65 ps=24;
proc plot data=roundtrip;
  plot y*x='*';
run;quit;

* compute aspect;
proc sql;
  select
     range(x)/range(y) as aspect
  from
     roundtrip
run;quit;


