#include<bits/stdc++.h>
using namespace std;

vector<int> res;
int n , r;


void comb(int pos)
{
	
	if((int)res.size()==r)
	{
			for(int i = 0; i < (int)res.size(); i++)
			{
				cout<<res[i]<<" ";
			}
			cout<<endl;
			return;
	}
	if(pos > n)
	return;
	res.push_back(pos);
	comb(pos+1);
	res.pop_back();
	comb(pos+1);
	return;
}

int main()
{
	cin>>n>>r;
	comb(1);
	return 0;
}
