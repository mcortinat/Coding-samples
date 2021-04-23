*----------------------------------------------------*
* 	Women to Women: TA as Role Models in Economics   *
* 	Magdalena Cortina								 *
* 	Dofile 3: Model 								 *
*----------------------------------------------------*

set more off
clear all
version 16.1

* This do-file is for cleaning and exploring data

* Magdalena
global path 	"/Users/magdalena/Dropbox/Tesis/"
global pathD	"${path}02 Data/"
global pathR	"${path}03 Results/"
use "${pathD}cleandata_2.dta"
/* diff in diff **
El modelo es un diff in diff en donde los tratados son los alumnos que tuvieron al menos una ayudante mujer, y los controles aquellos que tuvieron solo ayudantes hombres.

Primera etapa:
El grupo tratados se modifica para intensificar el tratamiento de dos maneras distintas:
	1. Lic - Tratados: tuvieron al menos una ayudante mujer de la licenciatura en economía, contrles, el resto.
	2. Q - Tratados: tuvieron más de una ayudante mujer en la respectiva área/ramo. controles, el resto.
	
Segunda etapa:
Luego, también se agregan controles:
	1. Género del profesor: dummy de profesora mujer
	2. Promedio de los prerrequisitos: todos, area economica y area matematica.
	
Tercera etapa: agregar el  ramo macro I.

Cuarta etapa: contuinidad  - seguir en la licenciatura despues de ecomate   
*/
	
ssc install asdoc, replace
* dd = coeficiente de diff in diff
* L = modelo liceniatura
* Q modelo de cantidad
* ay_sigla = dummy de ayudante mujer por asignatura
* mujer = dummmy de alumna mujer

** MODELO ORIGINAL **


* variables de interacción modelo original 
gen ddeco=mujer*ayud_eco
gen ddmat=mujer*ayud_mat
gen dde121=mujer*ay_eco121
gen dde201=mujer*ay_eco201
gen ddm108=mujer*ay_mat108
gen ddm112=mujer*ay_mat112
gen ddm118=mujer*ay_mat118
gen dde221=mujer*ay_eco221

asdoc reg ecomate mujer ay_eco121 dde121,r nest save(regress) replace
asdoc reg ecomate mujer ay_eco201 dde201,r nest save(regress)
asdoc reg ecomate mujer ay_mat108 ddm108,r nest save(regress)
asdoc reg ecomate mujer ay_mat118 ddm118,r nest save(regress)
asdoc reg ecomate mujer ay_mat112 ddm112,r nest save(regress)
asdoc reg ecomate mujer ayud_eco ddeco,r nest save(regress)
asdoc reg ecomate mujer ayud_mat ddmat,r nest save(regress)

/** ahora incluyendo controles
	- dummy de profesor planta
	- genero del profesor (dummy de al menos una profesora mujer)
	
	- rendimiento de la sección
	- promedio de notas antes del ramo (ranking PSU en caso de ramos de primer semestre)
*/

* 1. PLANTA + rendimiento seccion  ////// ok
asdoc reg ecomate mujer ay_eco121 dde121 pl_e121 rend_eco121 ,r nest save(pl+rend) replace
asdoc reg ecomate mujer ay_eco201 dde201 pl_e201 rend_eco201 ,r nest save(pl+rend)
asdoc reg ecomate mujer ay_mat108 ddm108 pl_m108 rend_mat108 ,r nest save(pl+rend)
asdoc reg ecomate mujer ay_mat118 ddm118 pl_m118 rend_mat118 ,r nest save(pl+rend)
asdoc reg ecomate mujer ay_mat112 ddm112 pl_m112 rend_mat112 ,r nest save(pl+rend)
asdoc reg ecomate mujer ayud_eco ddeco pl_eco rend_eco ,r nest save(pl+rend)
asdoc reg ecomate mujer ayud_mat ddmat pl_mat rend_mat ,r nest save(pl+rend)

* 2. PLANTA + promedio PRER  //////
asdoc reg ecomate mujer ay_eco121 dde121 pl_e121 prom_prer,r nest save(pl+prom) replace 
asdoc reg ecomate mujer ay_eco201 dde201 pl_e201 prom_prer,r nest save(pl+prom)
asdoc reg ecomate mujer ay_mat108 ddm108 pl_m108 prom_prer,r nest save(pl+prom)
asdoc reg ecomate mujer ay_mat118 ddm118 pl_m118 prom_prer,r nest save(pl+prom)
asdoc reg ecomate mujer ay_mat112 ddm112 pl_m112 prom_prer,r nest save(pl+prom)
asdoc reg ecomate mujer ayud_eco ddeco pl_eco prom_prer,r nest save(pl+prom)
asdoc reg ecomate mujer ayud_mat ddmat pl_mat prom_prer,r nest save(pl+prom)

