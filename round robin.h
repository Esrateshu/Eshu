#include<stdio.h>
int main()
{
int i,n,p[100]={0},min,k=1,btime=0;
int bt[100]={0},temp,j,at[100]={0},wt[100]={0},tt[100],ct[100]={0},ta=0,sum=0;
float wavg=0,tavg=0,tsum=0,wsum=0;
printf("==========Shortest Job First Scheduling==========\n");
    printf(" Enter the array size: ");
    scanf("%d",&n);

    printf("Enter the process sequence: ");

    for(i=0;i<n;i++)
    {
        scanf("%d",&p[i]);
    }
    printf("Enter the arrival time: ");

    for(i=0;i<n;i++)
    {
        scanf("%d",&at[i]);
    }
    printf("Enter the burst time: ");

    for(i=0;i<n;i++)
    {
        scanf("%d",&bt[i]);
    }

/*Sorting According to Arrival Time*/

for(i=0;i<n;i++)
{
for(j=0;j<n;j++)
{
if(at[i]<at[j])
{
temp=p[j];
p[j]=p[i];
p[i]=temp;
temp=at[j];
at[j]=at[i];
at[i]=temp;
temp=bt[j];
bt[j]=bt[i];
bt[i]=temp;
}
}
}

/*Arranging the table according to Burst time,
Burst time and Arrival Time
Arrival time <= Burst time
*/

for(j=0;j<n;j++)
{
btime=btime+bt[j];
min=bt[k];
for(i=k;i<n;i++)
{
if (btime>=at[i] && bt[i]<min)
{
temp=p[k];
p[k]=p[i];
p[i]=temp;
temp=at[k];
at[k]=at[i];
at[i]=temp;
temp=bt[k];
bt[k]=bt[i];
bt[i]=temp;
}
}
k++;
}

for(i=1;i<n;i++)
{
sum=sum+bt[i-1];
wt[i]=sum-at[i];
wsum=wsum+wt[i];
}

wavg=(wsum/n);
for(i=0;i<n;i++)
    {
        sum=sum+bt[i];
        ct[i]+=sum;
    }

for(i=0;i<n;i++)
{
ta=ta+bt[i];
tt[i]=ta-at[i];
tsum=tsum+tt[i];
}

tavg=(tsum/n);


printf("\n\n*********************************************Solution*********************************************\n\n");
printf("---------------------------------------------------------------------------------------------------\n");
printf("\nProcess\t Burst Time\t Arrival Time\t Waiting Time\t Completion time\t Turn-around Time\n" );
printf("---------------------------------------------------------------------------------------------------\n");

for(i=0;i<n;i++)
{
printf("\n p%d\t   %d\t\t\t%d\t\t   %d\t\t    %d\t\t\t%d",p[i],bt[i],at[i],wt[i],ct[i],tt[i]);
}

printf("\n\nAVERAGE WAITING TIME : %f",wavg);
printf("\nAVERAGE TURN AROUND TIME : %f",tavg);
return 0;
}
