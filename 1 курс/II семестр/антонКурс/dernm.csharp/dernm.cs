
using System;

class dernm
{
    /*
    This members must be defined by you:
    static double f(double x)
    */


    /*************************************************************************
    Вычисление M-ой производной путем построения интерполяционного полинома
    по N точкам, размещенным в корнях полинома Чебышева N-ой степени.

    Входные параметры:
        X   -   точка, в которой считаем производную
        H   -   шаг дифференцирования. Точки вычисления функции будут размещены
                на области (X-H, X+H)
        M   -   порядок производной. M>=0
        N   -   число используемых точек, N>=1

    Результат - M-ая производная функции F в точке X
    *************************************************************************/
    public static double derivativenm(double x,
        double h,
        int m,
        int n)
    {
        double result = 0;
        double[] fk = new double[0];
        double[] c = new double[0];
        double[] p = new double[0];
        int i = 0;
        int j = 0;
        int k = 0;
        double b1 = 0;
        double b2 = 0;
        double e = 0;
        double d = 0;

        if( n==0 )
        {
            result = 0;
            return result;
        }
        if( n==1 )
        {
            if( m==0 )
            {
                result = f(x);
            }
            else
            {
                result = 0;
            }
            return result;
        }
        fk = new double[n+1];
        for(k=1; k<=n; k++)
        {
            fk[k] = f(x+h*Math.Cos(Math.PI*(k-0.5)/n));
        }
        c = new double[n-1+1];
        for(j=0; j<=n-1; j++)
        {
            c[j] = 0;
            for(k=1; k<=n; k++)
            {
                c[j] = c[j]+fk[k]*Math.Cos(Math.PI*j*(k-0.5)/n);
            }
            if( j==0 )
            {
                c[j] = c[j]/n;
            }
            else
            {
                c[j] = 2*c[j]/n;
            }
        }
        p = new double[n-1+1];
        for(i=0; i<=n-1; i++)
        {
            p[i] = 0;
        }
        d = 0;
        i = 0;
        do
        {
            k = i;
            do
            {
                e = p[k];
                p[k] = 0;
                if( i<=1 & k==i )
                {
                    p[k] = 1;
                }
                else
                {
                    if( i!=0 )
                    {
                        p[k] = 2*d;
                    }
                    if( k>i+1 )
                    {
                        p[k] = p[k]-p[k-2];
                    }
                }
                d = e;
                k = k+1;
            }
            while( k<=n-1 );
            d = p[i];
            e = 0;
            k = i;
            while( k<=n-1 )
            {
                e = e+p[k]*c[k];
                k = k+2;
            }
            p[i] = e;
            i = i+1;
        }
        while( i<=n-1 );
        if( m>n-1 )
        {
            result = 0;
            return result;
        }
        result = p[m];
        for(i=1; i<=m; i++)
        {
            result = result*i/h;
        }
        return result;
    }
}
