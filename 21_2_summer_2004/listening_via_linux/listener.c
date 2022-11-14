// ***********************************************
// listener.c
// by solthae 
// Simple server code that allows for remote
// connections. Can have various uses (honeypot,
// listener, mud server, etc). I've hardcoded it
// to run on localhost with no specific service 
// being run, in hopes that those wishing to mod
// it for multiple clients, specific services, etc.
// will follow up and learn more on their own.
//
// Usage:
// listener 2600 &
// this will leave a process running as seen with
// 'ps', listening for connections on port 2600.
// ***********************************************
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

// error() reports an error then exits program 
void error(const char *err) {
    perror(err);
    exit(1);
}

int main(int argc, char **argv) {
    int z,x;
    struct sockaddr_in serverAddress;	// AF_INET family (like Momma's family)
    struct sockaddr_in clientAddress;	// AF_INET family
    unsigned short portNumber;		// Port Number for server
    FILE *rStream = NULL;  // Read Stream
    FILE *wStream = NULL;  // Write Stream
    int s; 		// Socket
    int c;		// Client Socket
    char buf[4096];  // I/O Buffer
    socklen_t addrlen;  // for accept(2) when using g++ compiler
    
    // Check for correct argument usage
    if(argc != 2) {
	fprintf(stderr,"Usage: %s <Port Number>\n", argv[0]);
	exit(1);
    }

    // Assign supplied argument as Port Number
    portNumber = atoi(argv[1]); 
    
    // Create a TCP/IP socket to use:
    if((s = socket(PF_INET,SOCK_STREAM,0)) == -1)
	error("socket(2)");

    // Fill in local address structure (that'd be our server address)
    memset(&serverAddress, 0, sizeof(serverAddress));   // Clear out structure
    serverAddress.sin_family = AF_INET;	      // Internet address family
    serverAddress.sin_addr.s_addr = htonl(INADDR_ANY);  // Any incomming interface
    serverAddress.sin_port = htons(portNumber);    // Local port to use
    
    // Bind to the server address:
    if((z = bind(s,(struct sockaddr *)&serverAddress,sizeof(serverAddress))) == -1)
	error("bind(2)");

    // Make it a listening socket:
    if((z = listen(s,10)) == -1)
	error("listen(2)");

    // The server loop:
    for(;;) {
	// Wait for a connection:
	addrlen = sizeof(clientAddress);
	if((c = accept(s,(struct sockaddr *)&clientAddress,&addrlen)) == -1)
	    error("accept(2)");

	// Thr read stream is where the clients requests are going
	// to becomming in through (don't mix them up)
	// create read stream:
	if(!(rStream = fdopen(c,"r"))) {
	    close(c);
	    continue;
	}

	// The write stream is where you are going to print your
	// messages (like requests) to the client (don't mix them up)
	// create write stream
	if(!(wStream = fdopen(dup(c),"w"))) {
	    fclose(rStream);
	    continue;
	}

	// Set both streams to line buffered mode:
	setlinebuf(rStream);
	setlinebuf(wStream);

	printf("---------------------------------\n");
	printf("Put a telnet message here for fun\n");
	printf("---------------------------------\n");
	
	// ------------------------NOTE TO READERS---------------------------
	// This is the main workhorse of the code. This takes requests from 
	// the client through the read stream rStream. You then can process these
	// 'requests' (i.e., sent text, etc.) as a 'char buf[]' (i.e, string).
	// Below: process 1 echo's sent command, process 2 prints stringlen,
	// and the last one goes through buf on by one printing the chars.
	// Enjoy making creative ways to process buf from different clients!
	// ------------------------------------------------------------------
	// Process client's requests:
	while(fgets(buf,sizeof buf,rStream)) {
	    printf("\necho: %s",buf);         //---- Process 1
      	    printf("\nsize: %d",strlen(buf)); //---- Process 2
	    for(x=0;x<strlen(buf);x++)        //---- Process 3
	        printf("\n%c",buf[x]);
	}
	    
	// Close client's connection
	fclose(wStream);
	shutdown(fileno(rStream),SHUT_RDWR);
	fclose(rStream);
    }

    // If control gets here there's a major problem with time/space
    return 0;
}    