* 3. GENERO profesor + rendimiento seccion //////
asdoc reg ecomate mujer ay_eco121 dde121 prof_e121 rend_eco121,r nest save(gen+rend) replace 
asdoc reg ecomate mujer ay_eco201 dde201 prof_e201 rend_eco201,r nest save(gen+rend)
asdoc reg ecomate mujer ay_mat108 ddm108 prof_m108 rend_mat108,r nest save(gen+rend)
asdoc reg ecomate mujer ay_mat118 ddm118 prof_m118 rend_mat118,r nest save(gen+rend)
asdoc reg ecomate mujer ay_mat112 ddm112 prof_m112 rend_mat112,r nest save(gen+rend)
asdoc reg ecomate mujer ayud_eco ddeco prof_eco rend_eco,r nest save(gen+rend)
asdoc reg ecomate mujer ayud_mat ddmat prof_mat rend_mat,r nest save(gen+rend)

* 4. GENERO profesor + promedio notas previas
asdoc reg ecomate mujer ay_eco121 dde121 prof_e121 prom_prer,r nest save(gen+prom) replace 
asdoc reg ecomate mujer ay_eco201 dde201 prof_e201 prom_prer,r nest save(gen+prom)
asdoc reg ecomate mujer ay_mat108 ddm108 prof_m108 prom_prer,r nest save(gen+prom)
asdoc reg ecomate mujer ay_mat118 ddm118 prof_m118 prom_prer,r nest save(gen+prom)
asdoc reg ecomate mujer ay_mat112 ddm112 prof_m112 prom_prer,r nest save(gen+prom)
asdoc reg ecomate mujer ayud_eco ddeco prof_eco prom_prer,r nest save(gen+prom)
asdoc reg ecomate mujer ayud_mat ddmat prof_mat prom_prer ,r nest save(gen+prom)

* 5. TODOS los controles
asdoc reg ecomate mujer ay_eco121 dde121 prof_e121 pl_e121 rend_eco121 prom_prer,r nest save(todos) replace 
asdoc reg ecomate mujer ay_eco201 dde201 prof_e201 pl_e201 rend_eco201 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ay_mat108 ddm108 prof_m108 pl_m108 rend_mat108 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ay_mat118 ddm118 prof_m118 pl_m118 rend_mat118 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ay_mat112 ddm112 prof_m112 pl_m112 rend_mat112 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ayud_eco ddeco prof_eco pl_eco rend_eco prom_prer,r nest save(todos)
asdoc reg ecomate mujer ayud_mat ddmat prof_mat pl_mat rend_mat prom_prer,r nest save(todos)

* 6. SOLO PROFE MUJER 
asdoc reg ecomate mujer ay_eco121 dde121 prof_e121,r nest save(gen) replace 
asdoc reg ecomate mujer ay_eco201 dde201 prof_e201,r nest save(gen)
asdoc reg ecomate mujer ay_mat108 ddm108 prof_m108,r nest save(gen)
asdoc reg ecomate mujer ay_mat118 ddm118 prof_m118,r nest save(gen)
asdoc reg ecomate mujer ay_mat112 ddm112 prof_m112,r nest save(gen)
asdoc reg ecomate mujer ayud_eco ddeco prof_eco,r nest save(gen)
asdoc reg ecomate mujer ayud_mat ddmat prof_mat,r nest save(gen)

* 7. SOLO PLANTA
asdoc reg ecomate mujer ay_eco121 dde121 pl_e121,r nest save(pl) replace 
asdoc reg ecomate mujer ay_eco201 dde201 pl_e201,r nest save(pl)
asdoc reg ecomate mujer ay_mat108 ddm108 pl_m108,r nest save(pl)
asdoc reg ecomate mujer ay_mat118 ddm118 pl_m118,r nest save(pl)
asdoc reg ecomate mujer ay_mat112 ddm112 pl_m112,r nest save(pl)
asdoc reg ecomate mujer ayud_eco ddeco pl_eco,r nest save(pl)
asdoc reg ecomate mujer ayud_mat ddmat pl_mat,r nest save(pl)

