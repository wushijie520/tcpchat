#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
using namespace std;

#define MAXLINE 4096

int main(int argc,char **argv){

int listenfd,connfd,n;
struct sockaddr_in serveaddr;
char buff[4096];


if((listenfd=socket(AF_INET,SOCK_STREAM,0))==-1){
printf("create socket error:%s(errno:%d)n",strerror(errno),errno);
return 0;
}

memset(&serveaddr,0,sizeof(serveaddr));
serveaddr.sin_family=AF_INET;
serveaddr.sin_addr.s_addr=htonl(INADDR_ANY);
serveaddr.sin_port=htons(6666);

if(bind(listenfd,(struct sockaddr*)&serveaddr,sizeof(serveaddr))==-1){
printf("bind error:%s(errno:%d)\n",strerror(errno),errno);
return 0;

}

if(listen(listenfd,10)==-1){
printf("listen socket error:%s(errno:%d)\n",strerror(errno),errno);
return 0;

}
printf("=======waiting for client request===========");
while(1){
if((connfd=accept(listenfd,(struct sockaddr*)NULL,NULL))==-1){
printf("accept socket error；%s(errno:%d)\n",strerror(errno),errno);
continue;

}
n=recv(connfd,buff,MAXLINE,0);
buff[n]='\0';
printf("recv msg from client:%s\n",buff);
close(connfd);

}
close(listenfd);
return 0;
}
