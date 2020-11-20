#include "stdio.h"
#include "stdlib.h"
#include "math.h"

// structure for point
typedef struct point{
    double x;                   // x-coordinate of the point
    double y;                   // y-coordinate of the point
}POINT;

// circle can be represented by POINT only
// this is because the radius is same for all

// structure for line segment 
typedef struct line{
    POINT begin;                // start point of the line segment
    POINT end;                  // end point of the line segment
}LINE;

// angle -> clockwise (measure): negative & anti-clockwise (measure): positive 
// structure for the arc
typedef struct arc{
    POINT center;               // center of the arc (circle)
    double begin;               // begin angle
    double end;                 // end angle
}ARC;

void printPointArray(POINT* S, int n);
void mergesort(POINT* S, int l, int r);
void merge(POINT* S, int l, int mid, int r);
int CH(POINT* S, int n, int flag, POINT* H);
int turn(POINT a, POINT b, POINT c);
void printcontzone(int u, int l, LINE* T, ARC* A);
void contzone(POINT* UH, int u, POINT* LH, int l, double r, LINE* T, ARC* A);
void upperContZone(POINT* UH, int u, double r, LINE* T, ARC* A);
void lowerContZone(POINT* LH, int u, int l, double r, LINE* T, ARC* A);

/*
*** This is the merge function (a sub-routine essentially called in mergesort())
*** input: S -> [POINT*] array of points
           l -> [int] left index of the portion to be sorted
           mid -> [int] mid index of the portion to be sorted
           r -> [int] right index of the portion to be sorted 
*** output: [void] no return
*/
void merge(POINT* S, int l, int mid, int r)
{
    // array left -> S[l...mid]
    // array right -> S[(mid+1)...r]
    // merge left and right w.r.t the x-coordinate of the points
    // store the merged array in S[l...r]
    int n1 = mid - l + 1;
    int n2 = r - mid;
    int i, j, k;

    // design two temp arrays
    // copy the S[l..mid] into left array
    // copy the S[(mid+1)...r] into right array
    POINT* left = (POINT*)malloc(n1 * sizeof(POINT));
    POINT* right = (POINT*)malloc(n2 * sizeof(POINT));

    for(i = 0; i < n1; i++) 
        left[i] = S[l + i]; 

    for(j = 0; j < n2; j++) 
        right[j] = S[mid + 1 + j]; 

    // set the indices for merging
    // merge w.r.t x-coordinate of points
    i = 0, j = 0, k = l;
    while(i < n1 && j < n2)
    {
        if(left[i].x <= right[j].x)
        { 
            S[k] = left[i]; 
            i++; 
        } 
        else 
        { 
            S[k] = right[j]; 
            j++; 
        } 
        k++;
    }

    // copy the rest of array of either left or right
    // depending on whichever is remaining
    while(i < n1)
    {
        S[k] = left[i]; 
        i++; 
        k++;
    }

    while(j < n2)
    {
        S[k] = right[j]; 
        j++; 
        k++;
    }

    return;
}

/*
*** This is the basic mergesort functions
*** Sorts an array of points with respect to their x-coordinate
*** input: S -> [POINT*] array of POINTs to be sorted
           l -> [int] left index of the portion to be sorted
           r -> [int] right index of the portion to be sorted 
*** output: [void] no return
*/
void mergesort(POINT* S, int l, int r)
{
    // the recursion is till l < r
    if(l < r)
    {
        // find the mid point
        int mid = l + (r - l) / 2;
        mergesort(S, l, mid);
        mergesort(S, mid+1, r);

        // merge the left sorted and right sorted array
        merge(S, l, mid, r);
    }
    return;
}

/*
*** This function evaluates the nature of turn going from points a to b to c 
*** the input points are sorted according to their x-coordinate
*** input: a -> [POINT] left-most point of turn
           b -> [POINT] middle point of turn
           c -> [POINT] right-most point of turn
*** output: [int] if left turn return 1
                  else if right turn return 0  
*/
int turn(POINT a, POINT b, POINT c)
{
    // find the nature of turn from a -> b -> c
    double t = (b.y - a.y) * (c.x - b.x) - (b.x - a.x) * (c.y - b.y);

    // if t is less than zero then a left turn
    // else a right turn
    // points are in generic position, thus only left or right turn possible
    int turnLeft = (t < 0) ? 1 : 0;
    return turnLeft;
}

