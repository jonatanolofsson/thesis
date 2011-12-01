<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1321825125278" ID="ID_546277853" MODIFIED="1321834246288" STYLE="fork" TEXT="Master thesis - autonomous landing">
<node CREATED="1321825270044" ID="ID_1775746831" MODIFIED="1321825632102" POSITION="right" TEXT="State estimation">
<node CREATED="1321825366620" ID="ID_341698844" MODIFIED="1321825632103" TEXT="UKF">
<node CREATED="1321825369735" ID="ID_1296234649" MODIFIED="1321825632103" TEXT="IMU data collected by microcontroller"/>
<node CREATED="1321825568216" ID="ID_911166352" MODIFIED="1321834685735" TEXT="Global position from image?">
<node CREATED="1321834707837" ID="ID_1386288884" MODIFIED="1321834711678" TEXT="Height?">
<node CREATED="1321834730860" ID="ID_1766308311" MODIFIED="1321834746697" TEXT="Camera looking down, assume flat surface?"/>
</node>
</node>
</node>
</node>
<node CREATED="1321825324176" ID="ID_1361529520" MODIFIED="1321825632103" POSITION="left" TEXT="Control">
<node CREATED="1321825659973" ID="ID_1138740372" MODIFIED="1321825699513" TEXT="Scheduled or dynamic LQ"/>
</node>
<node CREATED="1321825330668" ID="ID_1621933850" MODIFIED="1321825632103" POSITION="right" TEXT="Reference generation">
<node CREATED="1321825507698" ID="ID_1242915754" MODIFIED="1321825632103" TEXT="Reference from image processing"/>
<node CREATED="1321825520213" ID="ID_1076748689" MODIFIED="1321835738165" TEXT="3Dconnexion"/>
<node CREATED="1321825825655" ID="ID_1075878545" MODIFIED="1321834909849" TEXT="Landing mode">
<node CREATED="1321825838662" ID="ID_1423041406" MODIFIED="1321825905030" TEXT="Detection"/>
<node CREATED="1321825905488" ID="ID_1963658680" MODIFIED="1321825909004" TEXT="Refinement"/>
<node CREATED="1321834609137" ID="ID_1355680971" MODIFIED="1321834611721" TEXT="Descent">
<node CREATED="1321834925626" ID="ID_1122362838" MODIFIED="1321834940549" TEXT="Fly to coordinate above landing site"/>
<node CREATED="1321834941396" ID="ID_418580362" MODIFIED="1321834943578" TEXT="Descend"/>
</node>
<node CREATED="1321825909383" ID="ID_1925215526" MODIFIED="1321829865527" TEXT="Recovery"/>
</node>
</node>
<node CREATED="1321829886236" ID="ID_1978363876" MODIFIED="1321829892689" POSITION="left" TEXT="Model identification">
<node CREATED="1321829907031" ID="ID_560177127" MODIFIED="1321829914305" TEXT="Moment of inertia tensor"/>
<node CREATED="1321829915008" ID="ID_720658472" MODIFIED="1321829920235" TEXT="RANSAC?"/>
</node>
<node CREATED="1321834357157" ID="ID_1762323754" MODIFIED="1321834361245" POSITION="right" TEXT="Code details">
<node CREATED="1321834362242" ID="ID_573099269" MODIFIED="1321834365020" TEXT="Test suite"/>
<node CREATED="1321834373201" ID="ID_100902533" MODIFIED="1321834392032" TEXT="Interface with simulator?"/>
</node>
</node>
</map>
