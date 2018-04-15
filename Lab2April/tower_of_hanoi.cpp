#include<bits/stdc++.h>
using namespace std;

void hanoi(int n , int src, int des , int aux)
{
	if(n==1)
	{
		cout<<"Move "<<"Disk "<<n<<" "<<"from Stick "<<src<<" Stick "<<des<<endl;
		return;
	}
	hanoi(n-1 , src , aux , des);
	cout<<"Move "<<"Disk "<<n<<" "<<"from Stick "<<src<<" Stick "<<des<<endl;
	hanoi(n-1 , aux , des , src );
}

int main()
{
	int n;
	cin>>n;
	hanoi(n , 1 , 3 , 2);
	return 0;
}