/*
*** This function evaluates either the UH or LH
*** Decided by the flag input
*** input: S -> [POINT*] array of POINTs
           n -> [int] length of S
           flag -> [int] to decide whether UH or LH to be found.
                   if flag = 1: find the upper hull
                   else find the lower hull
           H -> [POINT*] array of point on UH or LH 
*** output: [int] length (number of points) of H   
*/
int CH(POINT* S, int n, int flag, POINT* H)
{
    // if flag is 1 -> evaluate the UH
    // if flag is 0 -> evaluate the LH
    // if there are less than 3 points, no UH or LH is possible -> return 0
    if(n < 3)
        return 0;

    int top = 1, i, turnLeft;       // stack top pointer 
    POINT next;                     // next point in S

    // compute UH in H
    if(flag == 1)
    {
        // initialize the first two entries of stack 
        // as the left-most and next point in S
        H[0] = S[0];
        H[1] = S[1];

        // iterate through the S array from 2...(n-1)
        for(i = 2; i < n; i++)
        {
            next = S[i];            

            // check if top - 1 -> top -> next is a left turn
            // if left turn, then pop top of the stack 
            turnLeft = turn(H[top-1], H[top], next);

            while(top > 0 && turnLeft)
            {
                // turnLeft is true -> pop the top of the stack
                // evaluate the turnLeft with new top - 1, top and next
                top--;
                turnLeft = turn(H[top-1], H[top], next);
            }

            // increment the top counter of stack
            // store the next point of hull in H
            top++;
            H[top] = next;
        }
        // length of the hull is top + 1
        return (top + 1);
    } 

    // compute LH in H
    else if(flag == 0)
    {
        // initialize the first two entries of stack 
        // as the right-most and previous point in S
        H[0] = S[n-1];
        H[1] = S[n-2];

        // iterate through the S array from (n-3)...0
        for(i = n-3; i >= 0; i--)
        {
            next = S[i];

            // check if next -> top -> top - 1 is a left turn
            // if not a left turn, then pop top of the stack 
            turnLeft = turn(next, H[top], H[top-1]);
            while(top > 0 && !turnLeft)
            {

                // turnLeft is false -> right turn -> pop the top of the stack
                // evaluate the turnLeft with new next -> top -> top - 1 triplet
                top--;
                turnLeft = turn(next, H[top], H[top-1]); 
            }

            // increment the top counter of stack
            // store the next point of hull in H
            top++;
            H[top] = next;
        }

        // length of the hull is top + 1
        return (top + 1);
    }

    // default to return 
    // since it is neither UH or LH
    // this would never come, until some exception occurs
    return 0;
}

/*
*** This function prints the containment zone as asked in problem statement
*** input: u -> [int] the size of upper hull
           l -> [int] the size of lower hull
           T -> [LINE*] the list of tangents
           A -> [ARC*] the list of arcs
*** output: [void] no return 
*/
void printcontzone(int u, int l, LINE* T, ARC* A)
{
    // the upper contzone contains u from As and u - 1 from Ts
    // print the upper part first
    // move to the lower part
    int i;
    printf("\n+++ The containment zone\n");

    // start with the upper section
    printf("--- Upper section\n");
    for(i = 0; i < u; i++)
    {
        // print the arc description
        printf("\tArc\t: (%0.15lf,%0.15lf) From %0.15lf to %0.15lf\n", A[i].center.x, A[i].center.y, A[i].begin, A[i].end);

        // print u - 1 tangents
        if(i < u - 1)
            printf("\tTangent\t: From (%0.15lf,%0.15lf) to (%0.15lf,%0.15lf)\n", T[i].begin.x, T[i].begin.y, T[i].end.x, T[i].end.y);
    }

    // end with the lower section
    printf("--- Lower section\n");
    for(i = u; i < u + l; i++)
    {
        // print the arc description
        printf("\tArc\t: (%0.15lf,%0.15lf) From %0.15lf to %0.15lf\n", A[i].center.x, A[i].center.y, A[i].begin, A[i].end);

        // print l - 1 tangents
        if(i < u + l - 1)
            printf("\tTangent\t: From (%0.15lf,%0.15lf) to (%0.15lf,%0.15lf)\n", T[i-1].begin.x, T[i-1].begin.y, T[i-1].end.x, T[i-1].end.y);
    }
    return;
}

