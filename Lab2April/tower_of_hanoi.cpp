#include<bits/stdc++.h>
using namespace std;

int cnt = 0;
void hanoi(int n )
{
	if(n==1)
	{
		cnt++;
		return;
	}
	hanoi(n-1 );
	cnt++;
	hanoi(n-1);
}

int main()
{
	int n;
	cin>>n;
	hanoi(n);
	cout<<cnt<<endl;
	return 0;
}