* 8. SOLO RENDIMINETO SECCIÓN
asdoc reg ecomate mujer ay_eco121 dde121 rend_eco121,r nest save(rend) replace 
asdoc reg ecomate mujer ay_eco201 dde201 rend_eco201,r nest save(rend)
asdoc reg ecomate mujer ay_mat108 ddm108 rend_mat108,r nest save(rend)
asdoc reg ecomate mujer ay_mat118 ddm118 rend_mat118,r nest save(rend)
asdoc reg ecomate mujer ay_mat112 ddm112 rend_mat112,r nest save(rend)
asdoc reg ecomate mujer ayud_eco ddeco rend_eco,r nest save(rend)
asdoc reg ecomate mujer ayud_mat ddmat rend_mat,r nest save(rend)


* 9. PROM PRER
asdoc reg ecomate mujer ay_eco121 dde121 prom_prer,r nest save(ranking) replace 
asdoc reg ecomate mujer ay_eco201 dde201 prom_prer,r nest save(ranking)
asdoc reg ecomate mujer ay_mat108 ddm108 prom_prer,r nest save(ranking)
asdoc reg ecomate mujer ay_mat118 ddm118 prom_prer,r nest save(ranking)
asdoc reg ecomate mujer ay_mat112 ddm112 prom_prer,r nest save(ranking)
asdoc reg ecomate mujer ayud_eco ddeco prom_prer,r nest save(ranking)
asdoc reg ecomate mujer ayud_mat ddmat prom_prer ,r nest save(ranking)

* 10. PROFE MUJER + PLANTA
asdoc reg ecomate mujer ay_eco121 dde121 prof_e121 pl_e121,r nest save(todos) replace 
asdoc reg ecomate mujer ay_eco201 dde201 prof_e201 pl_e201,r nest save(todos)
asdoc reg ecomate mujer ay_mat108 ddm108 prof_m108 pl_m108,r nest save(todos)
asdoc reg ecomate mujer ay_mat118 ddm118 prof_m118 pl_m118,r nest save(todos)
asdoc reg ecomate mujer ay_mat112 ddm112 prof_m112 pl_m112,r nest save(todos)
asdoc reg ecomate mujer ayud_eco ddeco prof_eco pl_eco,r nest save(todos)
asdoc reg ecomate mujer ayud_mat ddmat prof_mat pl_mat,r nest save(todos)

* 11. RENDIMIENTO SECCION + PROM PRER
asdoc reg ecomate mujer ay_eco121 dde121 rend_eco121 prom_prer,r nest save(todos) replace 
asdoc reg ecomate mujer ay_eco201 dde201 rend_eco201 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ay_mat108 ddm108 rend_mat108 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ay_mat118 ddm118 rend_mat118 prom_prer,r nest save(todos)
asdoc reg ecomate mujer ay_mat112 ddm112 rend_mat112 ranking,r nest save(todos)
asdoc reg ecomate mujer ayud_eco ddeco rend_eco prom_prer,r nest save(todos)
asdoc reg ecomate mujer ayud_mat ddmat rend_mat prom_prer,r nest save(todos)






**  MODELO LICENCIATURA (lic) **

gen Ldde121=mujer*lic_e121
gen Ldde201=mujer*lic_e201
gen Lddm108=mujer*lic_m108
gen Lddm118=mujer*lic_m118
gen Lddm112=mujer*lic_m112
gen Lddeco=mujer*lic_eco
gen Lddmat=mujer*lic_mat

asdoc reg ecomate mujer lic_e121 Ldde121, r nest save(Lregress) replace
asdoc reg ecomate mujer lic_e201 Ldde201,  r nest save(Lregress)
asdoc reg ecomate mujer lic_m108 Lddm108, r nest save(Lregress)
asdoc reg ecomate mujer lic_m118 Lddm118, r nest save(Lregress)
asdoc reg ecomate mujer lic_m112 Lddm112, r nest save(Lregress)
asdoc reg ecomate mujer lic_eco Lddeco, r nest save(Lregress)
asdoc reg ecomate mujer lic_mat Lddmat, r nest save(Lregress)

asdoc reg ecomate mujer lic_e121 Ldde121 pl_e121 rend_eco121, r nest save(Lregress) replace
asdoc reg ecomate mujer lic_e201 Ldde201 pl_e201 rend_eco201,  r nest save(Lregress)
asdoc reg ecomate mujer lic_m108 Lddm108 pl_m108 rend_mat108, r nest save(Lregress)
asdoc reg ecomate mujer lic_m118 Lddm118 pl_m118 rend_mat118, r nest save(Lregress)
asdoc reg ecomate mujer lic_m112 Lddm112 pl_m112 rend_mat112, r nest save(Lregress)
asdoc reg ecomate mujer lic_eco Lddeco pl_eco rend_eco, r nest save(Lregress)
asdoc reg ecomate mujer lic_mat Lddmat pl_mat rend_mat, r nest save(Lregress)