/*
*** This function finds the upper portion of the containment zone
*** input: UH -> [POINT*] array of points of Upper hull
           u -> [int] size of upper hull
           r -> [double] radius of circle (containment zone)
           T -> [LINE*] the list of tangents
           A -> [ARC*] the list of arcs 
*** output: [void] no return
*/
void upperContZone(POINT* UH, int u, double r, LINE* T, ARC* A)
{
    double PI = 2*acos(0.0), slope, xcoord, ycoord;
    POINT b, e;
    int i;

    // add the first entry of A
    A[0].center.x = UH[0].x;
    A[0].center.y = UH[0].y;
    A[0].begin = PI;

    for(i = 0; i < u; i++)
    {
        // if the last containment zone of the upper hull
        // we have all the information
        // just fill the entry and return
        if(i == u - 1)
        {
            A[i].end = 0.0;
            return;
        }

        // evaluate the end angle
        // slope of the line and add pi/2 to it
        slope = (UH[i+1].y - UH[i].y) / (UH[i+1].x - UH[i].x);
        A[i].end = atan(slope) + (PI/2);

        // fill up the next arcs begin info
        A[i+1].begin = A[i].end;
        A[i+1].center.x = UH[i+1].x;
        A[i+1].center.y = UH[i+1].y;

        // evaluate the begin (b) point of the tangent
        xcoord = r * cos(A[i].end);
        ycoord = r * sin(A[i].end);
        b.x = xcoord + UH[i].x;
        b.y = ycoord + UH[i].y;

        // evaluate the end (e) point of the tangent
        e.x = xcoord + UH[i+1].x;
        e.y = ycoord + UH[i+1].y;

        // fill up the tangent begin and end points
        T[i].begin = b;
        T[i].end = e;
    }

    // all the required arcs and tangents are evaluated
    // return
    return;
}

/*
*** This function finds the lower portion of the containment zone
*** input: LH -> [POINT*] array of points of Lower hull
           u -> [int] size of upper hull
           l -> [int] size of lower hull
           r -> [double] radius of circle (containment zone)
           T -> [LINE*] the list of tangents
           A -> [ARC*] the list of arcs 
*** output: [void] no return
*/
void lowerContZone(POINT* LH, int u, int l, double r, LINE* T, ARC* A)
{
    double PI = 2*acos(0.0), slope, xcoord, ycoord;
    POINT b, e;
    int i;

    // add the u-th entry of A
    A[u].center.x = LH[0].x;
    A[u].center.y = LH[0].y;
    A[u].begin = 0.0;

    for(i = 0; i < l; i++)
    {
        // if the last containment zone of the upper hull
        // we have all the information
        // just fill the entry and return
        if(i == l - 1)
        {
            A[u + i].end = -1 * PI;
            return;
        }

        // evaluate the end angle
        // slope of the line and add pi/2 to it
        slope = (LH[i+1].y - LH[i].y) / (LH[i+1].x - LH[i].x);
        A[u + i].end = atan(slope) - (PI/2);

        // fill up the next arcs begin info
        A[u+i+1].begin = A[u+i].end;
        A[u+i+1].center.x = LH[i+1].x;
        A[u+i+1].center.y = LH[i+1].y;

        // evaluate the begin (b) point of the tangent
        xcoord = r * cos(A[u+i].end);
        ycoord = r * sin(A[u+i].end);
        b.x = xcoord + LH[i].x;
        b.y = ycoord + LH[i].y;

        // evaluate the end (e) point of the tangent
        e.x = xcoord + LH[i+1].x;
        e.y = ycoord + LH[i+1].y;

        // fill up the tangent begin and end points
        T[u+i-1].begin = b;
        T[u+i-1].end = e;
    }

    // all the required arcs and tangents are evaluated
    // return
    return;
}

