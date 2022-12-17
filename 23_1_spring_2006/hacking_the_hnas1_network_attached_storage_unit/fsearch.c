// fsearch.c:  runs the "file" command on all byte offsets in an image file
// license:  GPL. See gnu.org for details.
// requires: an external "file" commands, and a Unixalike OS (cygwin works)
// caution:  fscan yeilds lots of false positives.
// compile:  cc fearch.c -o fscan
// usage:    fsearch imagefile


#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	FILE *in, *out;
	int t;
	char *buffer;
	char syss[1024];
	char resultsfile[1024],fname[1024];

	int fsize,wsize;

	if(argc<2)
	{
		fprintf(stderr,"%0 must be called with a filename argument\n",argv[0]);
		exit(1);
	}

	//the name of the results file
	snprintf(resultsfile,1024,"%s.results.txt",argv[1]);

	//Zero out the results file if it exists
	out=fopen(resultsfile,"wb");
	if(out==NULL)
	{
		fprintf(stderr,"coudln't write to filesystem\n");
		exit(1);
	
	}
	fclose(out);

	strcpy(fname,argv[1]);

	in=fopen(fname,"rb"); 
	if(in==NULL)
	{
		fprintf(stderr,"coudln't read %s\n",fname);
		exit(1);
	
	}

	//fetch the filesize
	fseek(in,0,SEEK_END);
	fsize=ftell(in);
	fclose(in);	

	
	buffer=malloc(fsize);
	if(buffer==NULL)
	{
		fprintf(stderr,"coudln't allocate buffer memory\n");
		exit(1);
	}
	in=fopen(fname,"rb");
	if(in==NULL)
	{
		fprintf(stderr,"coudln't open %s for reading\n",fname);
		free(buffer);
		exit(1);
	}
	if(fread(buffer,1,fsize,in)<fsize)
	{
		fprintf(stderr,"trouble reading %s\n",fname);
		free(buffer);
		exit(1);
	}
	fclose(in);
	for(t=0;t<fsize-1;t++)
	{
		out=fopen("filetype-guess","wb");
		if(out==NULL)
		{
			fprintf(stderr,"couldn't open 'filetype-guess' for writing\n");
			free(buffer);
			exit(1);
		}
		if(fsize-t>512)
			wsize=512;
		else
			wsize=fsize-t;
		fwrite(buffer+t,1,wsize,out);
		fclose(out);
		sprintf(syss,"echo 0x%x - $(file filetype-guess) >> %s",t,resultsfile);
		system(syss);
	}
	free(buffer);
#ifdef WIN32
	system("del filetype-guess 2>NUL"); 
#else
	system("rm filetype-guess 2>/dev/null");
#endif
	exit(0);
}