** MODELO Q **

* dummy de tener más de una ayudante mujer
* "T" simboliza dummy de grupo tratado
gen TQe121=0
replace TQe121=1 if Qay_eco121>1
gen TQe201=0
replace TQe201=1 if Qay_eco201>1
gen TQm108=0
replace TQm108=1 if Qay_mat108>1
gen TQm118=0
replace TQm118=1 if Qay_mat118>1
gen TQm112=0
replace TQm112=1 if Qay_mat112>1
gen TQeco=0
replace TQeco=1 if Qayud_eco>1
gen TQmat=0
replace TQmat=1 if Qayud_mat>1

* variable de interaccion modelo Q  
gen Qdde121=mujer*TQe121
gen Qdde201=mujer*TQe201
gen Qddm108=mujer*TQm108
gen Qddm118=mujer*TQm118
gen Qddm112=mujer*TQm112
gen Qddeco=mujer*TQeco
gen Qddmat=mujer*TQmat


asdoc reg ecomate mujer TQe121 Qdde121,r nest save(Qregress) replace
asdoc reg ecomate mujer TQe201 Qdde201,r nest save(Qregress) 
asdoc reg ecomate mujer TQm108 Qddm108,r nest save(Qregress)
asdoc reg ecomate mujer TQm118 Qddm118,r nest save(Qregress) 
asdoc reg ecomate mujer TQm112 Qddm112,r nest save(Qregress) 
asdoc reg ecomate mujer TQeco Qddeco, r nest save(Qregress)
asdoc reg ecomate mujer TQmat Qddmat, r nest save(Qregress)

gen Qdde121=mujer*Qay_eco121
gen Qdde201=mujer*Qay_eco201
gen Qddm108=mujer*Qay_mat108
gen Qddm118=mujer*Qay_mat118
gen Qddm112=mujer*Qay_mat112
gen Qddeco=mujer*Qayud_eco
gen Qddmat=mujer*Qayud_mat

asdoc reg ecomate mujer Qay_eco121 Qdde121,r nest save(Qregress) replace
asdoc reg ecomate mujer Qay_eco201 Qdde201,r nest save(Qregress) 
asdoc reg ecomate mujer Qay_mat108 Qddm108,r nest save(Qregress)
asdoc reg ecomate mujer Qay_mat118 Qddm118,r nest save(Qregress) 
asdoc reg ecomate mujer Qay_mat112 Qddm112,r nest save(Qregress) 
asdoc reg ecomate mujer Qayud_eco Qddeco, r nest save(Qregress)
asdoc reg ecomate mujer Qayud_mat Qddmat, r nest save(Qregress)


********************************************************************************

/// AHORA POR ASIGNATURA: para tener una tabla por ramo con todas las regresiones

* INTRODUCCIÓN A LA ECONOMÍA *

asdoc reg ecomate mujer ay_eco121 dde121,r nest save(ECO121) replace
asdoc reg ecomate mujer ay_eco121 dde121 prom_prer,r nest save(ECO121) 
asdoc reg ecomate mujer lic_e121 Ldde121, r nest save(ECO121)
asdoc reg ecomate mujer lic_e121 Ldde121 prom_prer, r nest save(ECO121)
asdoc reg ecomate mujer TQe121 Qdde121,r nest save(ECO121) 
asdoc reg ecomate mujer TQe121 Qdde121 prom_prer,r nest save(ECO121) 


* MICROECONOMÍA I *

asdoc reg ecomate mujer ay_eco201 dde201,r nest save(ECO201) replace
asdoc reg ecomate mujer ay_eco201 dde201 prof_e201 prom_prer,r nest save(ECO201) 
asdoc reg ecomate mujer lic_e201 Ldde201, r nest save(ECO201)
asdoc reg ecomate mujer lic_e201 Ldde201 prof_e201 prom_prer, r nest save(ECO201)
asdoc reg ecomate mujer TQe201 Qdde201,r nest save(ECO201) 
asdoc reg ecomate mujer TQe201 Qdde201 prof_e201 prom_prer,r nest save(ECO201)

* CÁLCULO I *