/*
*** This function builds the containment zone 
*** input: UH -> [POINT*] point array of upper hull
           u -> [int] size of the upper hull
           LH -> [POINT*] point array of lower hull
           l -> [int] size of the lower hull 
           r -> [double] radius of each circle
           T -> [LINE*] list of line segments i.e. tangents
           A -> [ARC*] list of arcs 
*** output: [void] no return
*/
void contzone(POINT* UH, int u, POINT* LH, int l, double r, LINE* T, ARC* A)
{
    // update the T and A with the upperContZone()
    // extend the T and A with the lowerContZone()

    // uperContZone() fills the first u entries of A
    // also fills the first u - 1 entries of T
    upperContZone(UH, u, r, T, A);

    // lowerContZone() fills the next l entries of A
    // also fills the next l - 1 entries of T 
    lowerContZone(LH, u, l, r, T, A);

    // completely filled T and A
    // return
    return;
}

/*
*** This function prints an array of points
*** input: S -> [POINT*] array of points
           n -> [int] length of array S 
*** output: [void] no return
*/
void printPointArray(POINT* S, int n)
{
    // loop over the S array 
    // print all the points in (x, y) form
    int i;
    for(i = 0; i < n; i++)
        printf("\t%0.15lf %0.15lf\n", S[i].x, S[i].y);
    
    return;
}

int main()
{
    printf("\n---------- Welcome to Second Programming Assignment on Convex Hulls ----------\n");
    printf("++ Name: Siba Smarak Panigrahi\n");
    printf("++ Roll No.: 18CS10069\n");
    printf("---------- Introduction Over ----------\n");

    // n is the number of points to be stored in S
    // S contains the center of containment zones
    // r is the radius of each circle - size of each circular containment zone
    int n, i;
    double r;

    // read n and r
    scanf("%d", &n);
    scanf("%lf", &r);

    // create an array S of n POINTs
    POINT *S = (POINT*)malloc(n * sizeof(POINT));
    for(i = 0; i < n; i++)
        scanf("%lf %lf", &S[i].x, &S[i].y);
    
    // sort (using merge-sort) the S array
    mergesort(S, 0, n-1);
    printf("\n+++ Circles after sorting\n");
    printPointArray(S, n);

    // compute the upper hull (UH) and lower hull (LH)
    // allocate space for the UH and LH inside the function CH() - length of the final stack in Graham Scan
    // upper and lower flag to compute UH and LH respectively
    POINT *UH = (POINT*)malloc(n * sizeof(POINT));
    POINT *LH = (POINT*)malloc(n * sizeof(POINT));
    int upper = 1, lower = 0;
    int u = CH(S, n, upper, UH);
    int l = CH(S, n, lower, LH);

    // print the UH and LH
    printf("\n+++ Upper hull\n");
    printPointArray(UH, u);
    printf("\n+++ Lower hull\n");
    printPointArray(LH, l);

    // if anyone of the hull is not created
    // error message for messing with the program
    // return
    if(u == 0 || l == 0)
    {
        printf("\nDo not proceed!\nHalt! Make some valid inputs, so that I can find the hulls\n");
        return 0;
    }

    // find the containment zone
    // the number of tangents will be 2 less than the number of arcs
    // and print the containment zone
    ARC *A = (ARC*)malloc((u + l) * sizeof(ARC));               // arcs
    LINE *T = (LINE*)malloc((u + l - 2) * sizeof(LINE));        // tangents
    contzone(UH, u, LH, l, r, T, A);
    printcontzone(u, l, T, A);

    printf("\n--------------------------------------------------\n++ Thank You! Hope You Enjoyed! Stay Safe! ++\n--------------------------------------------------\n");
    return 0;
}