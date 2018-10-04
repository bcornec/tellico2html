# tellico2html
tellico2html is a tool to automatically generate a Web site from Tellico data using Perl scripts and Template Toolkit.

## Getting the sources

You can clone the git repository for development version and tags:

`[test ~]$` **`git clone https://github.com/bcornec/tellico2html.git`**

Or download a tar ball from https://github.com/bcornec/tellico2html/archive/vX.Y.Z.tar.gz

Or use packages for your distribution (only Mageia done at the moment)

## Installation

tellico2html comes with a script to help manual and packaged installation

Use: **`./install.sh`** as root user

You can pass 2 additional variables to change the target directories. Without them, installation will be under /usr/local

Use PREFIX=/opt to install under that directory
Packagers may find the DESTDIR variable useful to install in addition under a build subtree.

Example for an install under ${RPM_BUILD_ROOT}/usr: ./install.sh DESTDIR=${RPM_BUILD_ROOT} PREFIX=/usr

## Usage

Before using the command, you may want to copy the YAML .tellico2htmlrc file given as example in your HOME directory and adapt it to your needs. The file provided defines 3 variables:

outdir: the directory in which the web pages will be generated
sharedir: the directory where tellico places its data files (shouldn't need to be changed except if you did a local install under /usr/local e.g.)
tmpldir: the directory where tellico2html is using the Template Toolkit template files for your tellico data files. The template file should be named the same as the tellico tc file. If you want to process a DVD.tc file in a directory, you need to create 2 files in that directory, the DVD.tt to describe the list of DVDs and the DVD_files.tt to describe the info for a specific DVD. Examples are provided which should serve as a base to support your own .tc file setup.

Once adapted, you may run the tellico2html command. Without parameters, it will process all the .tc files in the current directory and using the templates from the tmpldir generate an index.html, an collection HTML page per .tc file, and in a subdir collection_files containing one HTML file per element of your collection (collectionbeing replaced by the basename of your .tc file)

With parameters, the tool will just process the files given (note that the index.html generated will only refer to these files, not all of them).

Point your browser to the file:///outdir/index.html URL to look at results.

Example files are provided to help you make your own adaptations. To use them do the following:

`[test ~]$` **`cp /usr/share/tellico2html/examples/.tellico2htmlrc $HOME`**
`[test ~]$` **`tellico2html /usr/share/tellico2html/examples/*.tc`**
```
Loading YAML conf file /home/test/.tellico2htmlrc

Processing tellico file /usr/share/tellico2html/examples/BD.tc
-----------------------
Changing key date-achat into date_achat
Generating main HTML file /tmp/www/BD.html using template /usr/share/tellico2html/examples/BD.tt
Generating 1 HTML detailed files using template /usr/share/tellico2html/examples/BD_files.tt

Processing tellico file /usr/share/tellico2html/examples/Disques.tc
-----------------------
Changing key volumes-totaux into volumes_totaux
Changing key r�f�rence-ensemble into r�f�rence_ensemble
Changing key volume-s�rie into volume_s�rie
Generating main HTML file /tmp/www/Disques.html using template /usr/share/tellico2html/examples/Disques.tt
Generating 1 HTML detailed files using template /usr/share/tellico2html/examples/Disques_files.tt

Processing tellico file /usr/share/tellico2html/examples/DVD.tc
-----------------------
Changing key aspect-ratio into aspect_ratio
Changing key running-time into running_time
Changing key imdb-rating into imdb_rating
Changing key titre-original into titre_original
Changing key pr�t�-�-qui into pr�t�_�_qui
Changing key audio-track into audio_track
Changing key directors-cut into directors_cut
Generating main HTML file /tmp/www/DVD.html using template /usr/share/tellico2html/examples/DVD.tt
Generating 1 HTML detailed files using template /usr/share/tellico2html/examples/DVD_files.tt

Processing tellico file /usr/share/tellico2html/examples/Livres.tc
-----------------------
Changing key date-lu into date_lu
Changing key date-dachat into date_dachat
Changing key nb-tomes into nb_tomes
Generating main HTML file /tmp/www/Livres.html using template /usr/share/tellico2html/examples/Livres.tt
Generating 1 HTML detailed files using template /usr/share/tellico2html/examples/Livres_files.tt

Processing tellico file /usr/share/tellico2html/examples/Partitions.tc
-----------------------
Changing key composition-globale into composition_globale
Changing key nombre-dexemplaires into nombre_dexemplaires
Changing key nombre-de-volumes into nombre_de_volumes
Changing key composition-globales into composition_globales
Generating main HTML file /tmp/www/Partitions.html using template /usr/share/tellico2html/examples/Partitions.tt
Generating 1 HTML detailed files using template /usr/share/tellico2html/examples/Partitions_files.tt

Processing tellico file /usr/share/tellico2html/examples/Vins.tc
-----------------------
Changing key lieu-dachat into lieu_dachat
Generating main HTML file /tmp/www/Vins.html using template /usr/share/tellico2html/examples/Vins.tt
Generating 1 HTML detailed files using template /usr/share/tellico2html/examples/Vins_files.tt
```
`[test ~]$` **`firefox /tmp/www/index.html`**

Enjoy !

Notes: If you manage image files for covers, the field name in tellico should be 'cover' as tellico names it in the standard example collections. If you change it, images will not be copied from the collection_files directory into the target HTML directory. Look at lines 187 and following of tellico2html to adapt if needed.

You can change the name of the field (e.g. label to cover) in your tc file by doing:

`[test ~]$` **`unzip file.tc`**
`[test ~]$` **`perl -pi -e 's/label/cover/' tellico.xml`**
`[test ~]$` **`unzip file.tc tellico.xml`**

Check with `grep` that label is not used elswhere or adapt the regular expression to your needs.
