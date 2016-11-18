#!/bin/bash

eqfile=eq.dat
R=70/135/15/55
J=M7i
PS=topo.ps

gmt set FORMAT_GEO_MAP=ddd:mm:ssF
gmt grdcut ETOPO1_Ice_g_gmt4.grd -R$R -GcutTopo.grd
gmt grdgradient cutTopo.grd -Ne0.7 -A50 -GcutTopo_i.grd
gmt grd2cpt cutTopo.grd -Cglobe -S-10000/10000/20 -Z -D>colorTopo.cpt


gmt psbasemap -R$R -JM7i -Bf5a10 -BWesN -Xc -Yc -K > $PS
gmt grdimage cutTopo.grd -IcutTopo_i.grd -R -J -CcolorTopo.cpt -Q -O -K >>$PS
gmt pscoast -R -J -Dh -W1/0.2p -I1/0.25p -N1/0.5p -O -K >>$PS
#绘制colorbar
gmt psscale -DjCB+w7i/0.15i+o0/-0.5i+h -R -J -CcolorTopo.cpt -Bxa2000f400+l"Elevation/m" -G-8000/8000 -O -K >>$PS

#分震级绘制地震
awk '$3>=5.0&&$3<6.0 {print $1,$2,$3*0.05}' $eqfile | gmt psxy -R -J -Sc -Gblue -O -K >> $PS
awk '$3>=6.0&&$3<7.0 {print $1,$2,$3*0.05}' $eqfile | gmt psxy -R -J -Sc -Gred -O -K >> $PS
awk '$3>=7.0&&$3<8.0 {print $1,$2,$3*0.05}' $eqfile | gmt psxy -R -J -Sa -Ggreen -W0.4p,black -O -K >> $PS
awk '$3>=8.0 {print $1,$2,$3*0.05}' $eqfile | gmt psxy -R -J -Sa -Gpurple -W0.4p,black -O -K >> $PS

#绘制图例
gmt pslegend -R -J -DjBR+w0.8i/1.1i+o0 -F+g229+p0.25p -O -K << EOF >> $PS
G 0.01i
H 8 4 MAGNITUDE
G 0.04i
C 0/0/255
S 0.05i c 0.25 blue 0.25p,blue 0.18i 5~5.9
G 0.013i
C 255/0/0
S 0.05i c 0.30 red 0.25p,red 0.18i 6~6.9
G 0.023i
C 0/255/0
S 0.05i a 0.35 green 0.25p,black 0.18i 7~7.9
G 0.061i
C purple
S 0.05i a 0.40 purple 0.25p,black 0.18i 8~8.9
EOF

gmt psxy -R -J -T -O >>$PS
rm gmt.*
