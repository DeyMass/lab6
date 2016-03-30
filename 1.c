#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int dis (int a,int b,int c){
	int disc;
disc=b*b-(4*a*c);
return disc;
	}

double* xcal(int disc,int b,int a){
double *x;
x=(double*)malloc(2*sizeof(double));

if (disc<0) {printf("XREN'");return 0;}
if (disc==0){ x[0]=(-b)/(2*a); return x;}
if (disc>0){ x[0]=((-b)+pow(disc,1/2))/(2*a);x[1]=((-b)-pow(disc,1/2))/(2*a);return x;}  
return 0;
	}

int itog (int a,int b,int c){

double* x;

x=xcal ( dis(a,b,c) ,b,a);

printf("%lf\n%lf",x[0],x[1]);
return 0;
}
