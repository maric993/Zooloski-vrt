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
    char ulaz[3][WORD_SIZE];
    
	if(argc < 3)
        error_fatal("Unesite user i passwd");

	// Konektovanje na bazu
	konekcija = mysql_init (NULL);
	if (mysql_real_connect(konekcija, "localhost", argv[1], argv[2], "zooPBP", 0, NULL, 0) == NULL){
		error_fatal ("Greska u konekciji. %s\n", mysql_error (konekcija));
	}

    

    int kraj=1;
    while(kraj){
    printf("Odaberite jednu od sledecih opcija:\n");
    
    printf("1.Prikazi rezervne kaveze za sve kaveze\n");
    printf("2.Unosenje podataka o novoj zivotinj\n");
    printf("3.Unosenje podataka o hranjenju zivotine\n");
    printf("4.Predlozi novi kavez za zivotinju\n");
    printf("5.Otvori novu terapiju\n");
    printf("0 Za zavrsetak programa\n");
    
    scanf("%d",&opcija);
    switch (opcija) {
        case 1:
            sprintf (query, "Select k.id_kaveza ,pk.id_privremenog \
            from Kavez k inner join Privremeni_kavez pk\
            where k.id_kaveza = pk.id_kaveza");
 
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
            break;
        case 3:
          
            printf("Unesite id zivotinje id hrane i kolicinu\n");
            scanf("%s %s %s",ulaz[0],ulaz[1], ulaz[2]); 
            sprintf (query, "Insert into Raspored_hranjenja values (\"%s\",\"%s\",now(),\"%s\");",ulaz[0],ulaz[1],ulaz[2]);
 
            if (mysql_query (konekcija, query) != 0)
                error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
            
            break;
        case 4:
            break;
        case 5:
            break;
        case 0:
           kraj=0;
           break;
        default:
            error_fatal ("Niste odabrali dobru opciju");
    }
	
}
	
	
	exit(EXIT_SUCCESS);
}
