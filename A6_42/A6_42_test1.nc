int main()
{
	int j = 0;
        printStr(" Hello ");
	int i = 8;
	if( i > 2)
	{
	 if(i<75358){
	  printStr("world\n");
		}
			
	i=i+2;
	
	}
     	int i,ep;
     	printStr("enter the i : ");
        i = readInt(&ep);
     	printStr("\n address: ");
     	printInt(&i);
     	int *k;
     	k=&i;
     	printStr("\n Pointer val: ");
     	printInt(*k);
     	printStr("\n\nYou Entered : ");
     	printInt(i);
	
	i = i / 2;
	i = i * 2;
	j = i + i;
	j = i % i;

return 0;
}

