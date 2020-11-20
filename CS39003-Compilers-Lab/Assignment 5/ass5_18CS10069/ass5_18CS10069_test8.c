int f(int a, int b){
    return a>>1 + b;
}

int fun(int x){
    f(x, x);
    {
        int y = 0;
        y = f(x, y);
        {
            int yy = 1;
            yy = f(yy, y);
        }
    }
}

int main(){
    int dp[10][10];
    int x = 10, r;

    for(int l=1;l<10;l++){
        for(int i=0;i<10;i++){                        // NESTED FOR
            for(int j=i+l;j<10;j++){
                while(i<l && i>=0 || l<10){           // BOOLEAN CONJUGATED
                    do{
                        x = x>1?1:0;
                        if(x<0)x++;
                    } while(r<10);
                }
            }
        }
    }
    r = 10;
    fun(r);
}