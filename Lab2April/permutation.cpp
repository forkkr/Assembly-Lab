#include<bits/stdc++.h>
using namespace std;

int ar[111];
int n;
int cnt = 0;
void perm(int pos)
{
	if(pos > n)
	{
		for(int i = 1; i <= n; i++)
		{
			cout<<ar[i]<<" ";
		}
		cout<<endl;
		cnt +=1;
	}
	for(int i = pos; i <= n; i++)
	{
		swap(ar[i], ar[pos]);
		perm(pos+1);
		swap(ar[i] , ar[pos]);
	}
	return;
}

int main()
{
	cin>>n;
	for(int i = 1; i <= n; i++)
	{
		ar[i] = i;
	}
	perm(1);
	cout<<cnt<<endl;
}
