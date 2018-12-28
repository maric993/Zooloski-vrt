#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <stdarg.h>
#include <errno.h>
#define WORD_SIZE 30
#define QUERY_SIZE 256
#define BUFFER_SIZE 80

static void error_fatal (char *format, ...){
	/* Lista argumenata funkcije. */
	va_list arguments;

	/* Stampa se string predstavljen argumentima funkcije. */
	va_start (arguments, format);
	vfprintf (stderr, format, arguments);
	va_end (arguments);

	/* Prekida se program. */
	exit (EXIT_FAILURE);
}

int main(int argc, char**argv){
	
	
	MYSQL *konekcija;	/* Promenljiva za konekciju. */
	MYSQL_RES *rezultat;	/* Promenljiva za rezultat. */
	MYSQL_ROW red;	/* Promenljiva za jedan red rezultata. */
	MYSQL_FIELD *polje;	/* Promenljiva za nazive kolona. */
	int i;		/* Brojac u petljama. */
	int broj_kolona;		/* Pomocna promenljiva za broj kolona. */	
    int opcija;
	char query[QUERY_SIZE];	/* Promenljiva za formuaciju upita. */
	int prosli=1;
    char ulaz[10][WORD_SIZE];
    char odgovor[WORD_SIZE];
    char zivotinja[10][20]={"id zivotinje","id vrste","ime","naizv vrste","datum rodjenja","pol","interval ishrane","status","datum useljenja","datum iseljenja"};
    int kraj=1;
    char * celaLinija=NULL;
    
	if(argc < 3)
        error_fatal("Unesite user i passwd");

	// Konektovanje na bazu
	konekcija = mysql_init (NULL);
	if (mysql_real_connect(konekcija, "localhost", argv[1], argv[2], "zooPBP", 0, NULL, 0) == NULL){
		error_fatal ("Greska u konekciji. %s\n", mysql_error (konekcija));
	}

    

    
    while(kraj){
    printf("Odaberite jednu od sledecih opcija:\n");
    
    printf("1.Prikazi rezervne kaveze\n");
    printf("2.Unosenje podataka o novoj zivotinj\n");
    printf("3.Unosenje podataka o hranjenju zivotine\n");
    printf("4.Otvori novu terapiju\n");
    printf("5.Pregled\n");
    printf("6.Zatvaranje dosijea zivotinje\n");
    printf("0. Za zavrsetak programa\n");
    
    scanf("%d",&opcija);
    switch (opcija) {
        case 1:
            printf("Unesti id kaveza koji se zadrvara zbog odrzavanja, ili '0' za sve kaveze\n");
            scanf("%s",ulaz[0]);
            if(!strcmp(ulaz[0],"0")){
                sprintf (query, "Select k.id_kaveza ,pk.id_privremenog \
            from Kavez k inner join Privremeni_kavez pk\
            where k.id_kaveza = pk.id_kaveza");
            }
            else{
                sprintf (query, "Select k.id_kaveza ,pk.id_privremenog \
                from Kavez k inner join Privremeni_kavez pk\
                where k.id_kaveza = pk.id_kaveza and k.id_kaveza=\"%s\"",ulaz[0]);
            }
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));

 
            rezultat = mysql_use_result (konekcija);
            broj_kolona = mysql_num_fields (rezultat);
            polje = mysql_fetch_field (rezultat);
            
            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");
  
            while ((red = mysql_fetch_row (rezultat)) != 0){
                if(prosli!=atoi(red[0])){
                    printf("------------------------------\n");
                    prosli = atoi(red[0]);
                }
                printf ("%s\t\t%s\n", red[0],red[1]);
            }

            mysql_free_result (rezultat);
            printf("\n");
            break;
        case 2:
            printf("Da li zelite da koristite podatke iz tabele vrsta?\n");
            scanf("%s",odgovor);
            if(!strcmp(odgovor,"da")){
            for(i=1;i<10;i++){
                if(i==3 || i==6)
                    i++;
                   
                printf("Unesite %s\n",zivotinja[i]);
                scanf("%s",ulaz[i]);
                if(i==1){
                     sprintf (query, "Select naziv , interval_ishrane \
                     from Vrsta\
                     where id_vrste = \"%s\"",ulaz[1]);
                     if (mysql_query (konekcija, query) != 0){
                        error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
                     }
                        rezultat = mysql_use_result (konekcija);
                        broj_kolona = mysql_num_fields (rezultat);
                        
                        if(broj_kolona !=2)
                            error_fatal("Nema podataka u bazi Vrsta za zivotinju sa datim id-om\n");
                        
                        
                        red = mysql_fetch_row (rezultat);
                        
                    
                 }
            }
       
                if(!strcmp(ulaz[9],"null"))
                    sprintf (query, "Insert into Zivotinja values (0,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",null);",ulaz[1],ulaz[2],red[0],ulaz[4],ulaz[5],red[1],ulaz[7],ulaz[8]);
                else
                    sprintf (query, "Insert into Zivotinja values (0,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\");",ulaz[1],ulaz[2],red[0],ulaz[4],ulaz[5],red[1],ulaz[7],ulaz[8],ulaz[9]);
                
                mysql_free_result (rezultat);
                
                if (mysql_query (konekcija, query) != 0)
                     error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));                        
                printf("\n");
            
            }
            else{

            for(i=1;i<10;i++){
            printf("Unesite %s\n",zivotinja[i]);
            scanf("\n");
            size_t duzina=0;
            getline(&celaLinija,&duzina,stdin);
            strncpy(ulaz[i],celaLinija,(int)strlen(celaLinija)-1);
        
            }
           printf("%s",ulaz[9]);
           if(!strcmp(ulaz[9],"null"))
                    sprintf (query, "Insert into Zivotinja values (0,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",null);",ulaz[1],ulaz[2],ulaz[3],ulaz[4],ulaz[5],ulaz[6],ulaz[7],ulaz[8]);
                else
                    sprintf (query, "Insert into Zivotinja values (0,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\");",ulaz[1],ulaz[2],ulaz[3],ulaz[4],ulaz[5],ulaz[6],ulaz[7],ulaz[8],ulaz[9]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            }
            
            sprintf (query, "Select *from Zivotinja ");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
            
             printf("----------------------------------------\n");
            
             sprintf (query, "Select naziv,broj_stanara from Vrsta");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
            
            printf("----------------------------------------\n");
            
            sprintf (query, "Select *from Zdravstveni_kartoni ");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
            
            break;
        case 3:
            printf("Unesite id zivotinje id hrane i kolicinu\n");
            scanf("%s %s %s",ulaz[0],ulaz[1], ulaz[2]); 
            printf("%s\n",ulaz[2]);
            sprintf (query, "Insert into Raspored_hranjenja values (\"%s\",\"%s\",now(),\"%s\");",ulaz[0],ulaz[1],ulaz[2]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            sprintf (query, "Select *from Hrana ");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
        
            break;
        case 4:
             sprintf (query, "Select id_zivotinje ,ime from Zivotinja ");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
            
            
            printf("Unesite id zivotinje\n");
            scanf("%s",ulaz[0]);
            sprintf (query, "Select id_kartona from Zdravstveni_kartoni where id_zivotinje = \"%s\"",ulaz[0]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            broj_kolona = mysql_num_fields (rezultat);
             if(broj_kolona !=1)
                  error_fatal("Nema podataka u bazi Zivotinja za stanara sa datim id-om\n");
                        
 
            red = mysql_fetch_row (rezultat);
           
            
            
            printf("Unesite datum pocetka i kraja terapije\n");
            scanf("%s %*c %s",ulaz[0],ulaz[1]);
            
            printf("Unesite dijagnozu\n");
            scanf("%s",ulaz[2]);
           
            sprintf (query, "insert into Terapija values(0,\"%s\",\"%s\",\"%s\",\"%s\")",red[0],ulaz[0],ulaz[1],ulaz[2]);
            mysql_free_result (rezultat);
            
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            break;
        case 5:
            printf("Unesite id zivotinje\n");
                scanf("%s",ulaz[0]);
            printf("Unesite opis zdravstvenog stanja\n");
            getchar();
            char opis[500];
            fgets(opis,500,stdin);
            sprintf (query, "update Zdravstveni_kartoni set opis=\"%s\",datum_poslednjeg_pregleda=CURDATE() ,datum_kontrole= CURDATE() + INTERVAL 30 DAY where id_zivotinje = \"%s\"",opis,ulaz[0]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
             printf("----------------------------------------\n");
            
            sprintf (query, "Select *from Zdravstveni_kartoni ");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
            
            
            break;
        case 6:
            printf("Unesite id zivotinje\n");
                scanf("%s",ulaz[0]);
            strcpy(ulaz[1],"N");
           sprintf (query, "update Zivotinja set status =\"%s\"  where id_zivotinje=\"%s\"",ulaz[1],ulaz[0]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija)); 
            
            sprintf (query, "update Zdravstveni_kartoni set datum_kontrole = NULL where id_zivotinje=\"%s\"",ulaz[0]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija)); 
                
                
             printf("----------------------------------------\n");
            
            sprintf (query, "Select *from Zdravstveni_kartoni ");
             
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            rezultat = mysql_use_result (konekcija);
            polje = mysql_fetch_field (rezultat);
            broj_kolona = mysql_num_fields (rezultat);

            for (i = 0; i < broj_kolona; i++)
                printf ("%s\t", polje[i].name);
            printf ("\n");


            while ((red = mysql_fetch_row (rezultat)) != 0){
                for (i = 0; i < broj_kolona; i++)
                    printf ("%s\t", red[i]);
            printf ("\n");
            }
            mysql_free_result (rezultat);
        case 0:
           kraj=0;
           break;
        default:
            error_fatal ("Niste odabrali dobru opciju\n");
            
    }
	
}
	
	
	exit(EXIT_SUCCESS);
}