asdoc reg ecomate mujer ay_mat108 ddm108,r nest save(MAT108) replace
asdoc reg ecomate mujer ay_mat108 ddm108 prof_m108 prom_prer,r nest save(MAT108) 
asdoc reg ecomate mujer lic_m108 Lddm108, r nest save(MAT108)
asdoc reg ecomate mujer lic_m108 Lddm108 prof_m108 prom_prer, r nest save(MAT108)
asdoc reg ecomate mujer TQm108 Qddm108,r nest save(MAT108) 
asdoc reg ecomate mujer TQm108 Qddm108 prof_m108 prom_prer,r nest save(MAT108)

* CÁLCULO II *

asdoc reg ecomate mujer ay_mat118 ddm118,r nest save(MAT118) replace
asdoc reg ecomate mujer ay_mat118 ddm118 prof_m118 prom_prer,r nest save(MAT118) 
asdoc reg ecomate mujer lic_m118 Lddm118, r nest save(MAT118)
asdoc reg ecomate mujer lic_m118 Lddm118 prof_m118 prom_prer, r nest save(MAT118)
asdoc reg ecomate mujer TQm118 Qddm118,r nest save(MAT118) 
asdoc reg ecomate mujer TQm118 Qddm118 prof_m118 prom_prer,r nest save(MAT118)

* ÁLGEBRA I *

asdoc reg ecomate mujer ay_mat112 ddm112,r nest save(MAT112) replace
asdoc reg ecomate mujer ay_mat112 ddm112 prof_m112 prom_prer,r nest save(MAT112) 
asdoc reg ecomate mujer lic_m112 Lddm112, r nest save(MAT112)
asdoc reg ecomate mujer lic_m112 Lddm112 prof_m112 prom_prer, r nest save(MAT112)
asdoc reg ecomate mujer TQm112 Qddm112,r nest save(MAT112) 
asdoc reg ecomate mujer TQm112 Qddm112 prof_m112 prom_prer,r nest save(MAT112)

* ÁREA ECONÓMICA *  

asdoc reg ecomate mujer ayud_eco ddeco,r nest save(AREAECO) replace
asdoc reg ecomate mujer ayud_eco ddeco prof_e201 prom_prer,r nest save(AREAECO)
asdoc reg ecomate mujer lic_eco Lddeco, r nest save(AREAECO)
asdoc reg ecomate mujer lic_eco Lddeco prof_e201 prom_prer, r nest save(AREAECO)
asdoc reg ecomate mujer TQeco Qddeco, r nest save(AREAECO)
asdoc reg ecomate mujer TQeco Qddeco prof_e201 prom_prer, r nest save(AREAECO)

* ÁREA MATEMÁTICA *

asdoc reg ecomate mujer ayud_mat ddmat,r nest save(AREAMAT) replace
asdoc reg ecomate mujer ayud_mat ddmat prof_m108 prof_m118 prof_m112 prom_prer,r nest save(AREAMAT)
asdoc reg ecomate mujer lic_mat Lddmat, r nest save(AREAMAT)
asdoc reg ecomate mujer lic_mat Lddmat prof_m108 prof_m118 prof_m112 prom_prer, r nest save(AREAMAT)
asdoc reg ecomate mujer TQmat Qddmat, r nest save(AREAMAT)
asdoc reg ecomate mujer TQmat Qddmat prof_m108 prof_m118 prof_m112 prom_prer, r nest save(AREAMAT)



** modelo originall para hombres
gen hombre=0
replace hombre=1 if gen_alumno==2

gen ddeco=hombre*ayud_eco
gen ddmat=hombre*ayud_mat
gen dde121=hombre*ay_eco121
gen dde201=hombre*ay_eco201
gen ddm108=hombre*ay_mat108
gen ddm112=hombre*ay_mat112
gen ddm118=hombre*ay_mat118
gen dde221=hombre*ay_eco221

asdoc reg ecomate hombre ay_eco121 dde121,r nest save(regress) replace
asdoc reg ecomate hombre ay_eco201 dde201,r nest save(regress)
asdoc reg ecomate hombre ay_mat108 ddm108,r nest save(regress)
asdoc reg ecomate hombre ay_mat118 ddm118,r nest save(regress)
asdoc reg ecomate hombre ay_mat112 ddm112,r nest save(regress)
asdoc reg ecomate hombre ayud_eco ddeco,r nest save(regress)
asdoc reg ecomate hombre ayud_mat ddmat,r nest save(regress)





